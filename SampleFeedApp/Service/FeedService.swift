//
//  Created by Karthik on 05/04/22.
//

import Foundation
import FeedKit
import Combine

protocol FeedFetchable {
    func fetchFeeds(_ completion: ((Result<[Feed], Error>) -> Void)?) 
}

class FeedCache: FeedFetchable {
    
    func fetchFeeds(_ completion: ((Result<[Feed], Error>) -> Void)?) {
        print("loading feeds from local")        
        completion?(.success(retriveCachedFeeds()))
    }

    func retriveCachedFeeds() -> [Feed] {
        let key = Key<[Feed]>("feed_cache_key")
        let feeds = Defaults.shared.get(for: key) ?? []
        return feeds
    }
}

class FeedServer: FeedFetchable {
    
    private lazy var lists: [String] = [
        "https://medium.com/feed/backchannel",
        "https://medium.com/feed/the-economist",
        "https://medium.com/feed/matter"
    ]
    
    func fetchFeeds(_ completion: ((Result<[Feed], Error>) -> Void)?) {
        let tasks: [Task<FeedKit.Feed>] = lists
            .map { FeedParser(URL: URL(string: $0)!) }
            .map { parser in Task { parser.parseAsync(result: $0) } }
        
        Task.group(tasks).perform(on: .default) { result in
            switch result {
            case .failure(let error):
                completion?(.failure(error))
            case .success(let feeds):
                let baseFeeds = feeds.compactMap { $0.rssFeed }.compactMap { Feed($0) }   
                completion?(.success(baseFeeds))    
            }  
        }
    }    
}

class FeedService: ObservableObject {

    var isFetchedAvailableInLocal: Bool {
        UserDefaults.standard.bool(forKey: "is_feed_fetched")
    }
    
    let localStorage: FeedFetchable
    let feedServer: FeedFetchable
    let feedSubject = PassthroughSubject<[Feed], Error>()
    
    init(
        localStorage: FeedFetchable = FeedCache(),
        feedServer: FeedFetchable = FeedServer()
    ) {
        self.localStorage = localStorage
        self.feedServer = feedServer
        print("FeedService object created")
    }
    
    private func handleFeeds(_ result: Result<[Feed], Error>, canCache: Bool) {
        switch result {
        case .failure(let error):
            self.feedSubject.send(completion: .failure(error))
        case .success(let feeds):   
            if canCache {
                UserDefaults.standard.set(true, forKey: "is_feed_fetched")
                let key = Key<[Feed]>("feed_cache_key")
                Defaults.shared.set(feeds, for: key)                
            }
            self.feedSubject.send(feeds)
        }
    }

    func fetchFeeds() {
        let fetcher: FeedFetchable = isFetchedAvailableInLocal ? localStorage : feedServer
        fetcher.fetchFeeds { 
            self.handleFeeds($0, canCache: !self.isFetchedAvailableInLocal)
        }
    }
    
    deinit {
        print("Feed service deinited")
    }
}

//
//  Created by Karthik on 05/04/22.
//

import Foundation
import FeedKit
import Combine

/// ViewModel which helps to co-ordinate the feed fething and showing logic
/// Object subscribes to `FeedFetchPassthroughSubject` to get the updated feeds
/// 
class FeedListViewModel: ObservableObject {    
    @Published var feedFetchState: FeedFetchState = .fetching
    @Published var feeds: [Feed] = []
    
    let feedService: FeedService
    private var subscriptions = Set<AnyCancellable>()
    
    init(feedService: FeedService) {
        self.feedService = feedService 
        self.feedService.feedSubject.sink { result in
            if case let .failure(error) = result {
                self.feedFetchState = .error
                print(error)
            }
        } receiveValue: { feeds in
            self.feeds = feeds
            self.feedFetchState = .completed
        }.store(in: &subscriptions)
    }
        
    func fetchFeeds() {
        self.feedFetchState = .fetching
        self.feedService.fetchFeeds()
    }
}

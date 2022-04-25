//
//  Created by Karthik on 06/04/22.
//

import Foundation

class BookMarkListViewModel: ObservableObject {
        
    private let feedLocalStorage: FeedCache
    private let bookmarkService: BookMarkService
    @Published var articles: [Article] = []
    
    init(
        feedLocalStorage: FeedCache,
         bookmarkService: BookMarkService
    ) {
        self.feedLocalStorage = feedLocalStorage
        self.bookmarkService = bookmarkService
    }    
    
    /// Loading bookmarked article form cached feeds once after sorting the bookmarked articles
    /// with the help of local prefernce
    /// Doing in async since sorting might be little consuming
    func loadBookMakedArticles() {
        let bookMarks = bookmarkService.bookMarks
        let articles = feedLocalStorage.retriveCachedFeeds().map { $0.articles }
        self.articles = articles.join().filter { bookMarks.contains($0.url.absoluteString) }   
    }
}

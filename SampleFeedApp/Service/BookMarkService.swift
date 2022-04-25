//
//  Created by Karthik on 06/04/22.
//

import Foundation

class BookMarkService {
    static let shared = BookMarkService()
    private let bookMarkCacheKey = Key<Set<String>>("bookmarks_cache_key")
    
    var bookMarks: Set<String> {
        Defaults.shared.get(for: bookMarkCacheKey) ?? Set()
    }
    
    func isBookMarked(_ url: URL) -> Bool {
        return bookMarks.contains(url.absoluteString)
    }
    
    func updateBookMark(_ url: URL) {
        var bookMarks = self.bookMarks
        if bookMarks.contains(url.absoluteString) {
            print("\(url.absoluteString) Already bookmarked")
            bookMarks.remove(url.absoluteString)
            Defaults.shared.set(bookMarks, for: bookMarkCacheKey)
        } else {
            print("BookMarking: \(url.absoluteString)")
            bookMarks.insert(url.absoluteString)
            Defaults.shared.set(bookMarks, for: bookMarkCacheKey)
        }
    }
}

//
//  Created by Karthik on 05/04/22.
//

import Foundation
import FeedKit
import SwiftUI

class Article: Codable, Identifiable, ObservableObject {
    var id = UUID()
    var title: String
    var description: String?
    var url: URL
    var date: Date = .now
    var lastUpdateDate: Date = .now
    var content: String
    var author: String? = nil
    var isBookmarked: Bool {
        BookMarkService.shared.isBookMarked(url)
    }

    init?(_ feed: RSSFeedItem) {
        self.title =  feed.title ?? ""
        self.description = feed.description?.trimHTMLTags.trimWhiteAndSpace
        self.date = feed.pubDate ?? Date.now
        self.lastUpdateDate = Date.now
        self.content = feed.content?.contentEncoded ?? ""
        self.author = feed.author
        if let link = feed.link, let url = URL(string: link) {
            self.url = url
        } else {
            return nil
        }        
    }
    
    init(title: String, url: String, content: String = "") {
        self.title = title
        self.url = URL(string: url)!
        self.content = content
    }
    
    var formatedDate: String {
        if Calendar.current.isDateInToday(date) {
            return "Today at :" + date.toString(format: "HH:mm a")
        } else {
            return "Published at: \(date.toString(format: "dd/MM/yyyy"))" 
        }
    }
    
    static var mock: Article {
        return Article(
            title: "Mock Feed",
            url: "https://medium.com/feed/backchannel" 
        )
    }
}

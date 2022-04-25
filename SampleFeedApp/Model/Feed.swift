//
//  Created by Karthik on 05/04/22.
//

import Foundation
import Combine
import FeedKit

class Feed: Identifiable, Codable, ObservableObject {
    var id: UUID = UUID()
    var name: String
    var description: String = ""
    var url: URL
    var imageURL: URL? = nil
    var pubDate: Date
    var lastUpdateDate: Date
    var articles: [Article] 

    init?(_ feed: RSSFeed) {
        guard let urlString = feed.link, let feedUrl = URL(string: urlString) else { return nil  }
        self.url = feedUrl
        self.name =  feed.title ?? ""
        self.description = feed.description ?? ""
        self.pubDate = feed.pubDate ?? .now
        self.lastUpdateDate = feed.lastBuildDate ?? .now
        self.articles = feed.items?
            .compactMap { Article($0) }
            .sorted(by: { Calendar.current.compare($0.date, to: $1.date, toGranularity: .minute) == ComparisonResult.orderedDescending }) ?? []
        if let urlStr = feed.image?.url, let url = URL(string: urlStr) {
            self.imageURL = url
        }        
    }
    
    init(name: String, url: URL, feeds: [Article] = []) {
        self.name = name
        self.url = url
        self.articles = feeds
        self.pubDate = .now
        self.lastUpdateDate = .now
    }
    
    var formatedDate: String {
        if Calendar.current.isDateInToday(lastUpdateDate) {
            return "Today at :" + lastUpdateDate.toString(format: "HH:mm a")
        } else {
            return "Published at: \(lastUpdateDate.toString(format: "dd/MM/yyyy"))"
        }
    }
    
    static var mock: Feed {
        return Feed(
            name: "Mock feed",
            url: URL(string: "https://medium.com/feed/backchannel")!,
            feeds: [
                Article.mock, 
                Article.mock,
                Article.mock                
            ]
        )
    }
}

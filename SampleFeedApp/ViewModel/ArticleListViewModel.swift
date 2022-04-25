//
//  Created by Karthik on 06/04/22.
//

import Foundation

class ArticleListViewModel: ObservableObject {
    let title: String    
    let articles: [Article]
    
    init(_ title: String, articles: [Article]) {
        self.title = title
        self.articles = articles
    }
}

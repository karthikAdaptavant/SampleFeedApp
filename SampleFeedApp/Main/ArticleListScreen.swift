//
//  Created by Karthik on 06/04/22.
//

import SwiftUI
import CoreKit

/// Screen that shows the article which found inside the feed object 
struct ArticleListView: View {    
    var articles: [Article]
    
    fileprivate func destinationScreen(_ article: Article) -> ArticleView {
        return ArticleView(viewModel: .init(article))
    }
    
    var body: some View {
        List {
            ForEach(articles) { article in
                NavigationLink(destination: destinationScreen(article)) { 
                    ArticleListItem(article: article)
                }                        
            }
        }.emptyListPlaceholder(articles, AnyView(PlaceHolderView(type: .empty)))
    }
}

struct ArticleListScreen: View {    
    var viewModel: ArticleListViewModel
    
    var body: some View {
        ZStack {
            ArticleListView(articles: viewModel.articles)            
                .navigationTitle(viewModel.title)
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

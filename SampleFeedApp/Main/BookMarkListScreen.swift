//
//  Created by Karthik on 06/04/22.
//

import SwiftUI

struct BookMarkListScreen: View {
    @StateObject var viewModel: BookMarkListViewModel
    
    var body: some View {
        VStack {
            ArticleListView(articles: viewModel.articles)
                .navigationBarTitleDisplayMode(.large)
                .onAppear { 
                    viewModel.loadBookMakedArticles()
                }
        }       
    }
}

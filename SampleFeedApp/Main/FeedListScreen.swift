//
//  Created by Karthik on 05/04/22.
//

import SwiftUI
import CoreData
import CoreKit

struct FeedListView: View {    
    var feeds: [Feed]

    fileprivate func destinationScreen(_ feed: Feed) -> ArticleListScreen {
        return ArticleListScreen(viewModel: .init(feed.name, articles: feed.articles))
    }
    
    var body: some View {
        List {
            ForEach(feeds) { feed in                            
                NavigationLink(destination: destinationScreen(feed)) {
                    FeedListItem(feed: feed)                                   
                }
            }
        }.emptyListPlaceholder(feeds, AnyView(PlaceHolderView(type: .empty)))
    }
}

struct FeedListScreen: View {
    @StateObject var viewModel: FeedListViewModel
    
    var body: some View {
        VStack {
            ZStack {
                switch viewModel.feedFetchState {
                case .fetching:
                    ProgressView().scaleEffect(1.5, anchor: .center)
                case .error:
                    PlaceHolderView(type: .error)
                case .completed:
                    FeedListView(feeds: viewModel.feeds)
                }
            }                
        }
        .navigationBarTitleDisplayMode(.large)
        .onAppear { 
            viewModel.fetchFeeds()
        }
    }
}

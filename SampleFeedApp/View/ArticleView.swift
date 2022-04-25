//
//  Created by Karthik on 06/04/22.
//

import SwiftUI
import WebKit

struct ArticleView: View {    
    @StateObject var viewModel: ArticleViewModel
    @State private var size: CGSize = .zero
    @State private var webViewHeight: CGFloat = .zero
    @State var offset: CGPoint = .zero
    
    /// Title, and CTA buttons (bookmark, share)
    var titleView: some View {
        HStack {
            Text(viewModel.post.title)
                .bold()
                .font(.title2)
            Spacer() // for edgingout 
            HStack(spacing: 10) {
                Button { 
                    viewModel.share()
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title2)     
                }
                Button {
                    viewModel.bookMarkThisArticle()
                } label: {
                    Image(systemName: viewModel.post.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.title2)
                } 
            }                                        
        }
    }
    
    /// Article published date 
    var dateView: some View {
        Text(viewModel.post.formatedDate)
            .font(.subheadline)
            .foregroundColor(.gray)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            titleView
            Spacer(minLength: 10)
            dateView
            Divider()
            WebView(url: viewModel.post.url.absoluteString)    
        }.padding(.horizontal)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
         ArticleView(viewModel: .init(.mock))        
    }
}

//
//  Created by Karthik on 06/04/22.
//

import SwiftUI

struct ArticleListItem: View {
    @ObservedObject var article: Article

    var body: some View {
        HStack(spacing: 10) {         
            VStack(alignment: .leading, spacing: 10) {
                titleView
                descriptionView()
                dateView                
            }.padding(.all, 10)            
            Spacer()
        }        
    }
}

extension ArticleListItem {
    
    var titleView: some View {
        Text(article.title)
            .font(.headline)
            .foregroundColor(Color(.label).opacity(0.8))
    }
    
    var dateView: some View {
        Text(article.formatedDate)
            .font(.footnote)
            .foregroundColor(.gray)
    }
    
    /// Adding description only when article has description in it.
    func descriptionView() -> some View {
        article.description.map(DescriptionView.init)        
    }
}

struct ArticleListItem_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListItem(article: .mock)
    }
}   

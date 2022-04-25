//
//  Created by Karthik on 05/04/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct FeedListItem: View {
    @ObservedObject var feed: Feed

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                feedImage    
                titleAndDescription.padding(.all)
                Spacer()
            }
            dateView
        }
    }
}

extension FeedListItem {
    
    var dateView: some View {
        Text(feed.formatedDate)
            .font(.footnote)
            .foregroundColor(.gray)
    }
    
    var titleAndDescription: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(feed.name)
                .font(.headline)
            Text(feed.description)
                .font(.subheadline)
                .foregroundColor(Color.subHeadlineColor)
                .lineLimit(3)                
        }
    }
    
    var feedImage: some View {
        WebImage(url: feed.imageURL)
            .placeholder {
                Rectangle().foregroundColor(.gray)                     
            }
            .renderingMode(.original)
            .resizable().aspectRatio(contentMode: .fit)
            .frame(width: 60, height: 60)
            .padding(.all)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.secondary.opacity(0.3), lineWidth: 1)
            )         
    }
}

struct FeedListItem_Previews: PreviewProvider {
    static var previews: some View {        
        FeedListItem(feed: .mock)
    }
}

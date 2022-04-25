//
//  Created by Karthik on 06/04/22.
//

import UIKit

class ArticleViewModel: ObservableObject {
    
    /// Used for updating the article view when bookmark happens
    @Published var isBookMarked: Bool
    var post: Article    
    private let bookMarkService: BookMarkService
    
    init(_ post: Article, bookMarkService: BookMarkService = BookMarkService.shared) {
        self.post = post
        self.isBookMarked = post.isBookmarked
        self.bookMarkService = bookMarkService
    }
    
    func bookMarkThisArticle() {
        bookMarkService.updateBookMark(post.url)        
        isBookMarked.toggle()        
    }
    
    func share() {
        let activityVC = UIActivityViewController(activityItems: [post.url], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
}

//
//  Created by Karthik on 07/04/22.
//

import Foundation

struct FeedError: Error {    
    let message: String
    init(message: String) {
        self.message = message
    }  
    static let feedFetchFailed = FeedError(message: "Unable to fetch feeds")
}

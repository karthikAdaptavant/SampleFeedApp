//
//  Created by Karthik on 06/04/22.
//

import Foundation

enum FeedFetchState {
    case fetching
    case error
    case completed
    
    var isFetching: Bool {
        return self == .fetching
    }
}

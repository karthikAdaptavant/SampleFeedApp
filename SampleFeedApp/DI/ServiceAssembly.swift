//
//  Created by Karthik on 06/04/22.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class ServiceAssembly: Assembly {
    
    enum Name: String {
        case feedCache
        case feedServer
    }
    
    func assemble(container: Container) {
        container.autoregister(FeedFetchable.self, name: Name.feedCache.rawValue, initializer: FeedCache.init).inObjectScope(.singleton)
        container.autoregister(FeedFetchable.self, name: Name.feedServer.rawValue, initializer: FeedServer.init).inObjectScope(.singleton)
        container.autoregister(BookMarkService.self, initializer: BookMarkService.init)
        container.register(FeedService.self) { r in
            return FeedService(
                localStorage: r.resolve(FeedFetchable.self, name: Name.feedCache.rawValue)!, 
                feedServer: r.resolve(FeedFetchable.self, name: Name.feedServer.rawValue)!
            )
        }
    }
} 

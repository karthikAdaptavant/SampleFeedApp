//
//  Created by Karthik on 06/04/22.
//

import Foundation
import DIKit
import Swinject
import SwinjectAutoregistration

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(FeedListViewModel.self, initializer: FeedListViewModel.init)
        container.register(BookMarkListViewModel.self) { r in
            let feedCache: FeedFetchable = r.resolve(
                FeedFetchable.self,
                name: ServiceAssembly.Name.feedCache.rawValue
            )!
            return BookMarkListViewModel(
                feedLocalStorage: feedCache as! FeedCache,
                bookmarkService: r.resolve()
            )
        }
        container.autoregister(SettingsViewModel.self, initializer: SettingsViewModel.init)
    }
}

extension Container {
    func resolve<Dependency>() -> Dependency {
        return resolve(Dependency.self)!
    }
}

extension Resolver {
    func resolve<Dependency>() -> Dependency {
        return resolve(Dependency.self)!
    }
}

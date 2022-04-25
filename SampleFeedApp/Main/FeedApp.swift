//
//  Created by Karthik on 05/04/22.
//

import UIKit
import SwiftUI
import Swinject

@main
struct SampleFeedApp: App {
    
    /// Adaptor to work with Appdelegate, SceneDelegate and it's lifecycle
    /// After the app launch, first AppDelegate followed by sceneDelegate will be called
    /// Once after that only this class body will be exectuted. 
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            TabBarView()            
        }
    }
}

extension Color {
    static var subHeadlineColor: Color {
        Color("color_subheadline")
    }
}

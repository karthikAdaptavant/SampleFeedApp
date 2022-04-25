//
//  Created by Karthik on 07/04/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {    
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        UITableView.appearance().separatorColor = UIColor(named: "color_appbackground")
        UITableView.appearance().backgroundColor = .clear
    }
}

//
//  Created by Karthik on 07/04/22.
//

import UIKit
import Swinject
import DIKit


class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        
        SwiftDI.shared.setup(assemblies: [
            ServiceAssembly(),
            ViewModelAssembly()
        ], inContainer: Container())
        hideAutolayoutWarnings()
        removeTableViewExtraTopPadding()            
        return true
    }
    
    private func removeTableViewExtraTopPadding() {
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = .leastNonzeroMagnitude;
        }
    }
    
    private func hideAutolayoutWarnings() {
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
    }
}

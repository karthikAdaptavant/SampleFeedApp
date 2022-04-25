//
//  Created by Karthik on 06/04/22.
//

import SwiftUI
import Combine
import WebKit

class WKWebViewModel: ObservableObject {
    @Published var link: String = ""
    
    init(url: String) {
        self.link = url            
    }
}

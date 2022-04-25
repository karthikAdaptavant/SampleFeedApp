//
//  Created by Karthik on 06/04/22.
//

import Foundation
import SwiftUI

struct WebView: View {
    @ObservedObject var viewModel: WKWebViewModel
    var webViewWrapper: WKWebViewWrapper
    
    init(url: String) {
        let viewModel = WKWebViewModel(url: url)
        self.viewModel = viewModel
        self.webViewWrapper = WKWebViewWrapper(viewModel: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            webViewWrapper
        }
    }
}

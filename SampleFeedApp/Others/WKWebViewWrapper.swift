//
//  Created by Karthik on 06/04/22.
//

import Foundation
import SwiftUI
import Combine
import WebKit

struct WKWebViewWrapper: UIViewRepresentable {
    
    class Coordinator: NSObject, WKNavigationDelegate, UIScrollViewDelegate {
        private var viewModel: WKWebViewModel
        
        init(_ viewModel: WKWebViewModel) {
            self.viewModel = viewModel
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            
        }
    }
    
    @ObservedObject var viewModel: WKWebViewModel    
    let webView = WKWebView()
    
    func makeUIView(context: Context) -> WKWebView {
        self.webView.navigationDelegate = context.coordinator
        self.webView.scrollView.delegate = context.coordinator
        if let url = URL(string: viewModel.link) {
            self.webView.load(URLRequest(url: url))
        }
        return self.webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    static func dismantleUIView(_ uiView: WKWebView, coordinator: Coordinator) {
        
    }
    
    func makeCoordinator() -> WKWebViewWrapper.Coordinator {
        return Coordinator(viewModel)
    }
}

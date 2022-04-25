//
//  Created by Karthik on 06/04/22.
//

import SwiftUI
import DIKit

struct TabBarView: View {
    @State private var currentTab: Tab = .feeds
    @State private var isSheetPresented = false
    
    @Inject var feedListViewModel: FeedListViewModel
    @Inject var bookMarksViewModel: BookMarkListViewModel
    @Inject var settingsViewModel: SettingsViewModel
    
    enum Tab: String {
        case feeds, bookmark, settings
    }

    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {
                feedScreen
                bookMarkScreen
                settingScreen               
            }
            .navigationBarTitle(currentTab.rawValue.capitalized, displayMode: .large)
            .edgesIgnoringSafeArea(.top)             
        }        
    }
}

extension TabBarView {
 
    var feedScreen: some View {
        FeedListScreen(viewModel: feedListViewModel)
            .tabItem {
                Image(systemName: "chart.bar.doc.horizontal.fill")
                Text("Feeds")
            }.tag(Tab.feeds)
    }
    
    var bookMarkScreen: some View {
        BookMarkListScreen(viewModel: bookMarksViewModel)            
            .tabItem {
                Image(systemName: "bookmark.circle.fill")
                Text("BookMarks")
            }.tag(Tab.bookmark)
    }
    
    var settingScreen: some View {
        SettingsView(viewModel: settingsViewModel)
            .tabItem {
                Image(systemName: "ellipsis.circle.fill")
                Text("Settings")
            }.tag(Tab.settings)
    }
}

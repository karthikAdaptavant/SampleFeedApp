//
//  Created by Karthik on 06/04/22.
//

import SwiftUI
import CoreKit

class SettingsViewModel: ObservableObject {
    
    func clearCache() {
        UserDefaults.standard.removeObject(forKey: "is_feed_fetched")
        print("clearning feed cache flag")
    }
}

struct SettingsView: View {    
    @State var reset: Bool = false
    @StateObject var viewModel: SettingsViewModel

    var body: some View {       
        ZStack {
            VStack {                
                Form {
                    Button(action: {}) {
                        Text("Reset Cache")
                    }
                    .font(.headline)
                    .foregroundColor(Color.red)
                    .onTapGesture {                        
                        viewModel.clearCache()
                        reset.toggle()                        
                    }
                }
            }
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

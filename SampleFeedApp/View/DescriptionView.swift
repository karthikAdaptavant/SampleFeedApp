//
//  Created by Karthik on 07/04/22.
//

import SwiftUI
import CoreKit

struct DescriptionView: View {
    var description: String
    
    var body: some View {
        Text(description)
            .font(.subheadline)
            .foregroundColor(Color.subHeadlineColor)
            .lineLimit(2)
    }
}

struct DescriptionView_Previews: PreviewProvider {
    static var previews: some View {
        DescriptionView(description: "Test")
    }
}

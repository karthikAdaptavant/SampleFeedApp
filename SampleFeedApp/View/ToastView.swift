//
//  Created by Karthik on 07/04/22.
//

import Foundation
import SwiftUI

/// Using ViewModifier to add the toast on top of caller view.
extension View {
    func toast<T:View>(
        showToast: Binding<Bool>,
        duration: TimeInterval = 5,
        position: ToastView<T>.ToastPosition = .top,
        @ViewBuilder toastContent: @escaping () -> T
    ) -> some View {
        modifier(ToastView(
            showToast: showToast,
            toastContent: toastContent(),
            duration: duration,
            position: position
        ))        
    }
}

struct ToastView<T: View>: ViewModifier {
    @Binding var showToast: Bool
    @State var timer: Timer?
    let toastContent: T    
    let duration: TimeInterval
    let position: ToastPosition
    
    enum ToastPosition{
        case top, middle, bottom
    }
    
    func body(content: Content) -> some View {
        GeometryReader{ geo in            
            ZStack{
                content
                if showToast {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(UIColor.systemBackground))
                        .shadow(radius: 10)
                        .overlay(toastContent.minimumScaleFactor(0.2))
                        .frame(maxWidth: geo.size.width*0.4, maxHeight: 55, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)                    
                        .position(x: geo.size.width/2, y: getYPosition(height: geo.size.height, safeAreaInset: geo.safeAreaInsets))
                        .onAppear(perform: { 
                            timer = Timer.scheduledTimer(withTimeInterval: duration, repeats: false, block: {_ in
                                showToast = false
                            })
                        })
                        .onDisappear(perform: { 
                            timer?.invalidate()
                            timer = nil
                        })
                }
            }.onTapGesture {
                showToast = false
            }
        }        
    }
    
    private func getYPosition(height: CGFloat, safeAreaInset: EdgeInsets) -> CGFloat{
        var result: CGFloat = 0
        if position == .top{
            result = 0 + safeAreaInset.top
        }else if position == .bottom{
            result = height - safeAreaInset.bottom
        }else if position == .middle{
            result = height/2
        }
        return result
    }
}

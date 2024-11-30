//
//  ContentView.swift
//  ReferralAndRewardsWatchApp WatchKit Extension
//
//  Created by Ismail Gok on 2022-08-27.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @State private var currentPage = 0
    @ObservedObject var model = ViewModelWatch()
    var body: some View {
        ZStack
        {
            if(self.model.phone != "")
            {
                Color.white
                    .ignoresSafeArea()
                PagerView(pageCount: 1, currentIndex: $currentPage) {
                    QRCodeView(phone: self.model.phone)
//                    Balance(dollars: self.model.dollars, points: self.model.points)
                }
            }
            else
            {
                Text("Please connect your Iphone and login to your account to load and/or update your data.")
            }
        }
    }
}
struct PagerView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content
    
    init(pageCount: Int, currentIndex: Binding<Int>, @ViewBuilder content: () -> Content) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }
    @GestureState private var translation: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                self.content.frame(width: geometry.size.width)
            }
            .frame(width: geometry.size.width, alignment: .leading)
            .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
            .offset(x: self.translation)
            .animation(.interactiveSpring(), value: currentIndex)
            .animation(.interactiveSpring(), value: translation)
            .gesture(
                DragGesture().updating(self.$translation) { value, state, _ in
                    state = value.translation.width
                }.onEnded { value in
                    let offset = value.translation.width / geometry.size.width
                    let newIndex = (CGFloat(self.currentIndex) - offset).rounded()
                    self.currentIndex = min(max(Int(newIndex), 0), self.pageCount - 1)
                }
            )
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

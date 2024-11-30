//
//  StoreView.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-20.
//

import SwiftUI

struct CustomerAccountView: View {
    @State private var currentPage = 0
    @EnvironmentObject var account:Account
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack{
            //            Color.MyGrey
            //                .edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack
                {
                    Button(action: {Back()}, label: {
                            Text("Back")
                                .foregroundColor(.white)
                                .font(.largeTitle)
                                .frame(minWidth: 90, maxWidth: 90, minHeight: 50, maxHeight: 50)
                                .background(RoundedRectangle(cornerRadius: 2)).foregroundColor(.MyBlue)})
                        .padding(.leading, 30.0)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    CustAccountInfo().environmentObject(custAccount)
                        .fixedSize(horizontal: false, vertical: true)
                    CustBalance().environmentObject(custAccount)
                        .fixedSize(horizontal: false, vertical: true)
                    Membership().environmentObject(custAccount)
                        .fixedSize(horizontal: false, vertical: true)
                    if(!account.isCust)
                    {
                        Plans().environmentObject(storeAccount).environmentObject(custAccount)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Stampsheets().environmentObject(storeAccount).environmentObject(custAccount)
                        .fixedSize(horizontal: false, vertical: true)
                    Redeemables().environmentObject(storeAccount).environmentObject(custAccount)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    func Back() -> Void{
        self.presentationMode.wrappedValue.dismiss()
    }
}
func GetLabelColor(withParameters page: Int, curPage: Int) -> Color {
    var temp:Color = Color.gray
    if(page != curPage)
    {
        temp = Color.MyBlue
    }
    return temp
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
struct CustomerAccountView_Preview: PreviewProvider {
    static var previews: some View {
        var account = Account()
        var storeAccount = StoreAccount()//for preview testing
        var custAccount = CustomerAccount()//for preview testing
        CustomerAccountView().environmentObject(custAccount).environmentObject(storeAccount).environmentObject(account)
    }
}

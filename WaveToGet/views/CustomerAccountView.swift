//
//  StoreView.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-20.
//

import SwiftUI

struct CustomerAccountView: View {
    @EnvironmentObject var account:Account
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var goBack:Bool
    
    @State var noteObj: NoteObj?
    
    var pad:CGFloat = 10
    var body: some View {
        VStack{
            if(!account.settings) {
                CustAccountInfo().environmentObject(custAccount).environmentObject(account)
                    .padding(.horizontal,pad)
                    .padding(.top, 5.0)
            }
            switch(account.currentPage)
            {
            case 1:
                CustBalance().environmentObject(custAccount)
                    .padding(.horizontal,pad)
            case 2:
                Stampsheets().environmentObject(storeAccount).environmentObject(custAccount)
                    .padding(.horizontal,pad)
            case 3:
                Redeemables().environmentObject(storeAccount).environmentObject(custAccount)
                    .padding(.horizontal,pad)
            case 4:
                Activity().environmentObject(custAccount).environmentObject(storeAccount)
                    .padding(.horizontal,pad)
            case 5:
                More().environmentObject(custAccount)
                    .padding(.horizontal,pad)
            case 6:
                Notes(noteObj: $noteObj).environmentObject(custAccount)
                    .padding(.horizontal,pad)
            case 7:
                EditNoteView(noteObj: $noteObj).environmentObject(custAccount)
                    .padding(.horizontal,pad)
            default:
                More().environmentObject(custAccount)
                    .padding(.horizontal,pad)
            }
            HStack(spacing: 2)
            {
                Button(action: {account.currentPage = 1}, label: {
                    ZStack
                    {
                        if(account.currentPage == 1)
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
//                                .stroke(Color.gray, lineWidth: 1)
                                .foregroundColor(.MyBlue)
                        }
                        else
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .stroke(Color.MyBlue, lineWidth: 2)
//                                .foregroundColor(.MyBlue)
                        }
                        HStack(spacing:2)
                        {
                        Image("homeIcon")
                            .resizable()
                            .scaledToFit()
                            .colorMultiply(account.currentPage == 1 ? .white : .MyBlue)
                            .frame(width: 30, height: 30)
                        Text("Home")
                            .fontWeight(.semibold)
                            .foregroundColor(account.currentPage == 1 ? .white : .MyBlue)
                            .font(.system(size: 13))
                        }
                    } //: ZStack
//                    frame(height: 40)
                })
                
                Button(action: {account.currentPage = 2}, label: {
                    ZStack
                    {
                        if(account.currentPage == 2)
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
//                                .stroke(Color.gray, lineWidth: 1)
                                .foregroundColor(.MyBlue)
                        }
                        else
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .stroke(Color.MyBlue, lineWidth: 2)
//                                .foregroundColor(.MyBlue)
                        }
                        Text("Rewards")
                            .fontWeight(.semibold)
                            .foregroundColor(account.currentPage == 2 ? .white : .MyBlue)
                            .font(.system(size: 13))
                    } //: ZStack
//                    frame(height: 40)
                })
                
                Button(action: {account.currentPage = 3}, label: {
                    ZStack
                    {
                        if(account.currentPage == 3)
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .foregroundColor(.MyBlue)
//                                .stroke(Color.gray, lineWidth: 1)
                        }
                        else
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .stroke(Color.MyBlue, lineWidth: 2)
//                                .foregroundColor(.MyBlue)
                        }
                        Text("Redeem")
                            .fontWeight(.semibold)
                            .foregroundColor(account.currentPage == 3 ? .white : .MyBlue)
                            .font(.system(size: 13))
                    } //: ZStack
//                    frame(height: 40)
                })
                
                Button(action: {account.currentPage = 5}, label: {
                    ZStack
                    {
                        if(account.currentPage >= 5)
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .foregroundColor(.MyBlue)
//                                .stroke(Color.gray, lineWidth: 1)
                        }
                        else
                        {
                            RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                .stroke(Color.MyBlue, lineWidth: 2)
//                                .foregroundColor(.MyBlue)
                        }
                        Text("More")
                            .fontWeight(.semibold)
                            .foregroundColor(account.currentPage >= 5 ? .white : .MyBlue)
                            .font(.system(size: 13))
                    } //: ZStack
//                    frame(height: 40)
                })
            }
            .padding(.horizontal, 10.0)
            .padding(.bottom,5)
            .frame(height: 40.0)
        }
        .onChange(of: goBack, perform: { value in
            self.Back()
        })
        .padding(.top, 10.0)
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
        CustomerAccountView(goBack:.constant(false)).environmentObject(custAccount).environmentObject(storeAccount).environmentObject(account)
    }
}

//
//  Welcome.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-02-12.
//
import SwiftUI

struct Welcome: View {
    @EnvironmentObject var account:Account
    @State var chose = false
    var body: some View {
        ZStack
        {
//            RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
//                .foregroundColor(.white)
            VStack
            {
                Spacer()
                Text("Welcome to")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300.0)
                Spacer()
                Text("Are you")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                HStack
                {
                    NavigationLink(
                        destination: Login(), isActive: $chose){
                        Button(action: {chose = true; account.isCust = false})
                        {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)
                                VStack
                                {
                                    Text("STORE OWNER")
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.MyBlue)
                                        .padding([.top, .leading, .trailing])
                                    Image("store")
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                }
                            }
                        }
                        }
                    NavigationLink(
                        destination: Login(), isActive: $chose){
                        Button(action: {chose = true; account.isCust = true})
                        {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.MyBlue, lineWidth: 2)
//                                    .foregroundColor(.MyBlue)
                                VStack
                                {
                                    Text("STORE CLIENT")
                                        .font(.system(size: 15))
                                        .fontWeight(.semibold)
                                        .foregroundColor(.MyBlue)
                                        .padding([.top, .leading, .trailing])
                                    Image("customer")
                                        .resizable()
                                        .scaledToFit()
                                        .padding([.leading, .bottom, .trailing])
                                }
                            }
                        }
                        }
                }
                .padding(.horizontal, 10.0)
                .frame(height: 120.0)
                Spacer()
                Spacer()
            }
        }
        .padding(.horizontal,10)
    }
}
struct Welcome_Preview: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}


//
//  CustomerQR.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-02-26.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct CustomerQR: View {
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @Binding var QrString:String
    
    let filter = CIFilter.qrCodeGenerator()
    let context = CIContext()
    var body: some View {
        ZStack
        {
            //RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            VStack(alignment: .leading, spacing:0)
            {
                Image(uiImage: GenerateQRCodeImage(QrString))
                    .interpolation(.none)
                    .resizable()
//                    .frame(width:sizing.QRSize,height: sizing.QRSize)
                    .frame(maxWidth: sizing.QRSize, maxHeight: sizing.QRSize)
            }
        }
        //.padding(.horizontal, 10.0)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    func GenerateQRCodeImage(_ url:String) -> UIImage
    {
        let data = Data(url.utf8)
        filter.setValue(data, forKey: "inputMessage")
        if let qrCodeImage = filter.outputImage
        {
            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent)
            {
                return UIImage(cgImage: qrCodeCGImage)
            }
        }
        return UIImage(systemName: "xmark") ?? UIImage()
    }
}
//struct CustomerQR_Preview: PreviewProvider {
//    static var previews: some View {
//        var store = StoreAccount()
//        var acc = Account()
//        var custAcc = CustomerAccount()//for preview testing
//        CustomerQR().environmentObject(custAcc).environmentObject(store).environmentObject(acc)
//    }
//}

//
//  GenerateItemQR.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-05-05.
//
//
//import Foundation
import SwiftUI
//import CoreImage.CIFilterBuiltins
//struct GenerateItemQR: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @EnvironmentObject var custAccount:CustomerAccount
//    @EnvironmentObject var storeAccount:StoreAccount
//    @EnvironmentObject var account:Account
//    @EnvironmentObject var sizing:Sizing
//    @Binding var currentPage:Int
//    @State var code = ""
//    @State var amount = ""
//    @State var type = "points"
//    @State var generated = false
//    let filter = CIFilter.qrCodeGenerator()
//    let context = CIContext()
//    
//    @State var showingShareMenu = false
//    @State var shareSheetItems: [Any] = []
//    
//    class ImageSaver: NSObject {
//        func writeToPhotoAlbum(image: UIImage) {
//            UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
//        }
//
//        @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//            print("Save finished!")
//        }
//    }
//    
//    var body: some View {
//        VStack
//        {
//            ZStack
//            {
//                Button(action: {self.Back()}, label: {
//                    ZStack
//                    {
//                        RoundedRectangle(cornerRadius: 5)
//                            .foregroundColor(.MyBlue)
//                            .frame(width: 35, height: 35)
//                        Image("back2")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 22.0, height: 22.0)
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding([.top, .leading, .trailing], 10.0)
//                })
//                Text("GENERATE ITEM QR")
//                    .font(.system(size: 17))
//                    .padding(.top, 5.0)
//            }
//            HStack(spacing: 0)
//            {
//                TextField("Name", text: $code)
//                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.vertical, 5)
//                    .padding(.horizontal, 10.0)
//                    .disableAutocorrection(true)
//                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
//                TextField("Amount", text: $amount)
//                    .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding(.vertical, 5)
//                    .padding(.trailing, 10.0)
//                    .disableAutocorrection(true)
//                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
//                    .keyboardType(.numberPad)
//                Menu {
//                        Button { type = "points"
//                        } label: {
//                            Text("points")
//                        }
//                    Button { type = "dollars"
//                    } label: {
//                        Text("dollars")
//                    }
//                } label: {
//                    Text(type)
//                }
//                .padding(.trailing, 10.0)
//                Button(action: {GenerateCode()}, label: {
//                    ZStack
//                    {
//                        RoundedRectangle(cornerRadius: 7)
//                            .foregroundColor(.MyBlue)
//                        
//                        Text("GENERATE")
//                            .fontWeight(.semibold)
//                            .foregroundColor(.white)
//                            .font(.system(size: 13))
//                    }
//                })
//                .padding(.horizontal, 10.0)
//                .frame(height: 50.0)
//            }
//            if(generated)
//            {
//                CustomerQR()
//                HStack
//                {
//                    Button(action: {
//                            let qr = GenerateQRCodeImage(account.qrString)
//                            let imageSaver = ImageSaver()
//                            generated = false
//                            code = ""
//                            amount = ""
//                            imageSaver.writeToPhotoAlbum(image:qr)}, label: {
//                        ZStack
//                        {
//                            RoundedRectangle(cornerRadius: 10)
//                                .foregroundColor(.MyBlue)
//
//                            Text("Save image")
//                                .fontWeight(.semibold)
//                                .foregroundColor(.white)
//                                .font(.system(size: 15))
//                        }
//                    })
//                    .frame(height: 60.0)
//                    Button(action: {
//                            let qr = GenerateQRCodeImage(account.qrString)
//                        shareSheetItems = [qr]
//                        showingShareMenu = true
//                    }, label: {
//                        ZStack
//                        {
//                            RoundedRectangle(cornerRadius: 10)
//                                .foregroundColor(.MyBlue)
//
//                            Text("Share")
//                                .fontWeight(.semibold)
//                                .foregroundColor(.white)
//                                .font(.system(size: 15))
//                        }
//                    })
//                    .frame(height: 60.0)
//                    .sheet(isPresented: $showingShareMenu, content: {
//                        ActivityViewController(activityItems: self.$shareSheetItems)
//                    })
//                }
//                .padding(.horizontal, 10.0)
//            }
//            Spacer()
//        }
//    }
//    func GenerateCode()
//    {
//        account.qrString = code + "`" + amount + "`" + type
//        generated = true
//    }
//    func Back() -> Void{
//        currentPage = 0
//    }
//    func GenerateQRCodeImage(_ url:String) -> UIImage
//    {
//        let data = Data(url.utf8)
//        filter.setValue(data, forKey: "inputMessage")
//        let transform = CGAffineTransform(scaleX: 100, y: 100)
//        if let qrCodeImage = filter.outputImage?.transformed(by: transform)
//        {
//            if let qrCodeCGImage = context.createCGImage(qrCodeImage, from: qrCodeImage.extent)
//            {
//                return UIImage(cgImage: qrCodeCGImage)
//            }
//        }
//        return UIImage(systemName: "xmark") ?? UIImage()
//    }
//    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
//       let size = image.size
//
//       let widthRatio  = targetSize.width  / size.width
//       let heightRatio = targetSize.height / size.height
//
//       // Figure out what our orientation is, and use that to form the rectangle
//       var newSize: CGSize
//       if(widthRatio > heightRatio) {
//           newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
//       } else {
//           newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
//       }
//
//       // This is the rect that we've calculated out and this is what is actually used below
//       let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
//
//       // Actually do the resizing to the rect using the ImageContext stuff
//       UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//       image.draw(in: rect)
//       let newImage = UIGraphicsGetImageFromCurrentImageContext()
//       UIGraphicsEndImageContext()
//
//       return newImage!
//   }
//}
//
import UIKit

struct ActivityViewController: UIViewControllerRepresentable {

    @Binding var activityItems: [Any]
    var excludedActivityTypes: [UIActivity.ActivityType]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems,
                                                  applicationActivities: nil)

        controller.excludedActivityTypes = excludedActivityTypes
//        controller.excludedActivityTypes = [UIActivity.ActivityType.assignToContact, UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.openInIBooks,
//                                            UIActivity.ActivityType.postToVimeo,  UIActivity.ActivityType.postToFlickr,  UIActivity.ActivityType.postToWeibo]

        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}
}

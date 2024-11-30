//
//  QRCodeView.swift
//  ReferralAndRewardsWatchApp WatchKit Extension
//
//  Created by Ismail Gok on 2022-08-27.
//

import SwiftUI
import EFQRCode


struct QRCodeView: View {

    var phone:String
    var body: some View {
        ZStack
        {
            //RoundedRectangle(cornerRadius: 2).stroke(Color.MyGrey, lineWidth: 2)
            Image(uiImage: GenerateQRCodeImage(phone))
                .interpolation(.none)
                .resizable()
                .frame(width:150,height: 150)
                //.padding(.top, 40.0)
        }
    }
    func GenerateQRCodeImage(_ url:String) -> UIImage
    {
        return UIImage(cgImage: EFQRCode.generate(content: url)!)
    }
}
//struct QRCode_Preview: PreviewProvider {
//    static var previews: some View {
//        QRCodeView()
//    }
//}

extension UIImage {

    // Get avarage color
    func avarageColor() -> UIColor? {
        let rgba = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: 4)
        guard let context = CGContext(
            data: rgba,
            width: 1,
            height: 1,
            bitsPerComponent: 8,
            bytesPerRow: 4,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            ) else {
                return nil
        }
        if let cgImage = self.cgImage {
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: 1, height: 1))

            return UIColor(
                red: CGFloat(rgba[0]) / 255.0,
                green: CGFloat(rgba[1]) / 255.0,
                blue: CGFloat(rgba[2]) / 255.0,
                alpha: CGFloat(rgba[3]) / 255.0
            )
        }
        return nil
    }
}


import SwiftUI

struct Header: View {
    //@State var settings = false
    @EnvironmentObject var account:Account
    
    @State private var showingInfoPage = false
    
    var body: some View {
        VStack(spacing:0)
        {
            
            ZStack{
                if(account.Ipad)
                {
                    if(account.Landscape)
                    {
                        Image("header-ipad-landscape")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: UIScreen.main.bounds.width,
                                   maxHeight: UIScreen.main.bounds.height)
                            .edgesIgnoringSafeArea(.all)
                            .frame(alignment: .center)
                    }
                    else
                    {
                        Image("header-ipad-portrait")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxWidth: UIScreen.main.bounds.width,
                                   maxHeight: UIScreen.main.bounds.height)
                            .edgesIgnoringSafeArea(.all)
                            .frame(alignment: .center)
                    }
                }
                else
                {
                    Image("header-iphone")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: UIScreen.main.bounds.width,
                               maxHeight: UIScreen.main.bounds.height)
                        .edgesIgnoringSafeArea(.all)
                        .frame(alignment: .center)
                }

                HStack {
                    if account.infoPage == -1 {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                            .padding(.bottom, 20)
                    }
                    else {
                        Button {
                            showInfoContent()
                        } label: {
                            Image("infoButtonImage-white")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                                .padding()
                        }
                        
                        Spacer()
                        
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 70)
                            .padding(.bottom, 20)
                            .padding(.trailing, 50) // TODO: Find a better way to center the image
                        
                        Spacer()
                    }
                    
                } //: HStack

            }

        }
        .onAppear(perform: {
            checkIfIpad()
        })
        .frame(height: 60)
        .popover(isPresented: $showingInfoPage, arrowEdge: .bottom) {
            InfoView(presentMe: $showingInfoPage)
        }
    }
    func imageWithImage (sourceImage:UIImage, scaledToHeight: CGFloat) -> UIImage {
        let oldHeight = sourceImage.size.height
        let scaleFactor = scaledToHeight / oldHeight

        let newWidth = sourceImage.size.width * scaleFactor
        let newHeight = oldHeight * scaleFactor

        UIGraphicsBeginImageContext(CGSize(width:newWidth, height:newHeight))
        sourceImage.draw(in: CGRect(x:0, y:0, width:newWidth, height:newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    func checkIfIpad()
    {
        if(UIDevice.current.userInterfaceIdiom == .pad)
        {
            account.Ipad = true
            print("isIpad")
        }
    }
    
    func showInfoContent() {
        print("DEBUG: Info button is tapped on Header View.. infoPage = \(account.infoPage)")
        
        showingInfoPage = true
    }
}
enum UIUserInterfaceIdiom : Int {
    case unspecified
    
    case phone // iPhone and iPod touch style UI
    case pad   // iPad style UI (also includes macOS Catalyst)
}
//struct Header_Preview: PreviewProvider {
//    static var previews: some View {
//        var acc = Account()
//        Header().environmentObject(acc)
//    }
//}

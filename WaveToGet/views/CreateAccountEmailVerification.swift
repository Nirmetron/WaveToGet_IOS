

import SwiftUI

struct CreateAccountEmailVerification: View {
    @EnvironmentObject var account:Account
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var storeAccount:StoreAccount
    @EnvironmentObject var sizing:Sizing
    @State private var email = ""
    @State private var errorText = ""
    @Binding public var page:Int
    @State private var alert = false
    @State private var alerttext = ""
    var body: some View
    {
        VStack(spacing: 0)
        {
            ZStack
            {
            Button(action: {page = 0}, label: {
                ZStack
                {
                    Image("back6")
                        .resizable()
                        .frame(width: 35.0, height: 35.0)
                        .scaledToFit()
                        .frame(alignment: .top)
                        .colorMultiply(.MyBlue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            })
            Text("EMAIL VERIFICATION")
                .font(.system(size: 17))
                .padding(.top, 5.0)
            }
            ZStack
            {
                VStack(alignment: .leading, spacing:0)
                {
                    Text(errorText)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(.red)
                        .font(.system(size: sizing.smallTextSize))
                    Spacer()
                    Text("Enter an email for verification or an already verified email")
                        .font(.system(size: 15))
                        .padding(.vertical, 10)
                        .foregroundColor(.MyBlue)
                        .frame(maxWidth:.infinity, alignment: .center)
                    Spacer()
                    HStack(alignment: .top)
                    {
                        VStack
                        {
                            Group
                            {
                            
                                    HStack
                                    {
                                        Text("Email:")
                                            .foregroundColor(.MyBlue)
                                            .frame(width: account.Ipad ? sizing.ipadHorizontalInputForForm : sizing.horizontalInputForForm, alignment: .leading)
                                        TextField("Email:", text: $email)
                                            .textFieldStyle(RoundedBorderTextFieldStyle())
                                            .overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.MyGrey, lineWidth: 1))
                                            .disableAutocorrection(true)
                                            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                                            
                                    }
                            }
                        }
                    }
                    .frame(maxWidth:.infinity, alignment: .center)
                    Spacer()
                    Spacer()
                    Button(action: {page = 3}, label: {
                    Text("Click here if you already have a 6 digit code.")
                        .font(.system(size: 14))
                        .padding(.vertical, 30)
                        .foregroundColor(.MyBlue)
                        .frame(maxWidth:.infinity, alignment: .center)
                    })
                    HStack(spacing: 0)
                    {
                        Button(action: {CreateAccount()}, label: {
                            ZStack
                            {
                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
                                    .foregroundColor(.MyBlue)
                                    .frame(height: 60)
                                
                                Text("Continue")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                            }
                        })
                        .padding([.leading, .bottom])
                        .padding(.trailing, 5.0)
//                        Button(action: {Back()}, label: {
//                            ZStack
//                            {
//                                RoundedRectangle(cornerRadius: sizing.mediumCornerRadius)
//                                    .foregroundColor(.MyBlue)
//                                    .frame(height: 60)
//
//                                Text("Back")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(.white)
//                                    .font(.system(size: 20))
//                            }
//                        })
//                        .padding([.bottom, .trailing])
//                        .padding(.leading, 5.0)
                    }
                    .alert(isPresented: $alert) {

                        Alert(
                            title: Text(alerttext),
                            dismissButton: .default(Text("OK"), action: {
                                page = 3
                            })
                        )
                    }.padding()
                }
            }
        }
        .padding(.all,10)
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
    func Back() -> Void{
        page = 0
    }
    struct acc: Decodable {
        var id: Int?
        var name: String?
    }
    func CreateAccount() -> Void{
        if(email == "")
        {
            errorText = "Please fill in the email field"
            return
        }
        if(!isValidEmail(email))
        {
            errorText = "Please enter a valid email address..."
            return
        }
        errorText = ""
        APIRequest().Post(withParameters: ["action":"email-verification","email":email])
        {data in
            DispatchQueue.main.async {
                print("------------")
                print(data)
                print("------------")
                if(data == "" || data == "failed" || data == "false")
                {
                    errorText = "Something went wronng..."
                }
                else if(data == "verified")
                {
                    account.verifiedEmail = email
                    page = 4
                }
                else
                {
                    //send verify email
                    SendEmailCode(data)
                }
            }
        }
    }
    func SendEmailCode(_ genkey:String)
    {
        APIRequest().Post(withParameters: ["action":"send-client-verification-email","email":email, "genkey":genkey,"app":"2"])
        {data in
            DispatchQueue.main.async {
                print("------------")
                print(data)
                print("------------")
                alerttext = "An email has been sent to your email.  Please check your email for a 6 digit verification code."
                alert = true
            }
        }
    }
    func isValidEmail(_ string: String) -> Bool {
        if string.count > 100 {
            return false
        }
        let emailFormat = "(?:[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[\\p{L}0-9!#$%\\&'*+/=?\\^_`{|}" + "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" + "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[\\p{L}0-9](?:[a-" + "z0-9-]*[\\p{L}0-9])?\\.)+[\\p{L}0-9](?:[\\p{L}0-9-]*[\\p{L}0-9])?|\\[(?:(?:25[0-5" + "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" + "9][0-9]?|[\\p{L}0-9-]*[\\p{L}0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" + "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        //let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: string)
    }
}


//
//  InfoView.swift
//  ReferralAndRewards
//
//  Created by Ismail Gok on 2022-06-26.
//

import SwiftUI

struct InfoView: View {
    
    @EnvironmentObject var account: Account
    
    @Binding var presentMe : Bool
    
    var body: some View {
        if account.infoPage == 1 { // Login Page Info Screen
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("Login")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    // This should be the button to return to the main screen that NOW IT'S FINALLY working
                    Button  (action: {
                        
                        // Change the value of the Binding
                        presentMe = false
                        
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                }
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
    //                    .renderingMode(.template)
                        .scaledToFit()
    //                    .foregroundColor(.blue)
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                }
                
                //            Text("Account registration (main reg. Page)")
                //                .font(.title3)
                //                .fontWeight(.semibold)
                //                .padding(.vertical, 20)
                
                Text("- To log in enter your email address and password, then click “LOGIN” button.\n\n- If you don’t have account yet, create new account click 'create account button'\n\n- If you forgot your password, click 'reset password'")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Text("You can create multiple accounts for different stores with the same email address and password. To choose a store click the blue 'Name of the store-Cardholder' button below the password and select the one you need.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Spacer()
            }
            .padding()
        }
        else if account.infoPage == 2 { // CreateAccountPrompt
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("Create Account")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    // This should be the button to return to the main screen that NOW IT'S FINALLY working
                    Button  (action: {
                        
                        // Change the value of the Binding
                        presentMe = false
                        
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                }
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
    //                    .renderingMode(.template)
                        .scaledToFit()
    //                    .foregroundColor(.blue)
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                }
                
    //            Text("Account registration (main reg. Page)")
    //                .font(.title3)
    //                .fontWeight(.semibold)
    //                .padding(.vertical, 20)
                
                Text("If you are a store owner pick a 'store owner' option while registering, and pay the associated fees through the App store. The app is totally automated, but we will be happy to provide you with maintenance, support, and tutorials on how to use the app.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Text("If you are a store client, pick a 'store client' option. For customers of registered businesses, the app is free to use! If the store owner activated the referral function, new customers can enter a referral code while registering to get the bonus. Please note, that you will not be able to enter the referral code after you created the account.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Spacer()
            }
            .padding()
        }
        else if account.infoPage == 3 { // CreateCustomerAccount
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("Create Customer Account")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    // This should be the button to return to the main screen that NOW IT'S FINALLY working
                    Button  (action: {
                        
                        // Change the value of the Binding
                        presentMe = false
                        
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                }
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                }
                
                Text("Here you need to choose a store you are planning to use the app for. You will see a button 'Select a store', fill in the information about yourself: Email, Password, First Name, Last Name, Phone, Address, City, and Postal Code. If you have a referral code, enter it on the bottom of the form. In this way, both you, and the referrer will get the bonus. After the account will be created you will not be able to enter the referral number.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Text("After you have done all the steps, you need to press the 'Create Account' button at the very bottom. “Account created” notification will pop up, press 'OK'. Now you are ready to log in with your credentials!")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Spacer()
            }
            .padding()
        }
        else if account.infoPage == 4 { // Customer Home Page
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("Home Page")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    // This should be the button to return to the main screen that NOW IT'S FINALLY working
                    Button  (action: {
                        
                        // Change the value of the Binding
                        presentMe = false
                        
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                }
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
    //            Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
    //                    .renderingMode(.template)
                        .scaledToFit()
    //                    .foregroundColor(.blue)
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                }
                
                Text("In the middle of the page, you will see your Personal QR-code, which the store can scan to see your account information when you visit them or they can find you by phone number. Also, have an opportunity to convert dollars into points and vice versa. To the left of your balance, there is a 'CONVERT' button.")
    //                .font(.body)
    //                .padding(.vertical, 20)
                
                Text("You can find QR-scanner (to the bottom left) to add points (or virtual dollars) to your account. Or you can manually enter the offer code to get points. After you enter the code, click 'GET' button. And the points or virtual dollars will be displayed on your Home Page below your Personal QR-code.")
    //                .font(.body)
    //                .padding(.vertical, 20)
                
                Text("Another interesting function is the ability to pay with QR-code. To make a purchase at the store simply click the 'PAY QR' button to the right of your account balance.A phone camera will show up where you can point it to QR code to redeem points/dollars and purchase a product.")
    //                .font(.body)
    //                .padding(.vertical, 20)
                
                Text("At the very bottom of the Home Page, you will notice stars. This is a Rewards Chart, after a certain amount of visits or purchases at the store, you will collect stamps that will allow you to get eligible rewards.")
    //                .font(.body)
    //                .padding(.vertical, 20)
                
                Text("A referral number is a phone number mentioned in your account info. The only thing you need to do is share the number with your friends, family, and colleagues. If those people will enter your referral number while registering in the app both of you will get the bonus!")
    //                .font(.body)
    //                .padding(.vertical, 20)
                
                Text("To edit account credentials click the button with your name on the top left corner.  To log out, go to Home Page and click the 'LOG OUT' button in the top right corner.")
    //                .font(.body)
    //                .padding(.vertical, 20)
                
               
                
            }
            .font(.caption)
            .padding()
        }
        else if account.infoPage == 5 { // Convert View in Customer Page
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("CONVERTING POINTS/DOLLARS")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                }
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                }
                
                Text("To convert collected points click the “CONVERT” button, enter the amount you want to convert to dollars, then tap “CONVERT POINTS” and the amount entered will be automatically converted to dollars allowing you to spend it on goods or services later on.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Text("To convert collected dollars, enter the amount you want to convert to points, then tap “CONVERT DOLLARS” and the amount entered will be automatically converted to points.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Spacer()
            }
            .padding()
        }
        else if account.infoPage == 6 { // Edit Account Credentials View in Customer Page
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("SETTINGS")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("To change your information such as Email, Password, First Name, Last Name, Phone, Address, City, and Postal Code, simply click the button, change necessary information, check the “I agree with the Terms and Conditions?” box, and then click “SAVE” button. For no changes click “BACK” button.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Spacer()
            } //: VStack
            .padding()
        }
        else if account.infoPage == 7 { // More View in Customer Page
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("MORE PAGE")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                    
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Group {
                    Text("The “REWARDS CHART” section shows you how many visits or purchases at the store are left to get eligible rewards.")
    //                    .font(.body)
    //                    .padding(.vertical, 20)
                    
                    Text("In the “MEMBERSHIP” section you can check when your membership expires and what privileges you have with your membership.")
    //                    .font(.body)
    //                    .padding(.vertical, 20)
                    
                    Text("The “REDEEMABLE” section reflects how many points you have to redeem to get eligible rewards.")
    //                    .font(.body)
    //                    .padding(.vertical, 20)
                    
                    Text("In the “NOTES” section you can read notes from the store.")
    //                    .font(.body)
    //                    .padding(.vertical, 20)
                    
                    Text("If you click the “MAP” button, it will direct you to the exact location of the store.")
    //                    .font(.body)
    //                    .padding(.vertical, 20)
                    
                    Text("Under “MESSAGES” you can check mail sent to you from the store.")
    //                    .font(.body)
    //                    .padding(.vertical, 20)
                    
                    Text("To check your activity or account history such as points or dollar additions, redeemed goods, etc., simply click the “ACTIVITY” button.")
    //                    .font(.body)
    //                    .padding(.vertical, 20)
                } //: Group
                
                Spacer()
                
            } //: VStack
            .font(.body)
            .padding()
        }
        else if account.infoPage == 8 { // Create Store Account
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("CREATE NEW ACCOUNT")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("As a store owner you will have an option to choose a plan. We have three options available for you, our standard version, custom designed app, and distribution licence. You can pay your fees for the standard version through the App Store. If you decide to go for custom designed app or distribution licence, please contact us. After you are done with the payment, you can start using your account.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Spacer()
            } //: VStack
            .padding()
        }
        else if account.infoPage == 9 { // Search Account View for Store Owner
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("SEARCH ACCOUNT")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("To find a client profile click the ”SCAN QR CODE” button and scan the QR code on their app. OR search them by phone number. Simply enter the phone number in the ”Enter account number” box and click the ”SEARCH” button.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Text("To return to the Search Account page and find another customer simply click the ”SEARCH” button in the right top corner.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Spacer()
            } //: VStack
            .padding()
        }
        else if account.infoPage == 10 { // Setup View for Store Owner
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("SETTINGS/SETUP")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Group {
                    Text("To add or edit the referral program, click the ”Referral” button.")
                    
                    Text("Click “store message” to create a message visible to all your clients.")
                    
                    Text("To edit your offer codes that your customer can use to add points, press the ”Edit offer codes” button.")
                    
                    Text("“Edit your account info”, information such as Email, Password, First Name, Last Name, Phone, Address, City, or Postal Code.")
                    
                    Text("To add products in stock that are available for QR code purchase through the app, go to “Edit store products”.")
                    
                    Text("In “Edit Redeemables”, you can create gift cards or any other rewards you choose that your clients can get if they have enough points to redeem.")
                    
                    Text("To create, delete to edit your membership plan go to “Edit membership”")
                    
                } //: Group
                
                
                Spacer()
            } //: VStack
            .font(.body)
            .padding()
        }
        else if account.infoPage == 11 { // Referral View in Setup for Store Owner
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("REFERRAL")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("Create the Name of the program, enter the bonus amount in dollars for referrer (existing customer) and referral (new customer). Add a message or note for your team or yourself about the program in the box. Then click the ”CONFIRM” or ”UPDATE” button.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Spacer()
            } //: VStack
            .padding()
        }
        else if account.infoPage == 12 { // Store Message View in Setup for Store Owner
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("STORE MESSAGE")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("Click the ”Store Message” button, type a new message and click ”ADD”. To remove message click “Remove”")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Spacer()
            } //: VStack
            .padding()
        }
        else if account.infoPage == 13 { // Edit Offer Code View in Setup for Store Owner
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("EDIT OFFER CODES")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("Create an offer code and enter the number of points or dollars you want to offer for this code. To switch from points to dollars, click the blue ”points” or !dollars” word, and select the one you need. Below choose the date the offer code is good until. Then click the ”ADD CODE” button. In order to delete the offer code, press the ”REMOVE” button right next to it.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Spacer()
            } //: VStack
            .padding()
        }
        else if account.infoPage == 14 { // Edit Account Info View in Setup for Store Owner
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("EDIT ACCOUNT INFO")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("To ”Edit your account info” your information such as Email, Password, First Name, Last Name, Phone, Address, City, and Postal Code, simply click the button, change necessary information, check the ”I agree with the Terms and Conditions?” box, and then click ”SAVE” button. For no changes click ”BACK” button.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Spacer()
            } //: VStack
            .padding()
        }
        else if account.infoPage == 15 { // Edit Store Product View in Setup for Store Owner
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("EDIT STORE PRODUCTS")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("Enter the name of the product, the amount of points or dollars needed to buy the product (the ”price”). To switch from points to dollars, click the blue ”points” or ”dollars” word, and select the one you need. Then add the quantity of the product and click the ”ADD PRODUCT” button. You will see the list of products below. You can always edit the ”price” and quantity of the product by clicking the ”EDIT” button. To save the QR code of the item, you can press the ”Save image” button. Or you can share the QR by clicking ”Share”. In order to delete the product, press the ”REMOVE” button.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Spacer()
            } //: VStack
            .padding()
        }
        else if account.infoPage == 16 { // Edit Redeemables View in Setup for Store Owner
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("EDIT REDEEMABLES")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("To add rewards, enter the name of the reward or a gift card in the ”Name” box and the amount of points needed to get it in the ”Cost” box, then click the ”ADD” button. You are able to remove any reward from the list by clicking the ”REMOVE” button.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Spacer()
            } //: VStack
            .padding()
        }
        else if account.infoPage == 17 { // Edit Plans View in Setup for Store Owner
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("EDIT PLANS")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("You can edit the name of the plan and the duration. Under ADD BENEFIT create the description of the benefit that the plan includes and the quantity. Press the ”ADD” button. To remove some benefits from the membership plan simply click the ”REMOVE” button. If you want to delete a membership plan go back to the !EDIT PLANS” page and press the ”REMOVE” button next to the plan.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                Spacer()
            } //: VStack
            .padding()
        }
        else if account.infoPage == 18 { // Home page for Store Owner after an account is searched
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("HOME PAGE")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Group {
                    Text("This section allows you to check and manage your client's information, balance, membership, and rewards.")
                    
                    Text("In the upper section of the Home Page, there is information about the client: name, phone number, and address. You can edit your client's info by clicking on Edit Info.")
                    
                    Text("Home Page shows how many points and dollars the client collected. Also, there is information about the membership and referral.")
                    
                    Text("To check the activity or account history of the client such as points or dollar additions, redeemed goods, etc., press the ”ACTIVITY” button in the top middle part of the screen.")
                    
                    Text("All functions are customizable. Click on the SETTINGS button in the left top corner to go to the Settings menu in order to edit Offer Codes, Membership Plans, Referral Program, and more.")
                    
                } //: Group
                
                
                Spacer()
            } //: VStack
            .font(.body)
            .padding()
        }
        else if account.infoPage == 19 { // Edit Info for Store Owner after an account is searched
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("EDIT INFO")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("To change the client's information such as Email, Password, First Name, Last Name, Phone, Address, City, and Postal Code, simply change the necessary information and then click the ”SAVE” button. For no changes click the ”BACK” button.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                
                Spacer()
            } //: VStack
            .padding()
        }
        else if account.infoPage == 20 { // Rewards tab for Store Owner after an account is searched
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("REWARDS")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("In this section, you can add stamps to your client's account after each purchase or visit. When your customers make a certain number of purchases/visits, he/she will get enough stamps to get eligible rewards. To add a stamp click the ”ADD STAMP” button.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                
                Spacer()
            } //: VStack
            .padding()
        }
        else if account.infoPage == 21 { // Redeem tab for Store Owner after an account is searched
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("REDEEM")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("The ”Redeem” section is right next to ”Rewards”. In this section, you can convert your client's points to gift cards or any other rewards you create. Select the reward they choose and press the ”Redeem” button. If there aren't enough points, the points button will be inactive.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                
                Spacer()
            } //: VStack
            .padding()
        }
        else if account.infoPage == 22 { // More tab for Store Owner after an account is searched
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("MORE")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("Under the ”MORE” button we have the ”NOTES” and ”PLANS” sections. You can add notes about your clients, their preferences, allergies, etc. Under ”PLANS” you have the ability to manage your client's membership or subscription plans.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                
                Spacer()
            } //: VStack
            .padding()
        }
        else if account.infoPage == 23 { // Notes screen in More tab for Store Owner after an account is searched
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("NOTES")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("The notes may be visible to your clients or hidden. Toggle the eye icon button if you want the notes to be not visible to the client. Enter note text and click the ”ADD” button.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                
                Spacer()
            } //: VStack
            .padding()
        }
        else if account.infoPage == 24 { // Plans screen in More tab for Store Owner after an account is searched
            VStack(alignment: .leading, spacing: 20) {
                
                HStack {
                    
                    Text("PLANS")
                        .font(.title2)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .padding([.top, .leading])
                    
                    Spacer ()
                    
                    Button  (action: {
                        presentMe = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .foregroundColor(Color.gray)
                    })
                    .padding([.top, .trailing])
                } //: HStack
                
                Divider()
                    .padding(.horizontal)
                    .frame(height: 3.0)
                    .foregroundColor(Color.gray)
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Image("infoButtonImage-blue")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                    
                    Spacer()
                } //: HStack
                
                Text("To provide a membership option for your client, simply choose the correct option and click the ”ENROLL” button. Once you activate the membership it will display on the MEMBERSHIP page as well as the membership information, expiry date, and benefits will be shown. After the client uses one of the membership benefits, press the ”Use” button, and the number of benefits will be reduced automatically until he/she runs out of those benefits.")
                    .font(.body)
                    .padding(.vertical, 20)
                
                
                Spacer()
            } //: VStack
            .padding()
        }
        
        
        
        
    }
}

//struct InfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoView()
//    }
//}

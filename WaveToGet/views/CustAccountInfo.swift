//
//  custAccountInfo.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-26.
//

import SwiftUI

struct CustAccountInfo: View {
    @EnvironmentObject var custAccount:CustomerAccount
    @EnvironmentObject var account:Account
    var body: some View {
            ZStack
            {
                HStack(alignment: .top, spacing: 20)
                {
                    VStack
                    {
                        var lastname = custAccount.lastname == "" ? "" : custAccount.lastname + ", "
                        HStack
                        {
                            Image("user")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15.0, height: 15.0)
                                .frame(alignment: .top)
                                .colorMultiply(.MyGrey)
                            
                        Text(lastname + custAccount.firstname)
                            .font(.system(size: 17))
                            .frame(alignment: .leading)
                        } //: HStack
                        
                        HStack
                        {
                            Image("phone")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15.0, height: 15.0)
                                .frame(alignment: .top)
                                .colorMultiply(.MyGrey)
                            
                            Text(formatNumber(phoneNumber: custAccount.phone) ?? "")
                                .font(.system(size: 17))
                                .frame(alignment: .leading)
                        } //: HStack
                        
                    } //: VStack
                    
                    HStack(alignment: .top)
                    {
                        Image("location")
                            
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15.0, height: 15.0)
                            .colorMultiply(.MyGrey)
                            .frame(alignment: .top)
                        
                        VStack
                        {
                            Text(custAccount.address)
                                .font(.system(size: 17))
                                .frame(alignment: .leading)
                                .padding(.bottom, 5)
                            
                            Text(custAccount.city + " " + custAccount.provCode + " " + custAccount.postalcode)
                                .font(.system(size: 17))
                                .frame(alignment: .leading)
                            
                        } //: VStack
                        .frame(alignment: .top)
                        
                    } //: HStack
                    
                    VStack {
                        
                        Spacer()
                        
                        Button(action: {
                            account.EditCust = true
                            account.settings = true
                        }, label: {
                            ZStack
                            {
                                Text("Edit info")
                                    .font(.system(size: 17))
                                    .frame(alignment: .trailing)
                                    .foregroundColor(Color.LoginLinks)
//                                    .padding(.trailing, 20.0)
                            }
                        })
                        
                        Spacer()
                        
                    } //: VStack
                                        
                } //: HStack
                .padding(.bottom)
                
            } //: ZStack
            .frame(height: 75)
    }
}
func formatNumber(phoneNumber sourcePhoneNumber: String) -> String? {
    // Remove any character that is not a number
    let numbersOnly = sourcePhoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    let length = numbersOnly.count
    let hasLeadingOne = numbersOnly.hasPrefix("1")

    // Check for supported phone number length
    guard length == 7 || (length == 10 && !hasLeadingOne) || (length == 11 && hasLeadingOne) else {
        return nil
    }

    let hasAreaCode = (length >= 10)
    var sourceIndex = 0

    // Leading 1
    var leadingOne = ""
    if hasLeadingOne {
        leadingOne = "1 "
        sourceIndex += 1
    }

    // Area code
    var areaCode = ""
    if hasAreaCode {
        let areaCodeLength = 3
        guard let areaCodeSubstring = numbersOnly.substring(start: sourceIndex, offsetBy: areaCodeLength) else {
            return nil
        }
        areaCode = String(format: "(%@) ", areaCodeSubstring)
        sourceIndex += areaCodeLength
    }

    // Prefix, 3 characters
    let prefixLength = 3
    guard let prefix = numbersOnly.substring(start: sourceIndex, offsetBy: prefixLength) else {
        return nil
    }
    sourceIndex += prefixLength

    // Suffix, 4 characters
    let suffixLength = 4
    guard let suffix = numbersOnly.substring(start: sourceIndex, offsetBy: suffixLength) else {
        return nil
    }

    return leadingOne + areaCode + prefix + "-" + suffix
}

extension String {
    /// This method makes it easier extract a substring by character index where a character is viewed as a human-readable character (grapheme cluster).
    internal func substring(start: Int, offsetBy: Int) -> String? {
        guard let substringStartIndex = self.index(startIndex, offsetBy: start, limitedBy: endIndex) else {
            return nil
        }

        guard let substringEndIndex = self.index(startIndex, offsetBy: start + offsetBy, limitedBy: endIndex) else {
            return nil
        }

        return String(self[substringStartIndex ..< substringEndIndex])
    }
}
struct custAccountInfo_Preview: PreviewProvider {
    static var previews: some View {
        var custAccount = CustomerAccount()//for preview testing
        CustAccountInfo().environmentObject(custAccount)
    }
}

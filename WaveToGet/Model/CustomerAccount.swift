//
//  SAccount.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-25.
//

import Combine

final class CustomerAccount: ObservableObject {
    @Published var id: Int = 0
    @Published var user: Int = 0
    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var middleinitials: String = ""
    @Published var birthday: String = ""
    @Published var address: String = ""
    @Published var city: String = ""
    @Published var province: Int = 0
    @Published var country: Int = 0
    @Published var postalcode: String = ""
    @Published var phone: String = ""
    @Published var sms_promo: Int = 0
    @Published var pin: String = ""
    @Published var dollars: Float = 0
    @Published var points: Int = 0
    @Published var parent: String = ""
    @Published var group: String = ""
    @Published var created: String = ""
    @Published var updated: String = ""
    @Published var provCode: String = ""
    @Published var provname: String = ""
    @Published var country_code: String = ""
    @Published var country_name: String = ""
    @Published var unix_birthday: Int = 0
    @Published var parent_id: String = ""
    @Published var parent_firstname: String = ""
    @Published var parent_lastname: String = ""
    @Published var group_name: String = ""
    @Published var group_logo: String = ""
    @Published var email: String = ""
    @Published var type: Int = 0
    @Published var store: Int = 0
    @Published var active: Int = 0
    @Published var stampsheets: [StampSheet] = []
    @Published var stamps: [Stamp] = []
    @Published var benefits: [Benefit] = []
    @Published var meta: Meta?
    @Published var planName: String = ""
    @Published var planDetails: String = ""
    @Published var planExpiry: String = ""
    
    @Published var referrals: [referral] = []
    
    
    @Published var referraltotal: Float = 0
}
struct StampSheet: Decodable {
    var stampsheet: Int = 0
    var updated: String = ""
    var prize: String = ""
    var rewarded: String = ""
    var redeemed: String = ""
    var stamps: Int = 0
}
func AssignStampSheet(withParameters stampsheet: Int, updated: String, prize:String,rewarded:String,redeemed:String,stamps:Int) -> StampSheet
{
    var temp:StampSheet = StampSheet()
    temp.stampsheet = stampsheet
    temp.updated = updated
    temp.prize = prize
    temp.rewarded = rewarded
    temp.redeemed = redeemed
    temp.stamps = stamps
    return temp
}
struct Stamp: Decodable,Identifiable {
    var id: Int = 0
    var stampsheet: Int = 0
    var rewardstatus: Int = 0
    var created: Int = 0
    var updated: Int = 0
}
func AssignStamp(withParameters stampsheet: Int, rewardstatus: Int, created:Int,updated:Int) -> Stamp
{
    var temp:Stamp = Stamp()
    temp.stampsheet = stampsheet
    temp.rewardstatus = rewardstatus
    temp.created = created
    temp.updated = updated
    return temp
}
struct Benefit: Decodable,Identifiable {
    var id: Int = 0
    var benefit: Int = 0
    var quantity: Int = 0
    var startdate: String = ""
    var expirydate: String = ""
    var description: String = ""
}
func AssignBenefit(withParameters id: Int, benefit: Int, quantity:Int,startdate:String,expirydate:String,description:String) -> Benefit
{
    var temp:Benefit = Benefit()
    temp.id = id
    temp.benefit = benefit
    temp.quantity = quantity
    temp.startdate = startdate
    temp.expirydate = expirydate
    temp.description = description
    return temp
}

struct referral: Decodable,Identifiable {
    var id: Int = 0
    var sender: Int = 0
    var reciever: Int = 0
    var claimed: Int = 0
}
func Assignreferral(withParameters id: Int, sender: Int, reciever:Int, claimed:Int) -> referral
{
    var temp:referral = referral()
    temp.id = id
    temp.sender = sender
    temp.reciever = reciever
    temp.claimed = claimed
    return temp
}


struct Meta: Decodable {
}

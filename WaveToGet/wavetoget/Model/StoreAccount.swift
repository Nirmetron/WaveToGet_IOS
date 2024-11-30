//
//  StoreAccount.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-26.
//

import Combine

final class StoreAccount: ObservableObject {
    @Published var id: Int = 0
    @Published var name: String = ""
    @Published var cardname: String = ""
    @Published var shortcode: Int = 0
    @Published var status: Int = 0
    @Published var publickey: String = ""
    @Published var address: String = ""
    @Published var city: String = ""
    @Published var province: String = ""
    @Published var country: String = ""
    @Published var postalcode: String = ""
    @Published var phone: Int = 0
    @Published var website: String = ""
    @Published var created: String = ""
    @Published var updated: String = ""
    @Published var cardduration: String = ""
    @Published var employee_timesheets: String = ""
    @Published var interest_percent: String = ""
    @Published var license_agreed: Int = 0
    @Published var local_currency: Float = 0
    @Published var local_language: String = ""
    @Published var location_balance: Float = 0
    @Published var logo: String = ""
    @Published var mini_info: String = ""
    @Published var point_expand: Float = 0
    @Published var point_value: Float = 0
    @Published var registration_nocard: String = ""
    @Published var stamp_times: Int = 0
    @Published var tab_balance: Int = 0
    @Published var tab_default: String = ""
    @Published var tab_dental: String = ""
    @Published var tab_hide: Int = 0
    @Published var tab_info: Int = 0
    @Published var tab_membership: Int = 0
    @Published var tab_notes: Int = 0
    @Published var tab_punchclock: Int = 0
    @Published var tab_redeemables: Int = 0
    @Published var tab_rewards: Int = 0
    @Published var theme_colour: String = ""
    @Published var virtual_card_price: Float = 0
    @Published var stampsheets: [StoreStampSheet] = []
    @Published var plans: [Plan] = []
}
struct StoreStampSheet: Decodable {
    var id: Int = 0
    var prize: String = ""
    var size: Int = 0
    var autostamp: Int = 0
    var autoreward: Int = 0
    var shape_id: Int = 0
    var shape: String = ""
}
func AssignStampSheet(withParameters id: Int, prize: String, size:Int,autostamp:Int,autoreward:Int,shape_id:Int, shape:String) -> StoreStampSheet
{
    var temp:StoreStampSheet = StoreStampSheet()
    temp.id = id
    temp.prize = prize
    temp.size = size
    temp.autostamp = autostamp
    temp.autoreward = autoreward
    temp.shape_id = shape_id
    temp.shape = shape
    return temp
}
struct Plan: Decodable {
    var id: Int = 0
    var store: Int = 0
    var name: String = ""
    var term_months: Int = 0
    var details: String = ""
    var fallback_plan: Int = 0
    var created: String = ""
    var updated: String = ""
}
func AssignPlan(withParameters id: Int, store: Int, name:String,term_months:Int,details:String,fallback_plan:Int, created:String,updated:String) -> Plan
{
    var temp:Plan = Plan()
    temp.id = id
    temp.store = store
    temp.name = name
    temp.term_months = term_months
    temp.details = details
    temp.fallback_plan = fallback_plan
    temp.created = created
    temp.updated = updated
    return temp
}
//{"id":24,"name":"demo4","cardname":"demo4card","shortcode":null,"status":1,"publickey":"3379667730","address":null,"city":null,"province":null,"country":null,"postalcode":null,"phone":null,"website":null,"created":"2017-08-09 13:49:04","updated":"2018-08-01 11:44:14","card_duration":"1000","employee_timesheets":"0","interest_percent":"","licence_agreed":"1509372487","local_currency":"","local_language":"","location_balance":"","logo":"24\/hfVqgTZa9o.png","mini_info":"0","point_expand":"100","point_value":"0.02","registration_nocard":"1","stamp_times":"1","tab_balance":"1","tab_default":"Balance","tab_dental":"","tab_hide":"0","tab_info":"1","tab_membership":"1","tab_notes":"1","tab_punchclock":"","tab_redeemables":"1","tab_rewards":"1","theme_colour":"orange","virtual_card_price":"0.01",
//    "stampsheets":[{"id":51,"prize":"DISCOUNTED PREMIUM D","size":10,"autostamp":0,"autoreward":0,"shape_id":4,"shape":"star"}]
//    ,"plans":[{"id":106,"store":24,"name":"Laser Lipo - 8 Treatments","term_months":0,"details":"8 lipo treatments to use when you like","fallback_plan":null,"created":"2016-09-20 13:58:28","updated":"2016-09-20 14:04:55"},{"id":121,"store":24,"name":"VIP Member","term_months":1,"details":"5% OFF on all services over $400.00","fallback_plan":106,"created":"2017-01-20 11:09:06","updated":"2017-02-23 16:00:09"},{"id":123,"store":24,"name":"Annual Membership","term_months":12,"details":"Annual Membership Plan - allows for special priveledges at Page the Cleaner locations.  Including $1.00 t-shirts, $5,00 pants, etc.","fallback_plan":121,"created":"2017-02-14 14:26:36","updated":"2017-02-14 14:28:17"},{"id":124,"store":24,"name":"Interior and Exterior Detailing Package ","term_months":0,"details":"$11.00 for $20 worth of chicken, sandwiches, pasta and comfort food","fallback_plan":null,"created":"2017-02-23 14:43:17","updated":"2017-03-06 09:24:16"},{"id":125,"store":24,"name":"Elan Vitale VIP Plan","term_months":0,"details":"$125.00 Permanent MakeUp Application of Eyeliner","fallback_plan":null,"created":"2017-02-23 17:04:36","updated":"2017-02-23 17:05:32"},{"id":126,"store":24,"name":"Military Personnel ","term_months":0,"details":"Received 20% discount with your Military or Veteran ID","fallback_plan":null,"created":"2017-02-25 11:01:59","updated":"2018-05-29 10:52:57"},{"id":128,"store":24,"name":"VIP Membership","term_months":4,"details":"receive 10% off your services with a purchase of windows and eaves cleaning","fallback_plan":106,"created":"2017-03-23 18:03:52","updated":"2017-03-23 18:05:35"},{"id":152,"store":24,"name":"Referral Plan","term_months":2,"details":"","fallback_plan":null,"created":"2017-06-29 15:23:50","updated":"2017-06-29 15:23:50"},{"id":160,"store":24,"name":"VIP Member","term_months":0,"details":"","fallback_plan":null,"created":"2017-08-16 17:09:52","updated":"2017-08-16 17:13:58"},{"id":162,"store":24,"name":"Platinum Membership","term_months":12,"details":"24\/7 Global Service and Support ","fallback_plan":106,"created":"2018-01-05 13:53:47","updated":"2018-01-05 13:54:35"},{"id":163,"store":24,"name":"Membership Plan","term_months":12,"details":"This Monthly Membership Plan Qualifies You for Discount on a Load of Products","fallback_plan":152,"created":"2018-01-16 11:44:14","updated":"2018-01-16 11:45:16"},{"id":169,"store":24,"name":"First Responeders","term_months":0,"details":"Receive a % Discount With Every Purchase","fallback_plan":null,"created":"2018-03-19 14:16:37","updated":"2018-05-29 10:52:28"},{"id":174,"store":24,"name":"Legendary Club","term_months":12,"details":"Point Accumulation for Food and Beverage, Spa and Rooms","fallback_plan":106,"created":"2018-04-12 09:06:43","updated":"2018-04-12 09:08:56"},{"id":175,"store":24,"name":"Gold Plan","term_months":12,"details":"All Members Receive 10% Discount on Service ","fallback_plan":128,"created":"2018-05-15 08:49:41","updated":"2018-05-15 08:52:53"}]}

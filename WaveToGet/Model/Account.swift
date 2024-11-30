//
//  Account.swift
//  wavetoget
//
//  Created by Jesse Lugassy on 2021-01-15.
//
import Combine
import SwiftUI

final class Account:ObservableObject {
    
    @Published var lastMessages = [LastMessagesRead]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(lastMessages) {
                UserDefaults.standard.set(encoded, forKey: "readMessages")
            }
        }
    }
    init() {
        if let items = UserDefaults.standard.data(forKey: "readMessages") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([LastMessagesRead].self, from: items) {
                self.lastMessages = decoded
                return
            }
        }

        self.lastMessages = []
    }
    
    @Published var id:Int = 0
    @Published var Username: String = ""
    @Published var Email: String = ""
    @Published var AccountType: String = ""
    @Published var SessionToken:String = ""
    @Published var CardUId:String = ""
    @Published var isCust: Bool = false
    @Published var store:Int = 0
    @Published var loadedAcc:Bool = false
    @Published var settings:Bool = false
    @Published var EditCust: Bool = false
    @Published var currentPage = 1
    @Published var Ipad: Bool = false
    @Published var Landscape: Bool = false
    @Published var messages: [Message] = []
    @Published var newMessage = true
    @Published var verifiedEmail:String = ""
    @Published var createacc:Bool = false
    @Published var infoPage = 1
    
    
    @Published var ProvinceList: [String] = ["Alberta",
                                              "British Columbia",
                                              "Manitoba",
                                              "New Brunswick",
                                              "Newfoundland and Labrador",
                                              "Nova Scotia",
                                              "Nunavut",
                                              "Ontario",
                                              "Prince Edward Island",
                                               "Quebec",
                                               "Saskatchewan",
                                               "Yukon",
                                               "Alabama",
                                               "Alaska",
                                               "Arizona",
                                               "Arkansas",
                                               "California",
                                               "Colorado",
                                               "Connecticut",
                                               "Delaware",
                                               "District of Columbia",
                                               "Florida",
                                               "Georgia",
                                               "Hawaii",
                                               "Idaho",
                                               "Illinois",
                                               "Indiana",
                                               "Iowa",
                                               "Kansas",
                                               "Kentucky",
                                               "Louisiana",
                                               "Maine",
                                               "Maryland",
                                               "Massachusetts",
                                               "Michigan",
                                               "Minnesota",
                                               "Mississippi",
                                               "Missouri",
                                               "Montana",
                                               "Nebraska",
                                               "Nevada",
                                               "New Hampshire",
                                               "New Jersey",
                                               "New Mexico",
                                               "New York",
                                               "North Carolina",
                                               "North Dakota",
                                               "Ohio",
                                               "Oklahoma",
                                               "Oregon",
                                               "Pennsylvania",
                                               "Rhode Island",
                                               "South Carolina",
                                               "South Dakota",
                                               "Tennessee",
                                               "Texas",
                                               "Utah",
                                               "Vermont",
                                               "Virginia",
                                               "Washington",
                                               "West Virginia",
                                               "Wisconsin",
                                               "Wyoming",
                                               "American Samoa",
                                               "Guam",
                                               "Northern Mariana Islands",
                                               "Puerto Rico",
                                               "U.S. Virgin Islands",
                                               "U.S. Minor Outlying Islands"
    ]
    @Published var ProvinceCodeList: [String] = ["AB",
                                              "BC",
                                              "MB",
                                              "NB",
                                              "NL",
                                              "NS",
                                              "NU",
                                              "ON",
                                              "PE",
                                               "QC",
                                               "SK",
                                               "YT",
                                               "AL",
                                               "AK",
                                               "AZ",
                                               "AR",
                                               "CA",
                                               "CO",
                                               "CT",
                                               "DE",
                                               "DC",
                                               "FL",
                                               "GA",
                                               "HI",
                                               "ID",
                                               "IL",
                                               "IN",
                                               "IA",
                                               "KS",
                                               "KY",
                                               "LA",
                                               "ME",
                                               "MD",
                                               "MA",
                                               "MI",
                                               "MN",
                                               "MS",
                                               "MO",
                                               "MT",
                                               "NE",
                                               "NV",
                                               "NH",
                                               "NJ",
                                               "NM",
                                               "NY",
                                               "NC",
                                               "ND",
                                               "OH",
                                               "OK",
                                               "OR",
                                               "PA",
                                               "RI",
                                               "SC",
                                               "SD",
                                               "TN",
                                               "TX",
                                               "UT",
                                               "VT",
                                               "VA",
                                               "WA",
                                               "WV",
                                               "WI",
                                               "WY",
                                               "AS",
                                               "GU",
                                               "MP",
                                               "PR",
                                               "VI",
                                               "UM"
    ]
}
struct LastMessagesRead: Identifiable, Codable {
    var id: Int = 0
    var store: Int = 0
}
struct Message: Decodable,Identifiable {
    var id: Int = 0
    var store: Int = 0
    var message: String = ""
    var created: String = ""
}
func AssignMessage(withParameters id: Int, store: Int, message:String,created:String) -> Message
{
    var temp:Message = Message()
    temp.id = id
    temp.store = store
    temp.message = message
    temp.created = created
    return temp
}

struct acc: Decodable, Hashable {
    var id: Int?
    var name: String?
}

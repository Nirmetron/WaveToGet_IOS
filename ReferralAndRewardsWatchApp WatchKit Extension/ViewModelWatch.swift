//
//  ViewModelWatch.swift
//  ReferralAndRewardsWatchApp WatchKit Extension
//
//  Created by Ismail Gok on 2022-08-27.
//

import Foundation
import WatchConnectivity
import SwiftKeychainWrapper

class ViewModelWatch : NSObject,  WCSessionDelegate, ObservableObject{
    var session: WCSession
    @Published var phone = ""
    @Published var dollars = ""
    @Published var points = ""
    init(session: WCSession = .default){
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
        self.LoadSavedCredentials()
    }
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            self.phone = message["phone"] as? String ?? ""
            self.dollars = message["dollars"] as? String ?? ""
            self.points = message["points"] as? String ?? ""
            print("test")
            print(self.phone)
            self.SaveCredentials()
        }
    }
    func LoadSavedCredentials()
    {
        self.phone = KeychainWrapper.standard.string(forKey: "phone") ?? ""
        self.dollars = KeychainWrapper.standard.string(forKey: "dollars") ?? ""
        self.points = KeychainWrapper.standard.string(forKey: "points") ?? ""
    }
    func SaveCredentials()
    {
        KeychainWrapper.standard.set(phone, forKey: "phone")
        KeychainWrapper.standard.set(dollars, forKey: "dollars")
        KeychainWrapper.standard.set(points, forKey: "points")
    }
}

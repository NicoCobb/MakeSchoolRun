//
//  CoinSingleton.swift
//  MakeSchoolRun
//
//  Created by nico cobb on 5/12/17.
//  Copyright © 2017 nicocobb. All rights reserved.
//

import Foundation

class GlobalCoin {
    static let sharedInstance = GlobalCoin()
    
    var coins:Int
    
    private init() {
        let userDefaults = UserDefaults.standard
        coins = userDefaults.integer(forKey: "coins")
    }
}

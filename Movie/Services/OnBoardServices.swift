//
//  OnBoardServices.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import Foundation
import  KeychainSwift
class OnBoardServices {
    static var shared = OnBoardServices()
    private init() {
        
    }
    enum Keys: String {
        case KeyOnBoard
    }
    func makeOnBoard() {
        let userDefault = UserDefaults.standard
        userDefault.setValue(true, forKey: Keys.KeyOnBoard.rawValue)
    }
    
    func  isOnBoard() -> Bool {
        let userDefault = UserDefaults.standard
        return userDefault.bool(forKey: Keys.KeyOnBoard.rawValue)
    }
}

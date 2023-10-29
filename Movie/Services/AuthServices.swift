//
//  AuthServices.swift
//  Movie
//
//  Created by AsherFelix on 10/28/23.
//

import Foundation
import KeychainSwift

class AuthServices {
    static var shared = AuthServices()
    private init() {
        
    }
    enum Keys: String {
        case KeyAccessToken
    }
    
    func saveAccessToken(accessToken: String) {
        let keychain = KeychainSwift()
        keychain.set(accessToken, forKey: Keys.KeyAccessToken.rawValue)
    }
    func getAccessToken() -> String? {
        let keychain = KeychainSwift()
        return keychain.get(Keys.KeyAccessToken.rawValue)
    }
    func clearAccessToken() {
        let keychain = KeychainSwift()
        keychain.delete(Keys.KeyAccessToken.rawValue)
    }
    var isLoggedIn: Bool {
        let token = getAccessToken()
        return token != nil && !(token!.isEmpty)
    }
}

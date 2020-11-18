
//
//  AuthApi.swift
//  Instagram_withStoryBoard
//
//  Created by My iMac on 12/29/18.
//  Copyright © 2018 My iMac. All rights reserved.
//

import Foundation

class AuthApi {
    func createUser(email mail: String, password pass: String, onFail: @escaping (String) -> Void, onSuccess: @escaping ()  -> Void) {
        Api.user.AUTH.createUser(withEmail: mail, password: pass) { (user, error) in
            if error != nil {
                onFail((error?.localizedDescription)!)
                return
            }
            onSuccess()
        }
    }
    
    func signIn(withEmail email: String, password pass: String, onFail: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        Api.user.AUTH.signIn(withEmail: email, password: pass) { (user, error) in
            if error != nil {
                onFail((error?.localizedDescription)!)
                return
            }
            onSuccess()
        }
    }
    
    func signOut(onFail: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        do {
            try Api.user.AUTH.signOut()
        } catch let logoutError {
            onFail(logoutError.localizedDescription)
        }
        onSuccess()
    }
}

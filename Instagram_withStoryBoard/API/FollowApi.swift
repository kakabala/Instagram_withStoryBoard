//
//  FollowApi.swift
//  Instagram_withStoryBoard
//
//  Created by My iMac on 1/1/19.
//  Copyright © 2019 My iMac. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FollowApi {
    let FOLLOWERS_REF = Database.database().reference().child("followers")
    let FOLLOWINGS_REF = Database.database().reference().child("followings")
    
    func follow(withUID userId: String) {
        Api.feed.savePostsAfterFollowUser(userId: userId)
        FOLLOWERS_REF.child(userId).child(Api.user.CURRENT_USER!.uid).setValue(true)
        FOLLOWINGS_REF.child(Api.user.CURRENT_USER!.uid).child(userId).setValue(true)
    }
    
    func unfollow(withUID userId: String) {
        Api.feed.savePostsAfterUnfollowUser(userId: userId)
        FOLLOWERS_REF.child(userId).child(Api.user.CURRENT_USER!.uid).setValue(NSNull())
        FOLLOWINGS_REF.child(Api.user.CURRENT_USER!.uid).child(userId).setValue(NSNull())
    }
    
    func status(withUID userId: String, completion: @escaping (Bool) -> Void) {
        FOLLOWERS_REF.child(userId).child(Api.user.CURRENT_USER!.uid).observeSingleEvent(of: .value) { (snapshot) in
            if let _ = snapshot.value as? NSNull {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
}

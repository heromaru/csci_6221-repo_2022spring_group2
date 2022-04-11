//
//  UserService.swift
//  SocialMediaApp
//
//  Created by Oğuzhan Yangöz on 4/8/22.
//

import Foundation

class UserProfile {
    var uid:String
    var username:String
    var photoURL:URL
    
    init(uid:String, username:String,photoURL:URL) {
        self.uid = uid
        self.username = username
        self.photoURL = photoURL
    }
}

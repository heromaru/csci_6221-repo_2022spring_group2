//
//  Post.swift
//  SocialMediaApp
//
//  Created by Oğuzhan Yangöz on 4/8/22.
//

import Foundation

class Post {
    var id : String
    var author : UserProfile
    var text : String
    var timestamp: Double
    
    init(id: String, author : UserProfile, text : String, timestamp: Double) {
        self.id = id
        self.author = author
        self.text = text
        self.timestamp = timestamp
    }

}

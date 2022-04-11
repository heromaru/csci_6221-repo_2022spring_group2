//
//  Post.swift
//  SocialMediaApp
//
//  Created by Oğuzhan Yangöz on 4/8/22.
//

import Foundation

class Post {
    var id : String
    var author : String
    var text : String
    var time : String
    
    init(id: String, author : String, text : String, time: String) {
        self.id = id
        self.author = author
        self.text = text
        self.time = time
        
    }

}

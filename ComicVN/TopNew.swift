//
//  TopNew.swift
//  ComicVN
//
//  Created by ReasonAmu on 10/23/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation

class TopNew {
    
    var name: String?
    var thumbnail: String?
    var updated_time: TimeInterval?
    var last_chapter: String?
    
    
    init?(data : [String : AnyObject]) {
        guard let name = data["name"] as? String else {
            return nil
        }
        guard let thumbnail = data["thumbnail"] as? String else {
            return nil
        }
        guard let  last_chapter = data["last_chapter"] as? String else {
            return nil
        }
        guard let updated_time = data["updated_time"] as? TimeInterval else {
            return nil
        }
        self.name = name
        self.thumbnail = thumbnail
        self.updated_time = updated_time
        self.last_chapter = last_chapter
    }
    
    
}

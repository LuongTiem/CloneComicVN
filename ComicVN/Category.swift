//
//  Category.swift
//  ComicVN
//
//  Created by ReasonAmu on 10/22/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation

class Category {
    
    var name : String?
    var thumbnail : String?
    
    init?(data : [String : AnyObject]) {
        guard let name = data["name"] as? String else {
            return nil
        }
        guard let thumbnail = data["thumbnail"] as? String else {
            return nil
        }
        self.name = name
        self.thumbnail = thumbnail
    }
}

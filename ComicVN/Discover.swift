//
//  Discover.swift
//  ComicVN
//
//  Created by ReasonAmu on 10/22/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation

class Discover {
    var name :String?
    var listcontents = [Contents]()
    
    init?(data : [String : AnyObject]) {
        
        guard let name = data["name"] as? String else {
            return nil
        }
        
        guard let contents = data["contents"] as? [AnyObject] else {
            print("vao else")
            return nil
        }
        
        self.name = name
        
        
        for element in contents {
            let cat = element as? [String : AnyObject]
            let content = Contents.init(contents: cat!)
            if content != nil {
                listcontents.append(content!)
            }
   
        }

    }
}



class Contents {
    var name : String?
    var thumbnail: String?
    var description: String?
    
    var total_chapter: Int?
    var category: String?
    var view : Int?
    init?(contents : [String: AnyObject]) {
        
        guard let name = contents["name"] as? String else {
            return nil
        }
        guard let thumbnail = contents["thumbnail"] as? String else {
            return nil
        }
        guard let description = contents["description"] as? String else {
            return nil
        }
        
        guard let total_chapter = contents["total_chapter"] as? Int else {
            return nil
        }
        
        guard let arr_category = contents["category"] as? [AnyObject] else {
            return nil
        }
        guard let category = arr_category[0].value(forKey: "name") as? String else {
            return nil
        }
        guard let view = contents["view"] as? Int else {
            return nil
        }
        
        
        self.name  = name
        self.thumbnail = thumbnail
        self.description = description
        
        self.total_chapter  = total_chapter
        self.category = category
        self.view = view
        
    }
}

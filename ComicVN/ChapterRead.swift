//
//  ChapterRead.swift
//  ComicVN
//
//  Created by ReasonAmu on 10/23/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation


class ChapterRead {
    
    
    var name : String?
    var image : [String]?
    
    init?(data : [String : AnyObject]) {
        
        guard let name = data["name"] as? String else {
            return nil
        }
        guard let image = data["content"] as? [String] else {
            return nil
        }
        
        self.name = name
        self.image = image
    }
}

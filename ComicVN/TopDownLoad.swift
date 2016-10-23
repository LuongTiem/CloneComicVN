//
//  TopHot.swift
//  ComicVN
//
//  Created by ReasonAmu on 10/23/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation


class TopDownLoad{
    var name:String?
    var view: Int?
    var total_chapter: Int?
    var thumbnail:String?
    
    init?(data : [String : AnyObject]) {
        
        guard let name = data["name"] as? String else {
            return nil
        }
        guard let view = data["view"] as? Int else {
            return nil
        }
        guard let total_chapter = data["total_chapter"] as? Int else {
            return nil
        }
        guard let thumbnail = data["thumbnail"] as? String else {
            return nil
        }
        self.name = name
        self.view = view
        self.total_chapter = total_chapter
        self.thumbnail = thumbnail
    }
    
    
}

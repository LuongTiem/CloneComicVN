//
//  StoryNewest.swift
//  ComicVN
//
//  Created by ReasonAmu on 10/7/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation
class StoryNewest {
    
    var id_manga :String?
    var manga_name : String?
    var image : String?
    var num_chapter :Int?
    var update_date : String?
    var view : String?
    var description: String?
    
    init?(Json : [String : AnyObject]) {
        guard let id_manga = Json["id_manga"] as? String else {
            return nil
        }
        guard let manga_name = Json["manga_name"] as? String else {
            return nil
        }
        guard let image = Json["image"] as? String else {
            return nil
        }
        guard let num_chapter = Json["num_chapter"] as? Int else {
            return nil
        }
        guard let update_date = Json["update_date"] as? String else {
            return nil
        }
        guard let view = Json["view"] as? String else {
            return nil
        }
        guard let description = Json["description"] as? String else {
            return nil
        }
        
        self.id_manga = id_manga
        self.manga_name = manga_name
        self.image = image
        self.num_chapter = num_chapter
        self.update_date = update_date
        self.view = view
        self.description = description
    }
}

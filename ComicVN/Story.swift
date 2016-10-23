//
//  Story.swift
//  ComicVN
//
//  Created by ReasonAmu on 9/29/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class Story: NSObject {
    
    //-- tra ve tung truyen
    var id_manga : String?
    var manga_name : String?            //-- ten truyen
    var descriptionStory :String?
    var category:String?
    var image :String?                  //-- anh bia
    var update_date : String?           //-- ngay update
    var view:String?
    var newest_chapter: String?
    var chapter: [ChapterStory]?
    
    
    init?(JSon : [String : AnyObject]) {
        guard let id_manga = JSon["id_manga"]  as? String else {
            return nil
        }
        guard let manga_name = JSon["manga_name"]  as? String else {
            return nil
        }
        guard let image = JSon["image"]  as? String else {
            return nil
        }
        
        guard let descriptionStory = JSon["description"] as? String else {
            return nil
        }
        guard let category = JSon["category"] as? String else {
            return nil
        }
        
        guard let update_date = JSon["update_date"] as? String else {
            return nil
        }
        guard let view = JSon["view"] as? String else {
            return nil
        }
        guard let newest_chapter = JSon["newest_chapter"] as? String else {
            return nil
        }
        
        
        self.id_manga = id_manga
        self.manga_name = manga_name
        self.image = image
        self.descriptionStory = descriptionStory
        self.category = category
        self.update_date = update_date
        self.view = view
        self.newest_chapter = newest_chapter
       
    }
}

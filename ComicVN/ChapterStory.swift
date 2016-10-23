//
//  ChapterStory.swift
//  ComicVN
//
//  Created by ReasonAmu on 9/29/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class ChapterStory: NSObject {
    
    var id_chapter: String?
    var chapter_name: String?
    var chapter_status:String?
    var chapter_create_date : String?
    var chapter_ord : String?
    var view :String?
    
    var listImages : [ListImage]?
    
    
    init?( Json : [String : AnyObject]) {
        guard let id_chapter = Json["id_chapter"]  as? String else {
            return nil
        }
        guard let chapter_name = Json["chapter_name"]  as? String else {
            return nil
        }
        guard let chapter_status = Json["chapter_status"]  as? String else {
            return nil
        }
        guard let chapter_create_date = Json["chapter_create_date"]  as? String else {
            return nil
        }
        guard let chapter_ord = Json["chapter_ord"]  as? String else {
            return nil
        }
        guard let view = Json["view"]  as? String else {
            return nil
        }
       
        self.id_chapter = id_chapter
        self.chapter_name = chapter_name
        self.chapter_status = chapter_status
        self.chapter_create_date = chapter_create_date
        self.chapter_ord = chapter_ord
        self.view = view
        
    }
   

}

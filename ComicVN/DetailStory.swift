//
//  DetailStory.swift
//  ComicVN
//
//  Created by ReasonAmu on 10/23/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation


class DetailStory {
    var name:String?
    var thumbnail: String?
    var view: Int?
    var total_chapter: Int?
    
    init?(related_comics : [String : AnyObject]) {
        
        guard let name = related_comics["name"] as? String else {
            return nil
        }
        guard let thumbnail = related_comics["thumbnail"] as? String else {
            return nil
        }
        guard let view = related_comics["view"] as? Int else {
            return nil
        }
        guard let total_chapter = related_comics["total_chapter"] as? Int else {
            return nil
        }
        
        self.name = name
        self.thumbnail = thumbnail
        self.total_chapter = total_chapter
        self.view = view
    }
    
}

class Detail {
    var name : String?
    var description : String?
    var view : Int?
    var category : String?
    
    var related_comics = [DetailStory]()
    var chapters = [Chapter]()
    
    
    init?(data : [String : AnyObject]) {
        guard let name = data["name"] as? String else {
            return nil
        }
        guard let description = data["description"] as? String else {
            return nil
        }
        guard let view = data["view"] as? Int else {
            return nil
        }
        
        
        guard let related_comic = data["related_comics"] as? [AnyObject] else {
            print("vao else")
            return nil
        }
        
        for element in related_comic {
            let catElement = element as? [String : AnyObject]
            let obj  = DetailStory.init(related_comics: catElement!)
            
            related_comics.append(obj!)
            
            
        }
        
        guard let chapter = data["chapters"] as? [AnyObject] else {
            print("vao else")
            return nil
        }
        
        for element in  chapter {
            
            let catElement = element as? [String : AnyObject]
            let object = Chapter.init(chapter: catElement!)
            chapters.append(object!)
            
        }
        
        
    
        
        
        self.name = name
        self.description = description
        self.view = view
       
        
    }
}



class Chapter {
    
    var name : String?
    var view : Int?
    
    init?(chapter : [String : AnyObject]) {
        guard let name = chapter["name"] as? String else {
            return nil
        }
        guard let view = chapter["view"] as? Int else {
            return nil
        }
        self.name = name
        self.view = view
    }
    
}

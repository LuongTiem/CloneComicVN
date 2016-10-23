//
//  StoryMostView.swift
//  ComicVN
//
//  Created by ReasonAmu on 9/29/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class StoryMostView : NSObject {
    
    var id_manga:String?
    var nameStory : String?
    var imageStory: String?
    var descriptionStory : String?
    var categoryStory : String?

    

   
    init?(Json : [String : AnyObject]) {
        
        guard let id_manga = Json["id_manga"]  as? String else {
            return nil
        }
        guard let nameStory = Json["name"]  as? String else {
            return nil
        }
        guard let imageStory = Json["image"]  as? String else {
            return nil
        }
        guard let descriptionStory = Json["description"]  as? String else {
            return nil
        }
        
        guard let categoryStory = Json["category"]  as? String else {
            return nil
        }
        
        self.id_manga = id_manga
        self.nameStory = nameStory
        self.imageStory = imageStory
        self.descriptionStory = descriptionStory
        self.categoryStory = categoryStory
        
        
    }
    
    
}

//
//  CategoryStory.swift
//  ComicVN
//
//  Created by ReasonAmu on 9/29/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit


class CategoryStory {
    //-- tra ve 38 the loai truyen
    var idCategory: String?
    var nameCategory : String?
    var parent_id:String?
    var storys : [Story]?
    
    
    
    
    
    init?(JSON : [String : AnyObject]) {
        
        guard let id  = JSON["id"] as? String else {
            return nil
        }
        guard let name = JSON["name"] as? String else {
            return nil
        }
        guard let  parent_id = JSON["parent_id"] as? String else   {
            return nil
        }
        self.idCategory = id
        self.nameCategory = name
        self.parent_id = parent_id
        
    }
    
    

    
}

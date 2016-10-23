//
//  ListImage.swift
//  ComicVN
//
//  Created by ReasonAmu on 9/29/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit

class ListImage: NSObject {
    
    var images :String?
    
    init(JSon : String) {
        self.images = JSon
    }
}

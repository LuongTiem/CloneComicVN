//
//  DataManager.swift
//  ComicVN
//
//  Created by ReasonAmu on 10/8/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import Foundation
import Alamofire

class  DataManager {
    
    static let LINKDISCOVER = "http://iplei.com/manga/content/discover?access_token=A-A172641-U137710-6DA5WN-D5BC975FF16AC3B5&lang=vi&kid_lock=2"
    static let LINKCATEGORY = "http://iplei.com/manga/content/categories"
    
    static let LINKTOPNEW = "http://iplei.com/manga/content/topNew"
    static let LINKTOPDOWLOAD = "iplei.com/manga/content/topDownload?access_token=A-A172641-U137710-6DA5WN-D5BC975FF16AC3B5&lang=vi&kid_lock=2?build=47&hash=ceca2f218c82250864a548077ff12e63&time=1476779068&device_id=F31AD414-B586-487E-AEB3-FBB428C97F2E&category_id&start=0&limit=12&device_os=ios"
    static let LINKDETAILCATEGORY = "http://iplei.com/manga/content/detail"
    
    static let LINKREADCHAPTER = "http://iplei.com/manga/content/chapters"
    
    static let shareInstance = DataManager()
    
    
    
    private init(){
        
    }
    
    


//-- get discover

func getDiscover(completion : @escaping ([Discover])-> () ){
    
    let url = URL(string: DataManager.LINKDISCOVER)!
    let parameters : Parameters = ["build": "47",
                                   "hash": "f569427290e41831dba366619ee6f88b",
                                   "time": "1476765250",
                                   "device_id": "F31AD414-B586-487E-AEB3-FBB428C97F2E",
                                   "category_id": "",
                                   "start": "0",
                                   "limit": "12",
                                   "device_os": "ios"]
    
    Alamofire.request(url , method: .post,parameters : parameters,encoding: URLEncoding.default).responseJSON { (response) in
        
        if let json = response.result.value as? [String : AnyObject]{
            var listDiscover = [Discover]()
            let arrData = json["data"] as? [AnyObject]
            
            for data in arrData! {
                
                let catData = data as? [String : AnyObject]
                let discover = Discover.init(data: catData!)
                listDiscover.append(discover!)
            }
            completion(listDiscover)
            
        }
        
    }
    
}





//-- get Category


func getCategory(completion : @escaping ([Category])-> ()){
    
    let url = URL(string: DataManager.LINKCATEGORY)!
    let parameters : Parameters = [ "device_os": "ios",
                                    "device_id": "F31AD414-B586-487E-AEB3-FBB428C97F2E",
                                    "hash": "70191e1114ffd14d39c44e79c487c725",
                                    "time": "1476780762",
                                    "build": "1"]
    
    Alamofire.request(url , method: .post,parameters : parameters,encoding: URLEncoding.default).responseJSON { (response) in
        
        if let json = response.result.value as? [String : AnyObject]{
            var listCategory = [Category]()
            let arrData = json["data"] as? [AnyObject]
            
            for data in arrData! {
                
                let catData = data as? [String : AnyObject]
                let category = Category.init(data: catData!)
                
                if (category != nil) {
                    listCategory.append(category!)
                }
                
            }
            completion(listCategory)
            
        }
        
    }
    
}


//-- get Top New


func getTopNew(completion : @escaping ([TopNew])->()){
    
    let url = URL(string: DataManager.LINKTOPNEW)!
    let parameters : Parameters = [ "build": "47",
                                    "hash": "5adb57b9e56b9c2a9f98133b8cb4d7ca",
                                    "time": "1476780483",
                                    "device_id": "F31AD414-B586-487E-AEB3-FBB428C97F2E",
                                    "category_id": "",
                                    "start": "0",
                                    "limit": "15",
                                    "device_os": "ios"]
    
    
    
    
    
    Alamofire.request(url , method: .post,parameters : parameters,encoding: URLEncoding.default).responseJSON { (response) in
        
        if let json = response.result.value as? [String : AnyObject]{
            var listTopNew = [TopNew]()
            let arrData = json["data"] as? [AnyObject]
            
            for data in arrData! {
                
                let catData = data as? [String : AnyObject]
                let topnew = TopNew.init(data: catData!)
                
                if (topnew != nil) {
                    listTopNew.append(topnew!)
                }
                
            }
            completion(listTopNew)
            
        }
        
    }
    
}
    
    //-- get Top Download
    
    
    func getTopDownload(completion : @escaping ([TopDownLoad])->()){
        
        let url = URL(string: DataManager.LINKTOPDOWLOAD)!
        let parameters : Parameters = [ "device_os": "ios",
                                        "device_id": "F31AD414-B586-487E-AEB3-FBB428C97F2E",
                                        "hash": "49ee22008fdd9c4b92ab925d581276e2",
                                        "time": "1476779062"]
        
        
       // let header: HTTPHeaders = [ "Content-Type" : "application/x-www-form-urlencoded"]
        
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { (response) in
            
           
            print(response)
            if let json = response.result.value as? [String : AnyObject]{
                
                print(json)
                
                
                var listTopDownload = [TopDownLoad]()
                let arrData = json["data"] as? [AnyObject]
                
                for data in arrData! {
                    
                    let catData = data as? [String : AnyObject]
                    let topDownload = TopDownLoad.init(data: catData!)
                    
                    if (topDownload != nil) {
                        listTopDownload.append(topDownload!)
                    }
                    
                }
                completion(listTopDownload)
                
            }
            
        }
        
    }
    
    
    
    //-- get detil catory 
    
    
    func getDetailCategory(completion : @escaping  (Detail)->()) {
        
        
        let url = URL(string: DataManager.LINKDETAILCATEGORY)!
        let parameters : Parameters = [  "comic_id": "55556cfa1dee5e781f8b4569",
                                         "device_os": "ios",
                                         "device_id": "F31AD414-B586-487E-AEB3-FBB428C97F2E",
                                         "hash": "b7605111cf0c9d34fff7bb48eda37fc6",
                                         "time": "1476781086"]
        
        
        
        
        
        Alamofire.request(url , method: .post,parameters : parameters,encoding: URLEncoding.default).responseJSON { (response) in
            
            if let json = response.result.value as? [String : AnyObject]{
                
                let arrData = json["data"] as? [String : AnyObject]
                let detail = Detail.init(data: arrData!)
                
                completion(detail!)
                
                
            }
            
        }

        
    }

    
    
     //-- get Read Story 
    
    
    func getChapterReadBook (completion : @escaping (ChapterRead)-> ()) {
        
        
        let url = URL(string: DataManager.LINKREADCHAPTER)!
        let parameters : Parameters = [  "chapter_id": "58024b0c026ecb151275182f",
                                         "device_id": "F31AD414-B586-487E-AEB3-FBB428C97F2E",
                                         "device_os": "ios",
                                         "time": "1476781666",
                                         "hash": "6fe21899eb4b0a89be92793a5d4f01fb"]
        
        
        
        
        
        Alamofire.request(url , method: .post,parameters : parameters,encoding: URLEncoding.default).responseJSON { (response) in
            
            if let json = response.result.value as? [String : AnyObject]{
                
                let arrData = json["data"] as? [String : AnyObject]
                let read = ChapterRead.init(data: arrData!)
                
                completion(read!)
                
                
            }
            
        }

    }

}



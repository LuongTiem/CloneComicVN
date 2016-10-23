//
//  MangagerData.swift
//  ComicVN
//
//  Created by ReasonAmu on 9/30/16.
//  Copyright © 2016 ReasonAmu. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ManagerData {
    
    static let LINKCATEGORY = "http://comicvn.net/truyentranh/apiv2/theloai"
    static let LINKSTORY = "http://comicvn.net/truyentranh/apiv2/theloai?id="
    static let LINKMOSTVIEW = "http://comicvn.net/truyentranh/apiv2/truyenhot"
    static let LINKCHAPTER = "http://comicvn.net/truyentranh/apiv2/truyenchap?id="
    static let LINKIMAGE = "http://comicvn.net/truyentranh/apiv2/hinhtruyen?id="
    static let LINKNEWSTORY = "http://comicvn.net/truyentranh/apiv2/truyenmoi"
    
    var list_Category:[CategoryStory] = []
    var list_Story:[Story] = []
    var list_MostViewStory :[StoryMostView] = []
    var list_ChapterStory : [ChapterStory] = []
    var list_Image : [ListImage] = []
    
    var dict_Story = [String: AnyObject]()
    var dict_ChapterStory = [String: AnyObject]()
    var dict_Image = [String: AnyObject]()
    
    static let instance = ManagerData()
    
    
    
    private init(){
        
    }
    
    //-- GET LIST CATEGORY
    func getAllCategory(completion : @escaping ([CategoryStory])-> ()){
        list_Category.removeAll()
        if (list_Category.count == 0 ){
            getCategory(completion: { [unowned self] category in
                self.list_Category = category
                completion(category)
                
                })
        }
        else{
            completion(list_Category)
        }
    }
    //-- GET LIST STORY
    func getAllStory(categoryID :String , completion : @escaping ([Story])->() ){
        
        list_Story.removeAll()
        if (list_Story.count == 0) {
            getStoryWithCategory(categoryID: categoryID, completion: { [unowned self] story in
                self.list_Story = story
                completion(story)
                })
        }
        else{
            //cho nay day neu co du lieu lan dau roi no tra ve du lieu cu ok vay h check j de no tra ve moi ha ong
            //request toan ve 605 ma dung co 10 :(
            //tuy logic bon ong thoi
            //ong hoi xem may ong kia muon nhu nao
            //logic nay la neu request roi thi lan sau request tra ve du lieu cu
            completion(list_Story)
        }
    }
    //-- GET LIST CHAPTER
    func getAllChapter(storyID :String , completion : @escaping ([ChapterStory])-> ()){
        
        list_ChapterStory.removeAll()
        if (list_ChapterStory.count == 0 ){
            getChapterStory(storyID: storyID, completion: { [unowned self] chapter in
                self.list_ChapterStory = chapter
                completion(chapter)
                })
        }else{
            completion(list_ChapterStory)
        }
    }
    
    //-- GET LIST MOST STORY VIEW
    func getAllMostViewStory(completion : @escaping ([StoryMostView])->()){
        list_MostViewStory.removeAll()
        if (list_MostViewStory.count == 0){
            getStoryMostView(completion: { [unowned self] mostviewstory  in
                self.list_MostViewStory = mostviewstory
                completion(mostviewstory)
                })
        }else{
            completion(list_MostViewStory)
        }
    }
    
    //--GET LIST IMAGE
    
    func getAllImageInChapter(chapterID :String , completion : @escaping ([ListImage])->()){
        list_Image.removeAll()
        if (list_Image.count == 0 ){
            getImageInChapter(chapterID: chapterID, completion: { [unowned self] imageInChapter in
                self.list_Image = imageInChapter
                completion(imageInChapter)
                })
        }else{
            completion(list_Image)
        }
    }
    
    
    
    //MARK - Lay tung du lieu 1 theo compliteHandel
    
    //-- get the loai truyen
     func getCategory(completion : @escaping ([CategoryStory]) -> ()){
        let url = URL(string: ManagerData.LINKCATEGORY)
        Alamofire.request(url!).responseJSON { (responseCategory) in //-- clouse tra ve
            
            if let json = responseCategory.result.value {
                
                for catJSon in json as! [AnyObject] {
                    let categoryObj = catJSon as! [String : AnyObject]
                    let category = CategoryStory.init(JSON: categoryObj)
                    self.list_Category.append(category!)
                }
                
                completion(self.list_Category)
                
            }
            
        }
    }
    
    
    
    //-- get list truyen trong the loai
    func getStoryWithCategory(categoryID : String, completion : @escaping ([Story]) -> ()){
        self.list_Story.removeAll()
        let url = ManagerData.LINKSTORY + "\(categoryID)"

        Alamofire.request(url).responseJSON { (response) in
            
            if let json = response.result.value {
                
                for catJSon in json as! [AnyObject] {
                    let storyObj = catJSon as! [String : AnyObject]
                    let story = Story.init(JSon: storyObj)
                    self.list_Story.append(story!)
                }
                
                completion(self.list_Story)
                
                
            }
        }
        
    }
    
    //-- get chapter trong truyen
    func getChapterStory(storyID : String, completion : @escaping ([ChapterStory])-> ()){
        list_ChapterStory.removeAll()
        let url = ManagerData.LINKCHAPTER + "\(storyID)"
        
        Alamofire.request(url).responseJSON { (response) in
            
            if let json = response.result.value {
                
                for catJSon in json as! [AnyObject] {
                    let chapterObj = catJSon as! [String : AnyObject]
                    let chapter = ChapterStory.init(Json: chapterObj)
                    self.list_ChapterStory.append(chapter!)
                }
                
                completion(self.list_ChapterStory)
                
            }
        }
        
        
    }
    
    
    //-- get image in chapter
    
    private func getImageInChapter(chapterID : String , completion :@escaping ([ListImage])->()){
        let url = ManagerData.LINKIMAGE + "\(chapterID)"
        Alamofire.request(url).responseJSON { (response) in
            
            if let json = response.result.value {
                
                for imageStr in json as! [String] {
                    let imageObject = ListImage.init(JSon: imageStr)
                    self.list_Image.append(imageObject)
                    
                }
                completion(self.list_Image)
            }
        }
    }
    
    //-- get story MostView
    private func getStoryMostView(completion : @escaping ([StoryMostView])->()){
        
        let url = URL(string: ManagerData.LINKMOSTVIEW)
        Alamofire.request(url!).responseJSON { (responseCategory) in //-- clouse tra ve
            
            if let json = responseCategory.result.value {
                
                for catJSon in json as! [AnyObject] {
                    let mostviewObj = catJSon as! [String : AnyObject]
                    let mostview = StoryMostView.init(Json: mostviewObj)
                    self.list_MostViewStory.append(mostview!)
                }
                
                completion(self.list_MostViewStory)
                
            }
        }
        
    }
}

//
//  seeker.swift
//  sirjee
//
//  Created by Golak Sarangi on 11/1/15.
//  Copyright © 2015 Golak Sarangi. All rights reserved.
//

import Foundation


class Seeker {
    var image: String?
    var name : String?
    var description : String?
    var requirements : [[String: AnyObject]]?
    var id : Int?
    
    func addRequirements (amount: Int, reason : String, recurring: Bool) {
        requirements!.append([
            "amount": amount,
            "reason": reason,
            "recurring": recurring
        ])
    }
    
    func save (){
        let userDefault = NSUserDefaults.standardUserDefaults().objectForKey("allSeekers")
        var allSeekers : NSMutableDictionary?
        if (userDefault == nil) {
            allSeekers = NSMutableDictionary()
        } else {
            allSeekers = allSeekers?.mutableCopy() as? NSMutableDictionary
        }
        let count = allSeekers?.allKeys.count
        self.id = count! + 1
        let newSeeker = NSMutableDictionary();
        newSeeker["image"] = self.image
        newSeeker["name"] = self.name
        newSeeker["description"] = self.description
        newSeeker["requirements"] = self.requirements
        newSeeker["id"] = self.id
        allSeekers?.setValue(newSeeker, forKey: "\(id)")
    }
    
}
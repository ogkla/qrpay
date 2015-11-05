//
//  seeker.swift
//  sirjee
//
//  Created by Golak Sarangi on 11/1/15.
//  Copyright © 2015 Golak Sarangi. All rights reserved.
//

import Foundation
import Alamofire


class Seeker {
    var image: String?
    var name : String?
    var description : String?
    var requirements : [[String: AnyObject]]?
    var id : String?
    
    func addRequirements (amount: Int, reason : String, recurring: Bool) {
        requirements!.append([
            "amount": amount,
            "reason": reason,
            "recurring": recurring
        ])
    }
    
    func save (){
        let newSeeker = NSMutableDictionary();
        newSeeker["userAlias"] = self.name
        newSeeker["userId"] = self.id
        newSeeker["otherUserDetails"] = [String: String]();
        newSeeker["otherUserDetails"]?.setValue(self.image, forKey: "image")
        newSeeker["otherUserDetails"]!.setValue(self.description, forKey: "description")
        newSeeker["otherUserDetails"]!.setValue(self.requirements, forKey: "requirements");
        Alamofire.request(.POST, "\(Constants.serverIp)/v1/money/createuser", parameters: newSeeker)
        
    }
    
}
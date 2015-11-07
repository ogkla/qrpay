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
    var requirements : [[String: String]]?
    var id : String?
    var accountMoney: Int?
    
    func addRequirements (amount: Int, reason : String, recurring: String) {
        if self.requirements == nil {
            requirements = [[
                "amount": "\(amount)",
                "reason": reason,
                "recurring": recurring
            ]]
        } else {
            requirements!.append([
                "amount": "\(amount)",
                "reason": reason,
                "recurring": recurring
            ])
        }
    }
    
    func save (){
        var otherUserDetails :[String : AnyObject] = [String : AnyObject]()
        
        if self.description != nil {
            otherUserDetails["description"] = self.description
        }
        
        
        if self.image != nil {
            otherUserDetails["image"] = self.image!
        }
        
        if self.requirements != nil {
            otherUserDetails["requirements"] = self.requirements!
        }
        
        let newSeeker = [
            "userAlias" : self.name!,
            "userId" : self.id!,
            "otherUserDetails" : otherUserDetails
        ]
        NSUserDefaults.standardUserDefaults().setObject(self.id!, forKey: "seekerId")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        Alamofire.request(.POST, "http://\(Constants.serverIp):\(Constants.serverPort)/v1/money/createuser", parameters: (newSeeker as! [String : AnyObject])).responseJSON { response in
            debugPrint(response)
        }
    }
    
    static func fetchById(seekerId : String, handler: (Seeker) -> Void) -> Void {
        let parameters = [
            "userId" : seekerId
        ]
        Alamofire.request(.POST, "http://\(Constants.serverIp):\(Constants.serverPort)/v1/money/getuserdetails", parameters: parameters).responseJSON { response in
            let seeker = Seeker()
            switch response.result {
            case .Success(let data):
                let responseObj = data as! [String : NSObject]
                
                let obj = responseObj["data"] as! [String : NSObject]
                
                seeker.name = (obj["SubscriberAlias"] as! String)
                seeker.id = (obj["SubscriberId"] as! String)
                let otherUserDetails = obj["otherUserDetails"] as! [String: NSObject]
                if otherUserDetails["description"] != nil {
                    seeker.description = (otherUserDetails["description"] as! String)
                }
                if otherUserDetails["image"] != nil {
                    seeker.image = (otherUserDetails["image"] as! String)
                }
                if otherUserDetails["requirements"] != nil {
                    seeker.requirements = (otherUserDetails["requirements"] as! [[String: String]])
                }
                seeker.accountMoney = obj["totalMoney"] as? Int
                handler(seeker)
            case .Failure(let error):
                print("Request failed with error: \(error)")
            }
            
            
        }
    }
    
    static func getCurrentSeeker(handler: (Seeker) -> Void) -> Void  {
        let seekerId = NSUserDefaults.standardUserDefaults().objectForKey("seekerId") as? String
        self.fetchById(seekerId!, handler: handler)
    }
    
}
//
//  SeekerDetailsPage.swift
//  sirjee
//
//  Created by Golak Sarangi on 11/4/15.
//  Copyright © 2015 Golak Sarangi. All rights reserved.
//

import UIKit
import Alamofire

class SeekerDetailsPage: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var seekerId: String?
    var seeker: Seeker?
    var isOwner : Bool = false
    
    @IBOutlet weak var accountAmountLabel: UILabel!
    @IBOutlet weak var yourAccountLabel: UILabel!

    @IBOutlet weak var requirementTable: UITableView!
    @IBOutlet weak var payAmountSegmentedControl: UISegmentedControl!
    @IBOutlet weak var payTitleLabel: UILabel!
    @IBOutlet weak var descriptionTextField: UILabel!
    @IBOutlet weak var emailTextField: UILabel!
    @IBOutlet weak var nameTextField: UILabel!
    override func viewDidLoad() {
        if (seeker != nil) {
            seekerId = seeker!.id!
        }
        print("1")
        getSeekerDetails();
        print("2")
        playWithLabels()
        print("3")
        requirementTable.delegate = self
        print("4")
        requirementTable.dataSource = self
        print("5")
    }
    
    func playWithLabels() {
        if (isOwner) {
            accountAmountLabel.hidden = false
            yourAccountLabel.hidden = false
            payAmountSegmentedControl.hidden = true
            payTitleLabel.hidden = true
        } else {
            accountAmountLabel.hidden = true
            yourAccountLabel.hidden = true
            payAmountSegmentedControl.hidden = false
            payTitleLabel.hidden = false
        }
    }
    func getSeekerDetails() {
        Seeker.fetchById(seekerId!, handler: seekerDetailHandler)
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        let paymentObj = Payment.getFromUserDefault()
        if paymentObj == nil {
            return true;
        } else {
            paymentObj!.transaction(seeker!, money: 2, callHandler: afterPayment);
            return false
        }
    }
    
    func afterPayment(response: String) {
        var message : String?
        if (response == "Success") {
            message = "Successfully sent"
        } else {
            message = "Error in sending"
        }
        let alertController = UIAlertController(title: "Required", message:
            message!, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)

        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let vc = segue.destinationViewController as! PayDetailsViewController
        vc.moneyToPay = 2
        vc.seeker = seeker
    }

    func seekerDetailHandler(seeker: Seeker) {
        self.seeker = seeker
        nameTextField.text = seeker.name!
        emailTextField.text = seeker.id!
        descriptionTextField.text = seeker.description
        if (isOwner) {
            accountAmountLabel.text = "You have $\(seeker.accountMoney! ?? 0)"
        }
        print("reloading table now")
        requirementTable.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("7")
        if (seeker?.requirements != nil) {
            print(seeker!.requirements)
            return seeker!.requirements!.count
        } else {
            return 0;
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("seekerCell") as! SeekerCell
        var currReq = seeker!.requirements![indexPath.row]
        cell.reqAmountLabel.text = currReq["amount"]!
        cell.reqReasonLabel.text = currReq["reason"]!
        cell.reqRecurrDaily.text = currReq["recurring"]!
        return cell
    }
}


class SeekerCell : UITableViewCell {

    @IBOutlet weak var reqRecurrDaily: UILabel!
    @IBOutlet weak var reqAmountLabel: UILabel!
    @IBOutlet weak var reqReasonLabel: UILabel!
}

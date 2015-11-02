//
//  RequirementViewController.swift
//  sirjee
//
//  Created by Golak Sarangi on 11/1/15.
//  Copyright © 2015 Golak Sarangi. All rights reserved.
//

import UIKit

class RequirementViewController: UIViewController {
    var currentSeeker : Seeker?

    @IBOutlet weak var recurringSwitch: UISwitch!
    @IBOutlet weak var reasonTextField: UITextView!
    @IBOutlet weak var amountTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save(sender: UIButton) {
        let amountText = amountTextField.text
        
        if amountText == "" {
            return
        }
        let amount = Int(amountText!)
        let reason = reasonTextField.text
        let recurring = recurringSwitch.on

        
        currentSeeker?.addRequirements(amount!, reason: reason, recurring: recurring)
        
        self.dismissViewControllerAnimated(true, completion:nil)
    }

    @IBAction func cancelView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  FormViewController.swift
//  sirjee
//
//  Created by Golak Sarangi on 11/1/15.
//  Copyright © 2015 Golak Sarangi. All rights reserved.
//

import UIKit

class FormViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    var currentSeeker : Seeker?
    override func viewDidLoad() {
        currentSeeker = Seeker()
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch(segue.identifier!) {
            case "addRequirement":
                let vc = segue.destinationViewController as! RequirementViewController
                vc.currentSeeker = currentSeeker
            case "saveForm":
                let vc = segue.destinationViewController as! SeekerQRViewController
                saveButtonClicked();
                vc.currentSeeker = currentSeeker
            default:
                print("invalid segue")
        }
        
    }
    

    func saveButtonClicked() {
        currentSeeker!.name = nameTextField.text
        currentSeeker!.description = descriptionTextField.text
        currentSeeker!.id = emailTextField.text
        currentSeeker!.save()
    }
    
    
    @IBAction func addImage(sender: UIButton) {
        
    }

}

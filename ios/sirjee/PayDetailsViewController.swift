//
//  PayDetailsViewController.swift
//  sirjee
//
//  Created by Golak Sarangi on 11/5/15.
//  Copyright © 2015 Golak Sarangi. All rights reserved.
//

import UIKit

class PayDetailsViewController: UIViewController {

    @IBOutlet weak var cardHolderNamerTextField: UITextField!
    @IBOutlet weak var zipcodeTextField: UITextField!
    @IBOutlet weak var cardNumberTextField: UITextField!
    @IBOutlet weak var expDateTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!

    var seeker : Seeker?
    var moneyToPay : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerPaymentDetails(sender: UIButton) {
        let payment = Payment()
        payment.cardCvv = Int(cvvTextField.text!)
        payment.cardExpDate = expDateTextField.text!
        payment.cardHolderName = cardHolderNamerTextField.text!
        payment.cardNumber = Int(cardNumberTextField.text!)
        payment.zipCode = Int(zipcodeTextField.text!)
        payment.cardEmail = emailTextField.text!
        payment.save()

        payment.transaction(seeker!, money: moneyToPay!, callHandler: afterPayment)
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

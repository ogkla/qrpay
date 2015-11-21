//
//  ViewController.swift
//  TeachKit
//
//  Created by Golak Sarangi on 11/14/15.
//  Copyright © 2015 Golak Sarangi. All rights reserved.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {

    @IBOutlet weak var problemTextView: UITextView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var drawCanvas: UIView!
    
    @IBOutlet weak var timeTakenLabel: UILabel!
    var personImagesView = [UIImageView]()
    
    var allPersons = [Person]()
    
    var circle : CircleView?
    
    var occurenceCount: Int?
    var totalTimeTaken : Int?
    var currTime : Int = 0
    
    var possibleColors = [UIColor.greenColor(), UIColor.blueColor(), UIColor.yellowColor(), UIColor.purpleColor(), UIColor.orangeColor()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(sender: AnyObject) {
        problemTextView.text = "";
        self.view.endEditing(true)
    }
    
    @IBAction func startExecuting(sender: UIButton) {
        execute();
    }

    
    @IBAction func doTheShit(sender: UIButton) {
        //doing the shit
        self.view.endEditing(true)
        allPersons = [Person]()
        personImagesView = [UIImageView]()
        timeTakenLabel.text = ""
        currTime = 0
        let parameters = [
            "text" : problemTextView.text!
        ]
        Alamofire.request(.POST, "http://\(Constants.server):\(Constants.port)/v1/languageprocessing", parameters: parameters).responseJSON { response in
            
            
            
            switch response.result {
            case .Success(let data):
                let statusCode = data["status"] as! Int
                if (statusCode == 200) {
                    self.buildIt(data["data"] as! [String : AnyObject])
                } else {
                    let alertController = UIAlertController(title: "Error", message:
                        "Watson failed", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            case .Failure(let error):
                print("Request failed with error: \(error)")
                let alertController = UIAlertController(title: "Error", message:
                        "APi failed", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            
        }
        
    }
    
    func buildIt(data: [String: AnyObject]) {
        print(data);

        let persons = data["person"] as! [String];
        let cardinals = data["cardinal"] as! [String];

        if (cardinals.count != persons.count) {
            let alertController = UIAlertController(title: "Error", message:
                "Same count of property not provided", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        circle = CircleView(frame: CGRectMake(0, 0, drawCanvas.frame.size.width, drawCanvas.frame.size.height))
        circle!.circumference = getCircumference((data["measure"] as! [String])[0])
        circle!.normalize()
        
        for(var i = 0; i < persons.count; i++) {
            let personObj = Person()
            personObj.image = UIImage(named: "person")
            personObj.identifier = persons[i]
            personObj.property = Int(cardinals[i])
            personObj.color = possibleColors[i]
            print("Circumference:- \(circle!.circumference)");
            personObj.calculate((circle!.circumference)!)
            allPersons.append(personObj)
        }
        

        
        occurenceCount = getOccurenceCount((data["ordinal"] as! [String])[0]);
        drawItAll()
        
    }
    
    func drawItAll() {
        print("draw it all")
        for view in drawCanvas.subviews{
            view.removeFromSuperview()
        }
        
        drawCanvas.addSubview(circle!)
        drawPeople()
        startButton.hidden = false
    }
    
    func drawPeople() {
        let pixelRadius = Int((drawCanvas.frame.size.width - 40) / 2)
        let startPosX = CGFloat(Int(drawCanvas.frame.width)/2 + pixelRadius)
        let startPosY = (drawCanvas.frame.height)/2

        for(var i = 0; i < allPersons.count; i++) {
            personImagesView.append(UIImageView(image: allPersons[i].image!))
            personImagesView[i].backgroundColor = allPersons[i].color
            personImagesView[i].frame = CGRectMake(startPosX, startPosY, 32, 32)
            drawCanvas.addSubview(personImagesView[i])
        }
    }
    
    
    func execute() {
        var allTime = [Int]()
        for(var i = 0; i < allPersons.count; i++) {
            allTime.append(Int(allPersons[i].timeTakenPerRound! * 3600))
        }
        totalTimeTaken = lcm(allTime)
        
        for(var i = 0; i < allPersons.count; i++) {
            allPersons[i].calculateTotal(Double(totalTimeTaken!)/3600.0)
        }

        startShowing(true)
        startButton.hidden = true
    }
    
    func startShowing(finished: Bool) {
        let timeDur = Int(Double(totalTimeTaken!) / Double(Constants.stepCount))
        
        currTime = currTime + timeDur
        if currTime <= totalTimeTaken {
            UIView.animateWithDuration(Constants.animationDuration, delay: Constants.timeGap, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                for(var i = 0; i < self.allPersons.count; i++) {
                    self.allPersons[i].calculateIntermediateDistance(Double(self.currTime)/3600.0)
                    //personImagesView[i].removeFromSuperview()
                    let(posX, posY) = self.circle!.getXYfromDistance(self.allPersons[i].intermediateDistance!)
                    self.personImagesView[i].frame = CGRectMake(posX, posY, 32, 32)
                    self.personImagesView[i].setNeedsDisplay()
                }
                self.timeTakenLabel.text = "Time Taken: \(self.currTime) s"
            }, completion: startShowing)
        }
        
    }
    
    
    func lcm(allTime: [Int]) -> Int {
        var currLcm = 1;
        var allDivisors = [Int: Int]()

        for(var i = 0; i < allTime.count; i++) {
            var num = allTime[i]
            let primenumbers = getPrimeNumbers(allTime[i])
            var divisors = [Int:Int]()
            for (var j = 0; j < primenumbers.count; j++) {
                if (num % primenumbers[j] == 0) {
                    let pm = primenumbers[j]
                    num = num / pm
                    j = j - 1
                    if (divisors[pm] != nil) {
                        divisors[pm] = divisors[pm]! +  1
                    } else {
                        divisors[pm] = 1
                    }
                }
            }
            
            for (kind, number) in divisors {
                if (allDivisors[kind] != nil) {
                    if allDivisors[kind] < number {
                       allDivisors[kind] = number
                    }
                } else {
                    allDivisors[kind] = number
                }
            }
        }
        
        for( num, power) in allDivisors {
            currLcm = currLcm * Int(pow(Double(num), Double(power)))
        }
        return currLcm
    }
    
    func getPrimeNumbers(maxVal :Int) ->[Int] {
        var primeNumbers = [Int]()
        for (var n = 2 ; n < maxVal; n++) {
            
            //set the flag to true initially
            var prime = true
            
            
            for var i = 2; i <= n - 1; i++ {
                
                //even division of a number thats not 1 or the number itself, not a prime number
                if n % i == 0 {
                    prime = false
                    break
                }
            }
            
            if prime == true {
                primeNumbers.append(n)
            }
            
        }
        return primeNumbers;
    }
    
    
    
    
    
    
    
    func getOccurenceCount(ordinal : String) -> Int {
        switch(ordinal.lowercaseString) {
        case "first":
            return 1;
        case "second":
            return 2;
        case "third":
            return 3;
        case "fourth":
            return 4;
        default:
            return 1;
        }
    }
    
    func getCircumference(measure : String) -> Double{
        var circumference : Double = 0.0
        if (measure.hasSuffix("meters")) {
            circumference = Double(measure.stringByReplacingOccurrencesOfString("meters", withString: "").stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()))!/1000
        } else if (measure.hasSuffix("km")) {
            circumference = Double(measure.stringByReplacingOccurrencesOfString("km", withString: ""))!
        }
        return circumference;
    }
    
    func keyboardWasShown(notification: NSNotification) {
        print("keyboard was shown");
    }
    
    
    func keyboardWillShow(sender: NSNotification) {
        print("keyboard show");
        self.view.frame.origin.y -= 200
    }
    
    func keyboardWillHide(sender: NSNotification) {
        print("keyboard hide");
        self.view.frame.origin.y += 200
    }
    

}


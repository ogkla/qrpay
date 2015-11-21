//
//  Subject.swift
//  TeachKit
//
//  Created by Golak Sarangi on 11/14/15.
//  Copyright © 2015 Golak Sarangi. All rights reserved.
//

import UIKit

class Person {
    var identifier : String?
    var image: UIImage?
    var property : AnyObject?
    var color: UIColor?
    
    var distanceCovered : Double?
    var timeTakenPerRound : Double?
    
    var intermediateTime : Double?
    var intermediateDistance : Double?
    
    func calculate(distancePerRound: Double) {
        timeTakenPerRound = distancePerRound / (property as! Double)
        print("time taken per round \(identifier):- \(timeTakenPerRound)")
    }
    
    func calculateTotal(totalTimeTaken: Double) {
        distanceCovered = totalTimeTaken * (property as! Double)
    }
    
    func calculateIntermediateDistance(t: Double) {
        intermediateTime = t
        intermediateDistance = t * (property as! Double)
    }
}

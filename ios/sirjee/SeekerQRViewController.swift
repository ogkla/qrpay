//
//  SeekerQRViewController.swift
//  sirjee
//
//  Created by Golak Sarangi on 11/1/15.
//  Copyright © 2015 Golak Sarangi. All rights reserved.
//

import UIKit

class SeekerQRViewController: UIViewController {
    var id: Int?
    
    @IBOutlet weak var qrImageView: UIImageView!
    
    
    override func viewDidLoad() {
        print("qrcode-\(id!)")
        qrImageView.image = UIImage(named: "qrcode-\(id!)")
    }
}

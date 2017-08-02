//
//  DetailVC.swift
//  demoTableView
//
//  Created by techmaster on 7/26/17.
//  Copyright © 2017 techmaster. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var imageFlag: UIImageView!
   
    @IBOutlet weak var lblCapital: UILabel!
    
    @IBOutlet weak var lblContry: UILabel!
    
     var dictCountry = NSMutableDictionary()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let test = dictCountry.value(forKey: "capital") as! String? //Biến test là các data có key là capital
        self.lblCapital.text = test
        
        self.lblContry.text = dictCountry.value(forKey: "coutry") as! String? //tên quốc gia
        
        let stringImage = dictCountry.value(forKey: "flag") as! String?
        
        self.imageFlag.image = UIImage(named: stringImage!) //Cờ quốc gia tương ứng

    }


}

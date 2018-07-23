//
//  ViewController.swift
//  DCCJMessageCenter
//
//  Created by Ghstart on 07/23/2018.
//  Copyright (c) 2018 Ghstart. All rights reserved.
//

import UIKit
import DCCJMessageCenter

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.
        DCCJMessageCenter().send(r: .sendMessage(type: .login, phone: "120")) { (data, e) in
            
        }
        
        // 2.
        DCCJMessageCenter().send(r: .verifyMessage(type: .thirdBind, phone: "110", code: "8899")) { (data, e) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


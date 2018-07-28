//
//  ViewController.swift
//  DCCJMessageCenter
//
//  Created by Ghstart on 07/23/2018.
//  Copyright (c) 2018 Ghstart. All rights reserved.
//

import UIKit
import DCCJMessageCenter
import DCCJConfig

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.
        let _ = DCCJMessageCenter().send(.sendMessage(type: .login, phone: "120")) { (result: Result<MessageCenterResponse, NSError>) in
            switch result {
            case .success(let value):
                print(value)
            case .failure(let e):
                print(e)
            }
        }
        
        // 2.
        let _ = DCCJMessageCenter().send(.verifyMessage(type: .thirdBind, phone: "110", code: "8899")) { (result: Result<MessageCenterResponse, NSError>) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


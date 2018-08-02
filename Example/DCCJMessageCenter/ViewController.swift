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
        DCCJMessageCenter().send(with: .sendMessage(type: .login, phone: "120")).data.observe { (result: Result<MessageCenterResponse>) in
            switch result {
            case .success(let value):
                print(value)
            case .failure(let e):
                print(e)
            }
        }
    
        
        // 2.
        DCCJMessageCenter().send(with: .verifyMessage(type: .thirdBind, phone: "110", code: "8899")).data.observe { (result: Result<MessageCenterResponse>) in
            switch result {
            case .success(let value):
                print(value)
            case .failure(let e):
                print(e)
            }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


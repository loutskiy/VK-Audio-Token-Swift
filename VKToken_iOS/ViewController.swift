//
//  ViewController.swift
//  VKToken_iOS
//
//  Created by Михаил Луцкий on 19/08/2019.
//  Copyright © 2019 Mikhail Lutskii. All rights reserved.
//

import UIKit
import VKAudioToken

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        TokenReceiverOfficial(login: "", pass: "").getToken(success: {(token, secret, deviceId) in
            print(token)
        }, fail: {(error) in
            print(error)
        })
        
        
        // Do any additional setup after loading the view.
    }


}


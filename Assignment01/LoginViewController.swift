//
//  ViewController.swift
//  Assignment01
//
//  Created by Yiping Guo on 9/01/2017.
//  Copyright © 2017 au.rmit.s3177105. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //let btnCreateRoom = UIButton(frame: CGRect(x: 400, y: 600, width: 200, height: 40))
        //btnCreateRoom.backgroundColor = UIColor.red
        //btnCreateRoom.setTitle("创建房间", for: .normal)
        //btnCreateRoom.addTarget(self, action: Selector("pressed"), for: .touchUpInside)
        //btnCreateRoom.tag = 1
        //self.view.addSubview(btnCreateRoom)
    }
    
    @IBOutlet weak var btnCreateRoom: UIButton!
    
    @IBAction func about(sender: AnyObject) {
        performSegue(withIdentifier: "about", sender: sender)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

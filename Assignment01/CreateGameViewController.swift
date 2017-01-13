//
//  CreateGameViewController.swift
//  Assignment01
//
//  Created by Yiping Guo on 12/01/2017.
//  Copyright © 2017 au.rmit.s3177105. All rights reserved.
//

import UIKit

class CreateGameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 414, height: 64))
        self.view.addSubview(navBar)
        let navItem = UINavigationItem(title: "Setup")
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: nil, action: #selector(getter: UIAccessibilityCustomAction.selector))
        navItem.rightBarButtonItem = doneItem
        navBar.setItems([navItem], animated: false)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

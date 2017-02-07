//
//  VideoViewController.swift
//  Assignment01
//
//  Created by Yiping Guo on 30/01/2017.
//  Copyright © 2017 au.rmit.s3177105. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {
    
    @IBOutlet weak var youtubeWebView: UIWebView!
    @IBOutlet weak var txtTitle: UITextView!
    @IBOutlet weak var txtDescript: UITextView!
    
    var mytitle: String!
    var mydescript: String!
    var myvideoId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let videoURL = "<iframe width=\"396\" height=\"300\" src=\"https://www.youtube.com/embed/" + myvideoId + "\" frameborder=\"0\" allowfullscreen></iframe>"
        
        txtTitle.text = mytitle
        txtDescript.text = mydescript
        youtubeWebView.loadHTMLString(videoURL, baseURL: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

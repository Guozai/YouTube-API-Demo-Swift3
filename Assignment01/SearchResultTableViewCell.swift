//
//  SearchResultTableViewCell.swift
//  Assignment01
//
//  Created by Yiping Guo on 30/01/2017.
//  Copyright © 2017 au.rmit.s3177105. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoDescription: UILabel!
    @IBOutlet weak var videoThumbnail: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateIU(video: Dictionary<String, AnyObject>) {
        videoTitle.text = video["title"] as? String
        videoDescription.text = video["description"] as? String
        
        let imageURL = URL(string: (video["thumbnail"] as? String)!)!
        DispatchQueue.global().async {
            do {
                let imageData = try Data(contentsOf: imageURL)
                DispatchQueue.global().async {
                    self.videoThumbnail.image = UIImage(data: imageData)
                }
            } catch {
                print("Couldn't get image: Image is nil")
            }
        }
    }
    
}

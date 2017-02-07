//
//  SearchVideoViewController.swift
//  Assignment01
//
//  Created by Yiping Guo on 28/01/2017.
//  Copyright © 2017 au.rmit.s3177105. All rights reserved.
//

import UIKit
import AVFoundation

class SearchVideoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate {
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    // Set up a network session
    let session = URLSession.shared
    
    // ReST GET static String parts
    let BASE_URL: String = "https://www.googleapis.com/youtube/v3/"
    let SEARCH_VIDEO: String = "search?part=snippet&q="
    let VIDEO_TYPE: String = "&type=video&key="
    let API_KEY: String = "AIzaSyDDqTGpVR7jxeozoOEjH6SLaRdw0YY-HPQ"
    
    @IBAction func btnSearchClicked(_ sender: UIButton) {
        getVideoList()
    }
    
    func getVideoList() {
        
        let methodArguments: [String: AnyObject] = [
            "query": txtSearch.text! as AnyObject
        ]
        
        // Format the search string (video title) for http request
        let videoTitle: String = escapedParameters(methodArguments)
        
        // Make the query url
        // sample: https://www.googleapis.com/youtube/v3/search?part=snippet&q=werewolf&type=video&key=AIzaSyDDqTGpVR7jxeozoOEjH6SLaRdw0YY-HPQ
        let searchVideoByTitle = BASE_URL + SEARCH_VIDEO + videoTitle + VIDEO_TYPE + API_KEY
        if let url = URL(string: searchVideoByTitle) {
            let request = URLRequest(url: url)
            // Initialise the task for getting the data
            initialiseTaskForGettingData(request, element: "items")
        }
    }
    
    // Array to store all the desired values dictionaries
    var videosArray: Array<Dictionary<String, AnyObject>> = [[String: AnyObject]]()
    
    func initialiseTaskForGettingData(_ request: URLRequest, element: String) {
        
        // Initialize task for getting data
        // Refer to http://www.appcoda.com/youtube-api-ios-tutorial/
        let task = session.dataTask(with: request, completionHandler: {(data, HTTPStatusCode, error) in
            // Handler in the case of an error
            if error != nil {
                print(error as Any)
                return
            }
            else {
                // Parse that data received from the service
                let resultDict: [String: AnyObject]!
                do {
                    // Convert the JSON data to a dictionary
                    resultDict = try JSONSerialization.jsonObject(with: data! as Data, options: .allowFragments) as! [String: AnyObject]
        
                    // Get the first item from the returned items
                    if let itemsArray = (resultDict as AnyObject).value(forKey: element) as? NSArray {
                        
                        // Remove all existing video data
                        self.videosArray.removeAll()
                        
                        for index in 0..<itemsArray.count {
                            
                            // Append the desiredVaules dictionary to the videos array
                            self.videosArray.append(self.unwrapYoutubeJson(arrayToBeUnwrapped: itemsArray, index: index))
                            
                        }
                        
                        // Asynchronously reload the data and display on the tableview 
                        DispatchQueue.main.async {
                            // Reload the tableview
                            self.searchResultTableView.reloadData()
                        }
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
            }
        })
        // Execute the task
        task.resume()
    }
    
    func unwrapYoutubeJson(arrayToBeUnwrapped: NSArray, index: Int) -> [String: AnyObject]{
        
        let firstItemDict = arrayToBeUnwrapped[index] as! [String: AnyObject]
        
        // Get the snippet dictionary that contains the desired data
        let snippetDict = firstItemDict["snippet"] as! [String: AnyObject]
        
        // Dictionary to store desired video contents for display on tableview
        // desired values - "Title", "Description", "Thumbnail"
        var desiredValuesDict = [String: AnyObject]()
        
        desiredValuesDict["title"] = snippetDict["title"]
        desiredValuesDict["description"] = snippetDict["description"]
        
        // Further unwrap to get the Thumbnail default URL
        let thumbnailDict: [String: AnyObject]
        thumbnailDict = snippetDict["thumbnails"] as! [String: AnyObject]
        let defaultThumbnailDict = thumbnailDict["default"] as! [String: AnyObject]
        
        desiredValuesDict["thumbnail"] = defaultThumbnailDict["url"]
        
        //Get the id dictionary that contains videoId
        let idDict = firstItemDict["id"] as! [String: AnyObject]
        desiredValuesDict["videoId"] = idDict["videoId"]
        
        return desiredValuesDict
    }
    
    // Helper function: Given a dictionary of parameters, convert to a string for a url
    func escapedParameters(_ parameters: [String : AnyObject]) -> String {
        
        var urlVars = [String]()
        
        for (key, value) in parameters {
                
            // Make sure that it is a string value
            let stringValue = "\(value)"
                
            // Escape it
            let escapedValue = stringValue.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                
            //Append it
                urlVars += [key + "=" + "\(escapedValue!)"]
        }
            
        return (!urlVars.isEmpty ? "" : "") + urlVars.joined(separator: "&")
    }
    
    // MARK: UITableView method implementation
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchResultTableViewCell
        
        let videoSelected = videosArray[indexPath.row]
        cell.updateIU(video: videoSelected)
            
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videosArray.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? VideoViewController {
            if let selectedRowIndexPath = searchResultTableView.indexPathForSelectedRow?.row {
                destination.mytitle = videosArray[selectedRowIndexPath]["title"] as! String
                destination.mydescript = videosArray[selectedRowIndexPath]["description"] as! String
                destination.myvideoId = videosArray[selectedRowIndexPath]["videoId"] as! String
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set table view delegate to self
        searchResultTableView.dataSource = self
        searchResultTableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

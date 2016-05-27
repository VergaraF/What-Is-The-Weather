//
//  ViewController.swift
//  What Is The Weather
//
//  Created by Fabian Vergara on 2016-05-18.
//  Copyright © 2016 fvergara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var userInput: UITextField!
    @IBOutlet var weatherLabel: UILabel!
    
    var websiteToScrap: String = ""
    
    @IBAction func goBtnListener(sender: AnyObject) {
       // websiteToScrap = initWebsiteString(userInput.text!)
        let url = NSURL(string: initWebsiteString(userInput.text!))!
        
        /* /!\It downloads the HTML data from the website and displays it */
         
         let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
            // will happen when task completes (closure)
         
            if let urlContent = data{
            
         
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
         
                dispatch_async(dispatch_get_main_queue(), {
                // self.webView.loadHTMLString(String(webContent), baseURL: nil)
                    self.setWeatherLabel(webContent!)
         
                })
            
         
         
                print(webContent)
         
            }else{
            
                //show error message
                print(error)
            }
        
        
        }
        
         
         task.resume()

    }
    
    private func initWebsiteString(city: String) -> String{
        return "http://www.weather-forecast.com/locations/" + city + "/forecasts/latest"
        
    }
    
    private func setWeatherLabel(webContent: NSString){
        if webContent.containsString("phrase"){
            print("the city exist")
            
        }else{
            self.weatherLabel.text = "Sorry, this city doesn't exist... yet!"
            self.weatherLabel.textColor = UIColor.redColor()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  What Is The Weather
//
//  Created by Fabian Vergara on 2016-05-18.
//  Copyright © 2016 fvergara. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var userInput: UITextField!
    @IBOutlet var weatherLabel: UILabel!
    
    var websiteToScrap: String = ""
    let stringDelimeter = "<span class=\"phrase\">"
    
    @IBAction func goBtnListener(sender: AnyObject) {
       // websiteToScrap = initWebsiteString(userInput.text!)
        let attemptedUrl = NSURL(string: initWebsiteString(userInput.text!.stringByReplacingOccurrencesOfString(" ", withString: "-")))
        
        if let url = attemptedUrl{
            
        
        
        /* /!\It downloads the HTML data from the website and displays it */
         
         let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            
            // will happen when task completes (closure)
         
            if let urlContent = data{
            
         
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
         
                dispatch_async(dispatch_get_main_queue(), {
                // self.webView.loadHTMLString(String(webContent), baseURL: nil)
                    self.setWeatherLabel(webContent!)
         
                })
            //    print(webContent)
         
            }else{
            
                //show error message
                print("error")
            }
        
        
        }
        
         
         task.resume()
        }else{
            self.setWeatherLabelHelper(UIColor.redColor(), label: "This city doesn't exist... yet!")
        }

    }
    
    private func initWebsiteString(city: String) -> String{
        return "http://www.weather-forecast.com/locations/" + city + "/forecasts/latest"
        
    }
    
    private func setWeatherLabel(webContent: NSString){
        
        if webContent.containsString(self.stringDelimeter){
            print("the city exist")
            
            var forecast = [String]()
            
            var localStringDelimeter = self.stringDelimeter
            
    
            forecast = webContent.componentsSeparatedByString(localStringDelimeter)
            localStringDelimeter = "</span>"
            let forecastToBeSetToLabel = forecast[1].componentsSeparatedByString(localStringDelimeter)
            
            setWeatherLabelHelper(UIColor.blackColor(), label: forecastToBeSetToLabel[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º"))
        //    print(forecastToBeReturned[0])
            
            
            
        }else{
            setWeatherLabelHelper(UIColor.redColor(), label: "Sorry, this city doesn't exist... yet!")
        }
        
    }
    
    private func setWeatherLabelHelper(colour: UIColor, label: String){
        self.weatherLabel.textColor = colour
        
        self.weatherLabel.text = label
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userInput.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


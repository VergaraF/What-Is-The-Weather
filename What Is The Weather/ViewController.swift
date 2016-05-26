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
        websiteToScrap = initWebsiteString(userInput.text!)
    }
    
    private func initWebsiteString(city: String) -> String{
        return "http://www.weather-forecast.com/locations/" + city + "/forecasts/latest"
        
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


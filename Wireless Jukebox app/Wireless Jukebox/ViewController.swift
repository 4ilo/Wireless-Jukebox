//
//  ViewController.swift
//  Wireless Jukebox
//
//  Created by Olivier on 21/03/16.
//  Copyright © 2016 Olivier. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var song1Button: UIButton!
    @IBOutlet var song2Button: UIButton!
    @IBOutlet var song3Button: UIButton!
    @IBOutlet var song4Button: UIButton!
    @IBOutlet var message: UILabel!

    @IBOutlet var ipAdress: UITextField!
    
    
    @IBAction func refreshPushed(sender: AnyObject)
    {
        getTitelsVanEsp()
    }

    //
    //  Als 1 van de knoppen ingedrukt is, sturen we een request naar de server
    //
    @IBAction func songPressed(sender: UIButton)
    {
        let knopId = sender.tag
        
        let url = "http://" + ipAdress.text!;
        Alamofire.request(.GET, url , parameters: ["next": knopId])
    }
    
    
    //  Een object voor een custom request
    var alamofireManager : Alamofire.Manager?
    
    
    //
    //  Deze fuctie haalt de data op van de esp webserver en zet ze op de knoppen
    func getTitelsVanEsp()
    {
        
        let url = "http://" + ipAdress.text!;
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForResource = 2 // seconds
        
        self.alamofireManager = Alamofire.Manager(configuration: configuration)
        
        self.alamofireManager!.request(.GET, url , parameters: ["titels": "1"])
            .responseJSON { response in
                
                if(response.result.error != nil)
                {
                    self.hideButtons()
                }
                else
                {
                    self.showButtons()
                    if let json = response.result.value {
                    
                    let jsonData = JSON(json)
                    
                    self.song1Button.setTitle(jsonData[0,"Titel"].stringValue, forState: UIControlState.Normal)
                    self.song2Button.setTitle(jsonData[1,"Titel"].stringValue, forState: UIControlState.Normal)
                    self.song3Button.setTitle(jsonData[2,"Titel"].stringValue, forState: UIControlState.Normal)
                    self.song4Button.setTitle(jsonData[3,"Titel"].stringValue, forState: UIControlState.Normal)
                    
                }
            }
        }
    }
    
    func hideButtons()
    {
        self.song1Button.hidden = true;
        self.song2Button.hidden = true;
        self.song3Button.hidden = true;
        self.song4Button.hidden = true;
        self.message.hidden = false;
    }
    
    func showButtons()
    {
        self.song1Button.hidden = false;
        self.song2Button.hidden = false;
        self.song3Button.hidden = false;
        self.song4Button.hidden = false;
        self.message.hidden = true;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getTitelsVanEsp()
        ipAdress.delegate=self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }


}


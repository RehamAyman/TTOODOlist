//
//  welcomeViewController.swift
//  TTOODOlist
//
//  Created by Reham Ayman on 10/5/20.
//  Copyright © 2020 Reham Ayman. All rights reserved.
//

import UIKit

import MOLH


class welcomeViewController: UIViewController {
    @IBAction func arbutton(_ sender: Any) {
    }
    
    @IBAction func engbutton(_ sender: UIButton) {
    }
    
    
    @IBOutlet weak var button1: UIButton!
    
    
   
   
    
   
    
    
    @IBOutlet weak var button2: UIButton!
    
    @IBAction func buttonar(_ sender: UIButton) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "navcon") as! UINavigationController
                  MOLH.setLanguageTo("ar")
               self.present(nextViewController, animated:true, completion:nil)
                   
        
            
                
            
    }
        
        
        
    @IBAction func buttonen(_ sender: UIButton) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
               let nextViewController = storyBoard.instantiateViewController(withIdentifier: "navcon") as! UINavigationController
                  MOLH.setLanguageTo("en")
               self.present(nextViewController, animated:true, completion:nil)
       
    }
    
    
    
    
    
    override func viewDidLoad() {

       
        
    
    }
    

    
}


 


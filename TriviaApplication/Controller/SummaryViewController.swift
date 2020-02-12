//
//  SummaryViewController.swift
//  Trivia App
//
//  Created by mysmac_admin on 11/02/20.
//  Copyright © 2020 Mridula. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    
    
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Player: UILabel!
    @IBOutlet weak var Color: UILabel!
    
    var name = ""
    var player = ""
    var flagColor = ""
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.DisplaySummary()
    }
    
    //MARK:- DISPLAYING SUMMARY DATA
    func DisplaySummary()
    {
        self.Name.text = "Hello \"Name:\"" + name
        self.Player.text = "Answer:" + " \"" + player + "\""
        self.Color.text = "Answer"  + " \"" + flagColor + "\""
    }
    
    //MARK:- NAVIGATE BACK TO MAIN CONTROLLER
    @IBAction func ByeAction(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
}

//
//  ViewController.swift
//  Trivia App
//
//  Created by mysmac_admin on 11/02/20.
//  Copyright © 2020 Mridula. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var NameTxtFd: UITextField!
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Trivia App"
        
    }

    //MARK:- NEXT BUTTON TAPPED ACTION
    @IBAction func NextAction(_ sender: Any)
    {
        if !self.NameTxtFd.text!.isEmpty
        {
           let storyBoard : UIStoryboard = UIStoryboard(name: "Player", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
            nextViewController.name = self.NameTxtFd.text!
            self.present(nextViewController, animated:true, completion:nil)
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Please enter your name", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}


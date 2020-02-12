//
//  PlayerViewController.swift
//  Trivia App
//
//  Created by mysmac_admin on 11/02/20.
//  Copyright © 2020 Mridula. All rights reserved.
//

import UIKit

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var PlayerTableView: UITableView!
    
    var NewArrayIndex : [String] = []
    var NewTickArrayIndex : [Int] = []
    var dataArray = ["Sachin Tendulkar","Virat Kolli","Adam Gilchirst","Jacques Kallis"]
    var name = ""

    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK:- NEXT BUTTON TAPPED ACTION
    @IBAction func NextAction(_ sender: Any)
    {
        if self.NewTickArrayIndex.count > 0
        {
            let storyBoard : UIStoryboard = UIStoryboard(name: "Player", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FlagViewController") as! FlagViewController
            nextViewController.name = name
            nextViewController.player = self.dataArray[NewTickArrayIndex[0]]
            self.present(nextViewController, animated:true, completion:nil)
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Please select one player", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)

        }
    }
}

//MARK:- TABLE VIEW METHODS
extension PlayerViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PlayerTableViewCell
        cell!.PpayerLabel.text = self.dataArray[indexPath.row]
        
        if NewTickArrayIndex.contains(indexPath.row)
        {cell?.imageView!.image = UIImage(named:"checked_checkbox")!}
        else
        {cell?.imageView!.image = UIImage(named:"unchecked_checkbox")!}
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let reasonValue : String = String(indexPath.row)
        let rowCountValueInt : Int = indexPath.row
        
        
        if !NewTickArrayIndex.contains(rowCountValueInt){
            NewTickArrayIndex.removeAll()
            NewTickArrayIndex.insert(rowCountValueInt, at: 0)
        }
        else {
            NewTickArrayIndex.removeAll()
        }
        
        
        //Warning are there since we are using static data here and values are not repeated
//        if NewArrayIndex.contains(reasonValue)
//        {
//            if let index = NewArrayIndex.index(of: reasonValue)
//            {
//                NewArrayIndex.remove(at: index)
//            }
//            if let index1 = NewTickArrayIndex.index(of: rowCountValueInt)
//            {
//                NewTickArrayIndex.remove(at: index1)
//            }
//        }
//        else{
//
//
//
//            if NewArrayIndex.contains(reasonValue){
//                if let index = NewArrayIndex.index(of: reasonValue)
//                {
//                    NewArrayIndex.remove(at: index)
//                }
//                if let index1 = NewTickArrayIndex.index(of: rowCountValueInt)
//                {
//                    NewTickArrayIndex.remove(at: index1)
//                }
//            }
//
//            if NewArrayIndex.count == 0 {
//                NewArrayIndex.append(reasonValue)
//                NewTickArrayIndex.append(rowCountValueInt)
//            }
//
//
//
//
//
//        }
        
        
        
        PlayerTableView?.reloadData()
    }
}


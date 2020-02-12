//
//  FlagViewController.swift
//  Trivia App
//
//  Created by mysmac_admin on 11/02/20.
//  Copyright © 2020 Mridula. All rights reserved.
//

import UIKit
import CoreData

class FlagViewController: UIViewController {
    
    @IBOutlet weak var FlagTableView: UITableView!
    
    var NewArrayIndex : [String] = []
    var NewTickArrayIndex : [Int] = []
    var dataArray = ["White", "Yellow", "Orange" , "Green"]
    var name = ""
    var player = ""
    var date_time = ""
    var count = 0
    let date = Date()
    
    //MARK:- VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "History"
        //self.DeleteDataFromDB()
        self.DateFormat()
    }
    
    //MARK:- CONSTRUCT DATE IN REQUIRED FORMAT
    func DateFormat()
    {
        count += 1
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM hh:mm a"
        let departuredate = formatter.string(from: date)
        print("departuredate is \(departuredate)")
        self.date_time = departuredate
        self.date_time.insert("t", at: date_time.index(date_time.startIndex, offsetBy: 2))
        self.date_time.insert("h", at: date_time.index(date_time.startIndex, offsetBy: 3))
        self.date_time.insert(" ", at: date_time.index(date_time.startIndex, offsetBy: 4))
        self.date_time = "GAME " + String(count) + " : " + date_time
     }
    
    //MARK:- NAVIGATE TO SUMMARY PAGE
    @IBAction func DoneAction(_ sender: Any)
    {
        var colors = ""
        for index in NewTickArrayIndex
        {
            colors = colors + ", " + dataArray[index]
        }
        
        colors.remove(at: colors.startIndex)
        if self.NewArrayIndex.count > 0
        {
            self.SaveData(Color: colors)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Player", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SummaryViewController") as! SummaryViewController
            nextViewController.name = name
            nextViewController.player = player
            nextViewController.flagColor = colors
            self.present(nextViewController, animated:true, completion:nil)
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Please select atleast one color", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true)

        }
    }
    
    //MARK:- SAVE DATA TO DB
    func SaveData(Color : String)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "History", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        
        //TO DO - ADD ALL VARIABLES
        newEntity.setValue(name, forKey: "name")
        newEntity.setValue(self.date_time, forKey: "date")
        newEntity.setValue(Color, forKey: "color")
        newEntity.setValue(player, forKey: "player")
        
        do {
            try context.save()
            print("saved")
        }
        catch
        {
            print("Not Saved")
        }
    }
    
    //MARK:- DELETE DATA FROM DB
    func DeleteDataFromDB()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do
        {
            let fetchRequestNSR = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
            let NSRArr = try context.fetch(fetchRequestNSR)
            if !NSRArr.isEmpty{
                for details in NSRArr {
                    context.delete(details as! NSManagedObject)
                }
            }
        }
        catch let error as NSError {
            debugPrint("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //MARK:- HISTORY ACTION
    @IBAction func HistoryAction(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Player", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
}

//MARK:- TABLE VIEW METHODS
extension FlagViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FlagTableViewCell
        cell!.Flaglabel.text = self.dataArray[indexPath.row]
        
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
        
        //MAKR:- MULTI SELECT
        //Warning are there since we are using static data here and values are not repeated
        if NewArrayIndex.contains(reasonValue)
        {
            if let index = NewArrayIndex.index(of: reasonValue)
            {
                NewArrayIndex.remove(at: index)
            }
            if let index1 = NewTickArrayIndex.index(of: rowCountValueInt)
            {
                NewTickArrayIndex.remove(at: index1)

            }
        }
        else{
            NewArrayIndex.append(reasonValue)
            NewTickArrayIndex.append(rowCountValueInt)
        }
        FlagTableView?.reloadData()
     }
}


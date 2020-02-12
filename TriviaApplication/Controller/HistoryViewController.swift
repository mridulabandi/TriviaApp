//
//  HistoryViewController.swift
//  Trivia App
//
//  Created by mysmac_admin on 12/02/20.
//  Copyright © 2020 Mridula. All rights reserved.
//

import UIKit
import CoreData

class HistoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var nameArr : [String] = []
    var PlayerArr : [String] = []
    var ColorArr : [String] = []
    var dateArr : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData()

        }
    
    func getData()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "History")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                self.nameArr.append(data.value(forKey: "name") as! String)
                self.PlayerArr.append(data.value(forKey: "player") as! String)
                self.ColorArr.append(data.value(forKey: "color") as! String)
                self.dateArr.append(data.value(forKey: "date") as! String )
            }
        }
        catch{
            print("Failed")
            //to do code if fetching data for db fails
        }
    }
    
}

//MARK:- TABLE VIEW METHODS
extension HistoryViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return nameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! HistoryTableViewCell
        
        if self.nameArr.count > 0
        {
            cell.nmae.text = self.nameArr[indexPath.row]
        }
        if self.ColorArr.count > 0
        {
            cell.color.text = self.ColorArr[indexPath.row]
        }
        if self.dateArr.count > 0
        {
            cell.Date.text = self.dateArr[indexPath.row]
        }
        if self.PlayerArr.count > 0
        {
            cell.player.text = self.PlayerArr[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 250
    }
    
    
    
}


//
//  GuestsViewController.swift
//  EasyEvents
//
//  Created by Ryan Thomas McIver on 11/15/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import UIKit

class GuestsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    var guestList = [Guest]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor( patternImage: UIImage( named: "MAD_EE_Background.png" )! )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return guestList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = guestList[indexPath[1]].name
        cell.detailTextLabel?.text = guestList[indexPath[1]].phone_num
        
        // Set cell color
        if guestList[indexPath[1]].confirmed == true {
            cell.contentView.backgroundColor = UIColor(red: 0.467, green: 0.950, blue: 0.282, alpha: 1.0)
            cell.backgroundColor = UIColor(red: 0.467, green: 0.950, blue: 0.282, alpha: 1.0)
        }
        else {
            cell.contentView.backgroundColor = UIColor.clear
            cell.backgroundColor = UIColor.clear
        }
        
        cell.textLabel?.textColor = UIColor.black
        // Prevent cell from turning gray when selected
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    // MARK: - Actions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        // Toggle background color between white and green.
        // Code for confirmation
        if guestList[indexPath[1]].confirmed == false {
            guestList[indexPath[1]].confirmed = true
            cell?.contentView.backgroundColor = UIColor(red: 0.467, green: 0.950, blue: 0.282, alpha: 1.0)
            cell?.backgroundColor = UIColor(red: 0.467, green: 0.950, blue: 0.282, alpha: 1.0)
        }
        // Toggle guest back to not confirmed
        else {
            guestList[indexPath[1]].confirmed = false
            cell?.contentView.backgroundColor = UIColor.clear
            cell?.backgroundColor = UIColor.clear
        }
        print(guestList[indexPath[1]].confirmed)
    }
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guestList.remove(at: indexPath[1])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBAction func addGuestButton(_ sender: AnyObject) {
        //Alert to add guest name and cell number
        let alertController = UIAlertController(title: "Add Contact", message: "Enter your contact's name and number.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        {
            result in
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![1] as UITextField
            if let nameText = firstTextField.text {
                if let numberText = secondTextField.text {
                    
                    if nameText != "" && numberText != "" {
                        
                        let newGuest: Guest = Guest.init(name: nameText)
                        newGuest.phone_num = numberText
                        newGuest.confirmed = false
                        self.guestList.append(newGuest)
                    
                        DispatchQueue.main.async{
                            self.table.reloadData()
                        }
                    }
                }
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Name"
        }
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Phone Number"
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}

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
    var dbUsername: String = ""
    var dbPassword: String = ""
    var event_id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor( patternImage: UIImage( named: "beach.jpg" )! )
        refresh( )
    }
    
    func refresh( ) {
        self.guestList.removeAll( )
        //grab stuff from the database
        let url = URL( string:"https://cs.okstate.edu/~asaph/guests.php?u=\(self.dbUsername)&p=\(self.dbPassword)&i=\(self.event_id)" )!
        let config = URLSessionConfiguration.default
        let session = URLSession( configuration: config )
        
        let task = session.dataTask( with: url, completionHandler: { (data, response, error) in
            guard error == nil else {
                print("Error in session call: \(error)")
                return
            }
            
            guard let result = data else {
                print( "No data\n" )
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject( with: result, options: .allowFragments ) as? [[String: AnyObject]]
                
                if json == nil {
                    return
                }
                
                for guest in json! {
                    //get id
                    guard let id = guest["id"] as? String else {
                        return
                    }
                    
                    //get name
                    guard let name = guest["name"] as? String else {
                        return
                    }
                    
                    //get number
                    guard let phone_number = guest["phone"] as? String else {
                        return
                    }
                    
                    //get rsvp
                    guard let rsvp = guest["rsvp"] as? String else {
                        return
                    }
                    
                    let _guest = Guest( name: name, phone: phone_number, confirmed: false, id: Int( id )! )
                    if rsvp == "1" {
                        _guest.confirmed = true
                    }
                    self.guestList.append( _guest )
                }
                
                DispatchQueue.main.async {
                    self.table.reloadData( )
                }
                
            } catch {
                print( "Error serializing JSON Data: \(error)" )
            }
        } )
        
        task.resume( )
        usleep( 900000 ) //seriously I can't fix this async bug
        //so this at least gives the db a chance to update

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
        cell.textLabel?.text = "Name: \(guestList[indexPath[1]].name)"
        cell.detailTextLabel?.text = "Phone: \(guestList[indexPath[1]].phone_num)"
        
        // Set cell color
        if guestList[indexPath[1]].confirmed == true {
            cell.contentView.backgroundColor = UIColor(red: 0.467, green: 0.950, blue: 0.282, alpha: 1.0)
            cell.backgroundColor = UIColor(red: 0.467, green: 0.950, blue: 0.282, alpha: 1.0)
        }
        else {
            cell.contentView.backgroundColor = UIColor.gray
            cell.backgroundColor = UIColor.gray
        }
        
        cell.textLabel?.textColor = UIColor.black
        cell.detailTextLabel?.textColor = UIColor.black
        cell.textLabel?.font = UIFont.init( name: "Zapfino", size: 20 )
        cell.detailTextLabel?.font = UIFont.init( name: "Zapfino", size: 16 )
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
            cell?.contentView.backgroundColor = UIColor.gray
            cell?.backgroundColor = UIColor.gray
        }
        
        let rsvp = guestList[indexPath[1]].confirmed ? 1 : 0
        let id = guestList[indexPath[1]].db_id
        let url = URL( string:"https://cs.okstate.edu/~asaph/update_guest.php?u=\(self.dbUsername)&p=\(self.dbPassword)&i=\(id)&r=\(rsvp)" )!
        let config = URLSessionConfiguration.default
        let session = URLSession( configuration: config )
        let task = session.dataTask( with: url, completionHandler: { (data, response, error) in
            guard error == nil else {
                print("Error in session call: \(error)")
                return
            }
            
            DispatchQueue.main.async {
                self.table.reloadData( )
            }
        } )
        
        task.resume( )
    }
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //delete from db first
            let id = guestList[indexPath[1]].db_id
            let url = URL( string:"https://cs.okstate.edu/~asaph/remove_guest.php?u=\(self.dbUsername)&p=\(self.dbPassword)&i=\(id)" )!
            let config = URLSessionConfiguration.default
            let session = URLSession( configuration: config )
            let task = session.dataTask( with: url, completionHandler: { (data, response, error) in
                guard error == nil else {
                    print("Error in session call: \(error)")
                    return
                }
                
                DispatchQueue.main.async {
                    self.table.reloadData( )
                }
            } )
            
            task.resume( )
            
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
            if var nameText = firstTextField.text {
                if var numberText = secondTextField.text {
                    
                    if nameText != "" && numberText != "" {
                        
                        //write stuff to the database
                        nameText = nameText.replacingOccurrences(of: " ", with: "_")
                        numberText = numberText.replacingOccurrences(of: " ", with: "_")
                        let url = URL( string:"https://cs.okstate.edu/~asaph/insert_guest.php?u=\(self.dbUsername)&p=\(self.dbPassword)&i=\(self.event_id)&g=\(nameText)&n=\(numberText)" )!
                        let config = URLSessionConfiguration.default
                        let session = URLSession( configuration: config )
                        let task = session.dataTask( with: url, completionHandler: { (data, response, error) in
                            guard error == nil else {
                                print("Error in session call: \(error)")
                                return
                            }
                            
                            self.refresh( )
                            
                            DispatchQueue.main.async{
                                self.table.reloadData()
                            }
                        } )
                        
                        task.resume( )
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
    
    
    /*// MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }*/

}

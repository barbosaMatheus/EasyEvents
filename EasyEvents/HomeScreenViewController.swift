//
//  HomeScreenViewController.swift
//  EasyEvents
//
//  Created by Ryan Thomas McIver on 10/25/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var eventList = [Event]()
    var selectedEvent: Event? = nil

    //db information
    var dbUsername: String = ""
    var dbPassword: String = ""
    var user_id: Int = 0 //id attribute for the current user in the database
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.setHidesBackButton(true, animated:true)
        self.view.backgroundColor = UIColor( patternImage: UIImage( named: "MAD_EE_Background.png" )! )
        
        
        //grab stuff from the database
        let url = URL( string:"https://cs.okstate.edu/~asaph/events.php?u=\(self.dbUsername)&p=\(self.dbPassword)&i=\(self.user_id)" )!
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
                
                //check if this user exists in the db
                for event in json! {
                    //get event title
                    guard let title = event["title"] as? String else {
                        return
                    }
                    
                    //get event date
                    guard let date = event["event_date"] as? String else {
                        return
                    }
                    
                    //get event type
                    guard let type = event["event_type"] as? String else {
                        return
                    }
                    
                    //get event completion percentage
                    
                    //create event object and append to list
                    let ev = Event( _title: title, _date: date, type: type )
                    self.eventList.append( ev )
                }
            } catch {
                print( "Error serializing JSON Data: \(error)" )
            }
        } )
        
        task.resume( )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView Display
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenCell", for: indexPath)
        
        cell.textLabel?.text = eventList[indexPath[1]].title
        cell.detailTextLabel?.text = eventList[indexPath[1]].date
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    // MARK: - Actions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        selectedEvent = eventList[indexPath[1]]
        performSegue(withIdentifier: "ChecklistSegue", sender: self)
    }
    
    
    
   


    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChecklistSegue" {
            let destinationVC = (segue.destination as! EventChecklistViewController)
            destinationVC.current_event = self.selectedEvent!
            destinationVC.dbPassword = self.dbPassword
            destinationVC.dbUsername = self.dbUsername
        }
        if segue.identifier == "AddEventSegue" {
            let destinationVC = (segue.destination as! AddEventViewController)
            destinationVC.currentEventList = self.eventList
        }
    }
    

}

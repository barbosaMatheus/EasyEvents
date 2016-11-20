//
//  HomeScreenViewController.swift
//  EasyEvents
//
//  Created by Ryan Thomas McIver on 10/25/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var homeScreenTable: UITableView!
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
        self.navigationItem.setHidesBackButton( true, animated:true )
        
        
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
                
                for event in json! {
                    if json == nil {
                        return
                    }
                    
                    //get event id
                    guard let id = event["id"] as? String else {
                        return
                    }
                    let _id = Int( id )
                    
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
                    guard let completion = event["completion"] as? String else {
                        return
                    }
                    let _completion = Double( completion )
                    
                    //create event object and append to list
                    let ev = Event( _id: _id!, _title: title, _date: date, type: type )
                    ev.completion = _completion!
                    self.eventList.append( ev )
                }
                
                DispatchQueue.main.async {
                    self.homeScreenTable.reloadData( )
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
        
        cell.textLabel?.text = "Title: \(eventList[indexPath[1]].title)  Type: \(eventList[indexPath[1]].type)"
        cell.detailTextLabel?.text = "\(eventList[indexPath[1]].date)  \(eventList[indexPath[1]].completion)% completed"
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.textColor = UIColor.black
        cell.textLabel?.font = UIFont.init( name: "Zapfino", size: 16 )
        cell.detailTextLabel?.font = UIFont.init( name: "Zapfino", size: 11 )
        
        return cell
    }
    
    // MARK: - Actions
    
    // Select row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        selectedEvent = eventList[indexPath[1]]
        performSegue(withIdentifier: "ChecklistSegue", sender: self)
    }
    
    // Delete row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            eventList.remove(at: indexPath[1])
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChecklistSegue" {
            let destinationVC = (segue.destination as! EventChecklistViewController)
            //destinationVC.current_event = self.selectedEvent!
            destinationVC.dbPassword = self.dbPassword
            destinationVC.dbUsername = self.dbUsername
            destinationVC.event_id = (self.selectedEvent?.data_base_id)!
            destinationVC.event = (self.selectedEvent?.title)!
            destinationVC.user_id = self.user_id
            destinationVC.completion_percentage = (self.selectedEvent?.completion)!
        }
        if segue.identifier == "AddEventSegue" {
            let destinationVC = (segue.destination as! AddEventViewController)
            //destinationVC.currentEventList = self.eventList
            destinationVC.dbPassword = self.dbPassword
            destinationVC.dbUsername = self.dbUsername
            destinationVC.user_id = self.user_id
        }
    }
    

}

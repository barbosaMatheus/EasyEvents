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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.view.backgroundColor = UIColor( patternImage: UIImage( named: "MAD_EE_Background.png" )! )
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
        }
        if segue.identifier == "AddEventSegue" {
            let destinationVC = (segue.destination as! AddEventViewController)
            destinationVC.currentEventList = self.eventList
        }
    }
    

}

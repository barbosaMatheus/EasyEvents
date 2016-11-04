//
//  HomeScreenViewController.swift
//  EasyEvents
//
//  Created by Ryan Thomas McIver on 10/25/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataToDisplay = ["EventOne", "EventTwo"]
    var dates = ["Oct 8, 2016", "Oct 25, 2016"]
    var selectedEvent = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor( patternImage: UIImage( named: "MAD_EE_Background.png" )! )
        // Do any additional setup after loading the view.
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
        return dataToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeScreenCell", for: indexPath)
        
        cell.textLabel?.text = dataToDisplay[indexPath[1]] // # of lap
        cell.detailTextLabel?.text = dates[indexPath[1]]
        return cell
    }
    
    // MARK: - Actions
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        selectedEvent = (cell?.textLabel?.text)!
        performSegue(withIdentifier: "ChecklistSegue", sender: self)
    }

    
    @IBAction func AddEventButtonPressed(_ sender: UIBarButtonItem) {
        print("Add Event Button Pressed")
    }


    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChecklistSegue" {
            let destinationVC = (segue.destination as! EventChecklistViewController)
            // Pass list of records to SecondTableViewController.swift
            destinationVC.event = self.selectedEvent
        }
    }
    

}

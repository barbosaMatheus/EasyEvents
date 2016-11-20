//
//  AddEventViewController.swift
//  EasyEvents
//
//  Created by Ryan Thomas McIver on 11/8/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var eventPicker: UIPickerView!
    let pickerData = ["Weddings", "Birthdays", "Business"]
    var selectedEvent: String = "Weddings"
    var newEvent = Event.init( _id: 0, _title: "", _date: "", type: "" )
    
    //db information
    var dbUsername: String = ""
    var dbPassword: String = ""
    var user_id: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        eventPicker.dataSource = self
        eventPicker.delegate = self
        datePicker.datePickerMode = UIDatePickerMode.date
        
        //background
        self.view.backgroundColor = UIColor( patternImage: UIImage( named: "MAD_EE_Background.png" )! )
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector( self.close_kb ) )
        view.addGestureRecognizer( tap )
        
    }

    func close_kb( ) {
        view.endEditing( true )
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddSegue" {
            // Configure Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let selectedDate = dateFormatter.string(from: datePicker.date)
            
            newEvent = Event.init( _id: 0, _title: titleTextField.text!, _date: selectedDate, type: selectedEvent )

            update_event_table( )
            
            guard let vc = segue.destination as? HomeScreenViewController else {
                return
            }
            vc.user_id = self.user_id
            vc.dbUsername = self.dbUsername
            vc.dbPassword = self.dbPassword
        }
        /*if segue.identifier == "CancelSegue" {
            let destinationVC = (segue.destination as! HomeScreenViewController)
            //destinationVC.eventList = self.currentEventList
        }*/
    }
 
    func update_event_table( ) {
        //get info
        let title = newEvent.title
        let type = newEvent.type
        let selectedDate = newEvent.date
        
        //write to the db
        let url = URL( string:"https://cs.okstate.edu/~asaph/event_insert.php?u=\(self.dbUsername)&p=\(self.dbPassword)&i=\(self.user_id)&t=\(title)&d=\(selectedDate)&y=\(type)" )!
        let config = URLSessionConfiguration.default
        let session = URLSession( configuration: config )
        
        let task = session.dataTask( with: url, completionHandler: { (data, response, error) in
            guard error == nil else {
                print("Error in session call: \(error)")
                return
            }
            
            /*guard data != nil else {
                print( "No data\n" )
                return
            }*/
   
            /*DispatchQueue.main.async {
                self.update_steps_table( type: type )
            }*/
        } )
        
        task.resume( )
    }
    
    func update_steps_table( type: String ) {
        
    }
    
    // MARK: - Picker data sources
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerData.count
    }
    
    //MARK: Delegates
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedEvent = pickerData[row]
    }

}

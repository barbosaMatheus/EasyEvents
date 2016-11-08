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
    var currentEventList = [Event]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true)
        eventPicker.dataSource = self
        eventPicker.delegate = self
        datePicker.datePickerMode = UIDatePickerMode.date
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddSegue" {
            let destinationVC = (segue.destination as! HomeScreenViewController)
            
            // Configure Date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let selectedDate = dateFormatter.string(from: datePicker.date)
            
            let newEvent = Event.init(_title: titleTextField.text!, _date: selectedDate, type: selectedEvent)
            currentEventList.append(newEvent)
            
            destinationVC.eventList = currentEventList
        }
        if segue.identifier == "CancelSegue" {
            let destinationVC = (segue.destination as! HomeScreenViewController)
            destinationVC.eventList = self.currentEventList
        }
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

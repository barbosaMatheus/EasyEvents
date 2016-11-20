//
//  Event.swift
//  EasyEvents
//
//  Created by Asaph Matheus Moraes Barbosa on 11/1/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import Foundation
import UIKit

class Event {
    var title: String //name of event
    var date: String //date of event dd/mm/yy
    var completion: Double //completion percentage of event
    var guest_list: [Guest] //guest list
    var step_indexes: [Int] //indexes of steps associated with this event
    var steps:[(pic:UIImage,name:String,done:Bool)] //info about the steps for this event
    var data_base_id: Int
    var type: String
    
    init( _id: Int, _title: String, _date: String, type: String ) {
        title = _title
        date = _date
        completion = 0.0
        guest_list = []
        steps = []
        self.type = type
        data_base_id = _id
        
        if type == "Wedding" {
            step_indexes = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
        }
        else if type == "Birthday" {
            step_indexes = [0,14,5,6,12,1,8,3,2,13]
        }
        else if type == "Baby" {
            step_indexes = [0,14,5,6,11,12,1,8,2,13]
        }
        else if type == "Business" {
            step_indexes = [0,14,5,6,1,8,2,13]
        }
        else if type == "Custom" {
            step_indexes = [0,14,5,6,12,8,2,13]
        }
        else {
            step_indexes = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
        }
    }
}

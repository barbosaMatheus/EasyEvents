//
//  Guest.swift
//  EasyEvents
//
//  Created by Asaph Matheus Moraes Barbosa on 11/1/16.
//  Copyright © 2016 Oklahoma State University. All rights reserved.
//

import Foundation

class Guest {
    
    var name: String //name of guest
    var phone_num: String //guest's phone number 
    var confirmed: Bool //indicates whether the guest is coming or not
                        //this is false for guests who are yet to respond
    var db_id: Int //database id
    
    init( name: String ) {
        self.name = name
        self.phone_num = ""
        self.confirmed = false
        self.db_id = 0
    }
    
    init( name: String, phone: String, confirmed: Bool, id: Int ) {
        self.name = name
        self.phone_num = phone
        self.confirmed = confirmed
        self.db_id = id
    }
}

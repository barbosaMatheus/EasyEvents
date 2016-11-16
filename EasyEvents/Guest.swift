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
    var phone_num: String //guest's phone number (123)456-7890
    var confirmed: Bool //indicates whether the guest is coming or not
                        //this is false for guests who are yet to respond
    
    init( name: String ) {
        self.name = name
        self.phone_num = ""
        self.confirmed = false
    }
    
    init( name: String, confirmed: Bool ) {
        self.name = name
        self.phone_num = ""
        self.confirmed = confirmed
    }
}

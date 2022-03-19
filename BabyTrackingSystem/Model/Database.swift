//
//  Database.swift
//  Retroo
//
//  Created by Giridhar Addagalla on 17/11/2021.
//

import Foundation
import Firebase

class DatabaseServices {
    
    static let shared = DatabaseServices()
    private init() {}
    
    let Refference = Database.database().reference()
    
}

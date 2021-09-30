//
//  Session.swift
//  VK
//
//  Created by Михаил Чертов on 16.09.2021.
//

import Foundation


class Session {
    
    static let shared = Session()
       
    private init() { }
    var token: String = ""
    var userId: Int = 0
   
}

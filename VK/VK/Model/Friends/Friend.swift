//
//  Friend.swift
//  VK
//
//  Created by Михаил Чертов on 11.08.2021.
//

import Foundation


struct User {
    var userName: String
    var userSurname: String 
    var userAvatar: String
    var userPhoto: [String]
    var wholeName: String { "\(self.userName) \(self.userSurname)" }

}

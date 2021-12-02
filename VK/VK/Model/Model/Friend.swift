//
//  Friend.swift
//  VK
//
//  Created by Михаил Чертов on 11.08.2021.
//

import Foundation
import RealmSwift

final class User: Object, Decodable {
    
    @objc dynamic var id: Int
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String
    @objc dynamic var avatar: String
   

    
    
    var fullName: String {
        return lastName + " " + firstName
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id 
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar = "photo_50"
    }
}

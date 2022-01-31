//
//  Group.swift
//  VK
//
//  Created by Михаил Чертов on 22.09.2021.
//

import Foundation
import RealmSwift

final class GroupItems: Object, Decodable {
    
    @objc dynamic var id: Int
    @objc dynamic var name: String
    @objc dynamic var avatar: String 
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case avatar = "photo_50"
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

//
//  Repository.swift
//  VK
//
//  Created by Михаил Чертов on 22.09.2021.
//

import Foundation
import RealmSwift

class Repository {
    
    private let realm = try! Realm()
    
    func fetchFriends() -> [User] {
        return Array(realm.objects(User.self))
    }
    
    func fetchGroups() -> [GroupItems] {
        return Array(realm.objects(GroupItems.self))
    }
    
    func fetchPhotos(ownerId: Int) -> [Photo] {
        return Array(realm.objects(Photo.self).filter("ownerId == %@", ownerId))
    }
}

//
//  VKApi.swift
//  VK
//
//  Created by Михаил Чертов on 19.09.2021.
//

import Foundation
import RealmSwift

final class VKApi {
    
    let session = Session.shared
    
    enum ApiMethod {
        case friends
        case groups
        case searchGroups(searchText: String)
        case photos(id: Int)
        case news
        
        var path: String {
            switch self {
            case .friends:
                return "/method/friends.get"
            case .groups:
                return "/method/groups.get"
            case .photos:
                return "/method/photos.getAll"
            case .searchGroups:
                return "/method/groups.search"
            case .news:
                return "/method/newsfeed.get"
        }
    }
        
        var parameters: [String: String] {
            switch self {
            case .friends:
                return ["fields": "photo_50"]
            case .groups:
                return ["count": "10",
                        "extended": "1"]
            case .photos(let id):
                return ["owner_id": String(id)]
            case .searchGroups(let searchText):
                return ["q": searchText]
            case .news:
                return ["count": "5"]
            }
        }
    }
    
    // MARK: - Request
    
    private func request(_ method: ApiMethod, complition: @escaping (Data?) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.com"
        components.path = method.path
        let defaultQueryItems = [
            URLQueryItem(name: "access_token", value: session.token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        let methodQueryItems = method.parameters.map {
            URLQueryItem(name: $0, value: $1)
        }
        components.queryItems = defaultQueryItems + methodQueryItems
        
        guard let url = components.url else {
            complition(nil)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) {(data, response, error) in
            if let error = error {
                print(error)
            }
            DispatchQueue.main.async {
                complition(data)
            }
        }
        task.resume()
    }
    
    // MARK: - Friends
    
    func getFriends(complition: @escaping () -> Void) {
        request(.friends) {[weak self] (data) in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(VKResponse<User>.self, from: data)
                self?.saveToRealm(response.items)
                complition()
            } catch {
                print(error)
            }
        }
    }
    
    func getFriendsPhoto(ownerId: Int, complition: @escaping() -> Void) {
        request(.photos(id: ownerId)) { [weak self] (data) in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(VKResponse<Photo>.self, from: data)
                self?.saveToRealm(response.items)
                complition()
            } catch {
                print(error)
            }
        }
    }
    
    // MARK: - Groups

    func getGroups(complition: @escaping () -> Void) {
        request(.groups) { [weak self] (data) in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(VKResponse<GroupItems>.self, from: data)
                self?.saveToRealm(response.items)
                complition()
            } catch {
                print(error)
            }
        }
    }
    
    func searchGetGroups(searchText: String, complition: @escaping ([GroupItems]) -> Void) {
        request(.searchGroups(searchText: searchText)) { (data) in
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(VKResponse<GroupItems>.self, from: data)
                complition(response.items)
            } catch {
                print(error)
            }
        }
    }
    
    func getNews() {
        request(.news) { (data) in
            guard let data = data  else {
                return
            }
            let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        }
    }
    // MARK: - Realm
    
    private func saveToRealm<T: Object>(_ object: [T]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            print(error)
        }
    }
    
    

}

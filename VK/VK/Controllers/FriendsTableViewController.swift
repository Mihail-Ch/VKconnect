//
//  FriendsTableViewController.swift
//  VK
//
//  Created by Михаил Чертов on 11.08.2021.
//

import UIKit


struct Section<T> {
    var letter: String
    let names: [T]
    
}

class FriendsTableViewController: UITableViewController {
    
    private let cellTypeNib = UINib(nibName: "TableViewCell", bundle: nil)
    var sections = [Section<User>]()
    lazy var vkApi = VKApi()
    var friends = [User]()
    lazy var repository = Repository()
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFromCache()
        
        vkApi.getFriends {
            [weak self] in
            self?.loadFromCache()
        }
        
        makeSortedSection()
        tableView.register(cellTypeNib, forCellReuseIdentifier: "TableViewCell")
    }
    
    // Realm
    
    private func loadFromCache() {
        friends = repository.fetchFriends()
        makeSortedSection()
        tableView?.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return sections[section].names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let friend = sections[indexPath.section].names[indexPath.row]
        let url = URL(string: friend.avatar)
        cell.configure(name: friend.fullName, avatar: url)
        
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.8,
                       options: .curveEaseInOut) {
            cell.frame.origin.x += 70
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.8) {
            cell.alpha = 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].letter
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.map { $0.letter }
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        
        }    
    }
    
    //MARK: - Method
    
    private func makeSortedSection() {
        let friendsDictionary = Dictionary.init(grouping: friends) { $0.lastName.prefix(1) }
        sections = friendsDictionary.map { Section(letter: String($0.key), names: $0.value) }
        sections.sort { $0.letter < $1.letter }
    }

    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toPhotoScreen", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "toPhotoScreen":
            preparePhotoScreen(segue)
        default:
            break
        }
    }
    private func preparePhotoScreen(_ segue: UIStoryboardSegue)  {
        guard let photoController = segue.destination as? PhotoCollectionViewController,
              let indexPath = tableView.indexPathForSelectedRow else { return }
        let items = sections[indexPath.section].names
        photoController.title = items[indexPath.row].fullName
        photoController.friendId = items[indexPath.row].id

    }


}

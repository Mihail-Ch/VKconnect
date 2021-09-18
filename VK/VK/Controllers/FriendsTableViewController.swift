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
    
    var friends = [
        User(userName: "Anto", userSurname: "Blinkin", userAvatar: " ", userPhoto: ["sun", "sun", "sun"]),
        User(userName: "Vity", userSurname: "Serhio", userAvatar: "logo", userPhoto: ["logo", "logo", "logo", "logo", "logo"]),
        User(userName: "LAkki", userSurname: "Petrov", userAvatar: "sun", userPhoto: ["sun", "sun", "sun"]),
        User(userName: "Anto", userSurname: "Blinkin", userAvatar: "sun", userPhoto: ["sun", "sun", "sun"]),
        User(userName: "Vity", userSurname: "Serhio", userAvatar: "logo", userPhoto: ["logo", "logo", "logo", "logo", "logo"]),
        User(userName: "LAkki", userSurname: "Petrov", userAvatar: "sun", userPhoto: ["sun", "sun", "sun"])
    ]
       
    override func viewDidLoad() {
        super.viewDidLoad()
        makeSortedSection()
        tableView.register(cellTypeNib, forCellReuseIdentifier: "TableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section].names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let friend = sections[indexPath.section].names[indexPath.row]
        cell.name.text = friend.wholeName
        cell.photo.image = UIImage(named: friend.userAvatar)
        
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

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    //MARK: - Method
    
    private func makeSortedSection() {
        let friendsDictionary = Dictionary.init(grouping: friends) { $0.userSurname.prefix(1) }
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
        let items = friends[indexPath.row]
        photoController.title = items.wholeName
        photoController.userPhoto = items.userPhoto
        photoController.user = items.wholeName
        
    }


}

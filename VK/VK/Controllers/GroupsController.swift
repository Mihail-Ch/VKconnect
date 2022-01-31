//
//  GroupsController.swift
//  VK
//
//  Created by Михаил Чертов on 10.08.2021.
//

import UIKit

class GroupsController: UITableViewController {
    
    private let cellTypeNib = UINib(nibName: "TableViewCell", bundle: nil)
    var sections = [Section<GroupItems>]()
    var groups = [GroupItems]()
    lazy var vkApi = VKApi()
    
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(cellTypeNib, forCellReuseIdentifier: "TableViewCell")
        makeSortedSection()
    }
    
    
    // MARK: - Table view data source

       override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section].letter.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let group = sections[indexPath.section].names[indexPath.row]
        let url = URL(string: group.avatar)
        cell.configure(name: group.name, avatar: url)
        return cell
    }
    
    //MARK: - Method
    
    func makeSortedSection() {
        let groupsDictionary = Dictionary.init(grouping: groups) {
           $0.name.prefix(1)}
        sections = groupsDictionary.map { Section(letter: String($0.key), names: $0.value) }
        sections.sort { $0.letter < $1.letter }
    }
    
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    //Для передачи данных в MyGroupController
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "addGroup", sender: nil)
    }
}

extension GroupsController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let groupsDictionary = Dictionary.init(grouping: groups.filter { (group) -> Bool in return searchText.isEmpty ? true : group.name.lowercased().contains(searchText.lowercased())
        }) {$0.name.prefix(1)}
        sections = groupsDictionary.map { Section(letter: String($0.key), names: $0.value) }
        sections.sort { $0.letter < $1.letter }
        tableView.reloadData()
        print("Search \(searchText)")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        print("Search button clicked")
    }
    
}

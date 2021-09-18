//
//  MyGroupsController.swift
//  VK
//
//  Created by Михаил Чертов on 10.08.2021.
//

import UIKit

class MyGroupsController: UITableViewController {
    
    private let cellTypeNib = UINib(nibName: "TableViewCell", bundle: nil)
    var myGroups = [Group]()


    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.register(cellTypeNib, forCellReuseIdentifier: "TableViewCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        let group = myGroups[indexPath.row]
        cell.configure(name: group.groupName, avatar: group.groupAvatar)
       /* cell.name.text = group.groupName
        cell.photo.image = UIImage(named: group.groupAvatar) */
    
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: - Action
    
    @IBAction func addGroup(_ segue: UIStoryboardSegue)  {
        guard let controller = segue.source as? GroupsController,
              let indexPath = controller.tableView.indexPathForSelectedRow else { return }
        let groupForMe = controller.groups[indexPath.row]
        if !myGroups.contains(groupForMe) {
            myGroups.append(groupForMe)
            tableView.reloadData()
        }
        
    }

}

//
//  NewsTableViewController.swift
//  VK
//
//  Created by Михаил Чертов on 17.08.2021.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    private let cellTypeNib = UINib(nibName: "NewsViewCell", bundle: nil)
    var news = [
        News(avatarNews: "sun", nameNews: "Sun Sunny", descriptionNews: "Sun up!!!! kvjavnhnvlknvlknvlknvklnfvlkmnfvlkdmflkdklfbmlkbmkldmbklmdbklndbnblksndblknblkdnsblksdnblkdsnfblkfbnl", photoNews: "sun"),
        News(avatarNews: "logo", nameNews: "loGo", descriptionNews: "VK bought boat!!! SpaceXXXXX   kmvavbavjknbjklvhbaglahgaksjgklanhvbkla'blkanfbkldfbn", photoNews: "logo"),
        News(avatarNews: "like", nameNews: "lekkki", descriptionNews: "LOve Lokkis! Njsdgjkbjksbvkjabvjkbvjkbvajkgbakbdn 645643154", photoNews: "like")
    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(cellTypeNib, forCellReuseIdentifier: "NewsCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsViewCell
        let news = news[indexPath.row]
        
        cell.avatar.image = UIImage(named: news.avatarNews)
        cell.name.text = news.nameNews
        cell.descritioin.text = news.descriptionNews
        cell.newsPhoto.image = UIImage(named: news.photoNews)


        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

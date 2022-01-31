//
//  NewsTableViewController.swift
//  VK
//
//  Created by Михаил Чертов on 17.08.2021.
//

import UIKit

enum PostCellType: Int, CaseIterable {
    case author = 0
    case text
    case photo
    case likeCount
}


class NewsTableViewController: UITableViewController {
    
    let vkApi = VKApi()
    let session = Session.shared
    let news = [News(imageNews: "ng", nameNews: "National Giografic", timeNews: "21:44", description: "Вид хищных млекопитающих семейства кошачьих, один из пяти представителей рода пантера, который относится к подсемейству больших кошек. Слово «тигр» происходит от τίγρις, которое в свою очередь восходит к *tigri от корня «*taig» со значением «острый; быстрый", photoNews: "tiger"),
                News(imageNews: "apple", nameNews: "Apple", timeNews: "07:15", description: "Мы создали самый мощный MacBook Pro в истории. И это монстр. Супербыстрые M1 Pro и M1 Max — первые чипы Apple, разработанные специально для профессионалов. Они дают феноменальную производительность и обеспечивают удивительно долгое время работы без подзарядки. Прибавьте к этому потрясающий дисплей Liquid Retina XDR, превосходную камеру и звук, а также больше портов для профессиональной работы. С этим ноутбуком всё становится возможным.", photoNews: "mac"),
                News(imageNews: "tiger", nameNews: "tiger", timeNews: "20:11", description: "hgsvdjksngklj", photoNews: nil),
                News(imageNews: "apple", nameNews: "Apple", timeNews: "07:15", description: nil, photoNews: "mac")

    ]
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setCell()
        
        vkApi.getNews()
        
       
        
    }
    
    //MARK: - Method
    
    private func setCell() {
        tableView.register(AvatarCell.nib, forCellReuseIdentifier: AvatarCell.reuseId)
        tableView.register(NewsDescriptionCell.nib, forCellReuseIdentifier: NewsDescriptionCell.reuseId)
        tableView.register(ImageCell.nib, forCellReuseIdentifier: ImageCell.reuseId)
        tableView.register(ControlCell.nib, forCellReuseIdentifier: ControlCell.reuseId)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return news.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PostCellType.allCases.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = news[indexPath.section]
        let postCellType = PostCellType(rawValue: indexPath.row)
        switch postCellType {
        case .author:
            let cell = tableView.dequeueReusableCell(withIdentifier: AvatarCell.reuseId, for: indexPath) as! AvatarCell
            cell.configure(image: item.imageNews, name: item.nameNews, time: item.timeNews)
            return cell
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsDescriptionCell.reuseId, for: indexPath) as! NewsDescriptionCell
            if let descriptionNews = item.description {
                cell.configure(description: descriptionNews)
            } else {
               break
            }
            return cell
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.reuseId, for: indexPath) as! ImageCell
            if let photo = item.photoNews {
                cell.configure(photo: photo)
            } else {
                break
                //MARK: - TO DO если ячейка пустая она не должна отоброжаться
                
            }
            return cell
        case .likeCount:
            let cell = tableView.dequeueReusableCell(withIdentifier: ControlCell.reuseId, for: indexPath) as! ControlCell
            cell.like
            return cell
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        
        if indexPath.isEmpty {
            return 0
        }
        return UITableView.automaticDimension
    }
         
//    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return UITableView.automaticDimension
//        }
//        return 0
//    }
    
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

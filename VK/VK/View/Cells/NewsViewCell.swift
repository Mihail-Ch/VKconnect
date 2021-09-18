//
//  NewsViewCell.swift
//  VK
//
//  Created by Михаил Чертов on 17.08.2021.
//

import UIKit

class NewsViewCell: UITableViewCell {
    
    @IBOutlet weak var viewAvatar: Shadow!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descritioin: UILabel!
    @IBOutlet weak var newsPhoto: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        viewAvatar.layer.cornerRadius = viewAvatar.frame.height / 2
        avatar.layer.cornerRadius = avatar.frame.height / 2
        

    }
    
}

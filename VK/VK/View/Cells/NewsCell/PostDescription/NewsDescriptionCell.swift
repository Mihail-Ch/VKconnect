//
//  NewsDescriptionCell.swift
//  VK
//
//  Created by Михаил Чертов on 26.09.2021.
//

import UIKit

class NewsDescriptionCell: UITableViewCell {
    
    static let nib = UINib(nibName: "NewsDescriptionCell", bundle: nil)
    static let reuseId = "DescriptionNewsKey"

    @IBOutlet weak var descriptionNews: UILabel!
    
    
    //DescriptionNewsKey
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(description: String) {
        self.descriptionNews.text = description
    }
    
    
}

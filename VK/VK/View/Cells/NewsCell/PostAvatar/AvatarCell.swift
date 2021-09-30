//
//  AvatarCell.swift
//  VK
//
//  Created by Михаил Чертов on 29.09.2021.
//

import UIKit

class AvatarCell: UITableViewCell {
    
    static let nib = UINib(nibName: "AvatarCell", bundle: nil)
    static let reuseId = "AvatarCellKey"//AvatarCellKey
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(image: String, name: String, time: String) {
        self.avatar.image = UIImage(named: image)
        self.label.text = name
        self.time.text = time
    }
    
}

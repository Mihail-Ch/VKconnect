//
//  ImageCell.swift
//  VK
//
//  Created by Михаил Чертов on 29.09.2021.
//

import UIKit

class ImageCell: UITableViewCell {

    static let nib = UINib(nibName: "ImageCell", bundle: nil)
    static let reuseId = "ImageCellKey"
    
    @IBOutlet weak var imagePost: UIImageView!
    
    //ImageCellKey
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(photo: String) {
        self.imagePost.image = UIImage(named: photo)
    }
    
}

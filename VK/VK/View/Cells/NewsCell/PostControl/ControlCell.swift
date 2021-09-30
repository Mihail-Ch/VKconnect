//
//  ControlCell.swift
//  VK
//
//  Created by Михаил Чертов on 29.09.2021.
//

import UIKit

class ControlCell: UITableViewCell {
    
    static let nib = UINib(nibName: "ControlCell", bundle: nil)
    static let reuseId = "ControlCellKey"
    //ControlCellKey

    
    @IBOutlet weak var like: LikeControl! {
        didSet {
            self.layer.cornerRadius = 7
            self.backgroundColor = .lightGray
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

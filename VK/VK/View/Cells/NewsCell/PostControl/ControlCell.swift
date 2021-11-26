//
//  ControlCell.swift
//  VK
//
//  Created by Михаил Чертов on 29.09.2021.
//

import UIKit

class ControlCell: UITableViewCell {
    
    
    @IBOutlet weak var like: UIView!
    
    static let nib = UINib(nibName: "ControlCell", bundle: nil)
    static let reuseId = "ControlCellKey"
    //ControlCellKey

    
   
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       

        
    }
    
}

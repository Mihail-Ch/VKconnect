//
//  TableViewCell.swift
//  VK
//
//  Created by Михаил Чертов on 10.08.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatarView: UIView! {
        didSet {
            self.avatarView.addGestureRecognizer(tapGestureRecognized)
        }
    }
    @IBOutlet weak var photo: UIImageView!
    
    lazy var tapGestureRecognized: UITapGestureRecognizer = {
        let recognized = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        recognized.numberOfTapsRequired = 1
        recognized.numberOfTouchesRequired = 1
        return recognized
    }()
    
    @objc func tapGesture() {
        animateViewAvatar()
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupRoundView()
    }

    func configure(name: String, avatar: String) {
        self.name.text = name
        self.photo.image = UIImage(named: avatar)
    }
    
    //MARK: - Animation and Layer
    
    private func setupRoundView() {
        avatarView.layer.cornerRadius = avatarView.frame.height / 2
        photo.layer.cornerRadius = photo.frame.height / 2
    }
    
    private func animateViewAvatar() {
        let animate = CASpringAnimation(keyPath: "transform.scale")
        animate.fromValue = 0.5
        animate.toValue = 1.0
        animate.stiffness = 100
        animate.mass = 1
        animate.duration = 1
        animate.fillMode = CAMediaTimingFillMode.both
        self.avatarView.layer.add(animate, forKey: nil)
    }
    
  
}



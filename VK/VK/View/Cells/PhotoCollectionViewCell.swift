//
//  PhotoCollectionViewCell.swift
//  VK
//
//  Created by Михаил Чертов on 11.08.2021.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var photoCell: UIImageView!
    @IBOutlet weak var containerView: UIView! {
        didSet {
            animateView()
        }
    }
    
    private func animateView() {
        UIView.transition(with: containerView,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: nil)
    }
    
    
    func configure(with photoUrl: URL?) {
        self.photoCell.kf.setImage(with: photoUrl)
    }
}

//
//  LikeControl.swift
//  VK
//
//  Created by Михаил Чертов on 13.08.2021.
//

import UIKit

class LikeControl: UIControl {
    
    private let stackView = UIStackView()
    private let likeLabel = UILabel()
    private let button = UIButton()
    private var likeCount = 12245
    private var buttonIsSelected = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        button.setImage(UIImage(named: "like"), for: .normal)
        button.addTarget(self, action: #selector(customButtonAction(_:)), for: .touchUpInside)
        button.contentMode = .scaleToFill
        likeLabel.text = "\(likeCount)"
        likeLabel.textColor = .black
        
        stackView.addArrangedSubview(button)
        stackView.addArrangedSubview(likeLabel)
        stackView.spacing = 3
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        self.addSubview(stackView)
    }
    
    @objc func customButtonAction(_ sender: UIButton) {
        if buttonIsSelected == false {
            button.setImage(UIImage(named: "disLike"), for: .normal)
            likeCount += 1
            likeLabel.text = "\(likeCount)"
            buttonIsSelected = true
            animateLike()
        } else {
            button.setImage(UIImage(named: "like"), for: .normal)
            likeCount -= 1
            likeLabel.text = "\(likeCount)"
            buttonIsSelected = false
            animateDisLike()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    private func animateLike() {
        UIView.transition(with: button,
                          duration: 0.25,
                          options: .transitionFlipFromLeft,
                          animations: nil)
    }
    
    private func animateDisLike(){
        UIView.transition(with: button,
                          duration: 0.25,
                          options: .transitionFlipFromRight,
                          animations: nil)
    }
}

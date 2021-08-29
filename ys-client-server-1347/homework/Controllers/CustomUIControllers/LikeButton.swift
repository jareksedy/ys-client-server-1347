//
//  LikeButton.swift
//  ys-client-server-1347
//
//  Created by Ярослав on 29.08.2021.
//

import Foundation
import UIKit

class LikeButton: UIButton {
    
    var likesCount = 0
    var isLikedByMe = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 15, height: 25)
    }
    
    private func configure() {
        
        self.contentHorizontalAlignment = .leading
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        self.setTitleColor(isLikedByMe ?  UIColor.systemPink : UIColor.secondaryLabel, for: .normal)
        self.setTitle("\(isLikedByMe ? "♥" : "♡") \(likesCount.formatted)", for: .normal)
        
        addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
    }
    
    @objc func onTap(_ sender: UIButton) {
        isLikedByMe.toggle()
        likesCount += isLikedByMe ? 1 : -1
    }
}

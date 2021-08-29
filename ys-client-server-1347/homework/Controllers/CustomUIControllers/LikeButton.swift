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
        addActions()
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 15, height: 25)
    }
    
    func configure(likesCount: Int, isLikedByMe: Bool) {
        
        self.likesCount = likesCount
        self.isLikedByMe = isLikedByMe
        
        self.contentHorizontalAlignment = .leading
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
        
        setTitleDependingOnState()

    }
    
    private func addActions() {
        
        addTarget(self, action: #selector(onTap(_:)), for: .touchUpInside)
    }
    
    private func setTitleDependingOnState() {
        
        self.setTitleColor(isLikedByMe ?  UIColor.systemPink : UIColor.secondaryLabel, for: .normal)
        self.setTitle("\(isLikedByMe ? "♥" : "♡") \(likesCount.formatted)", for: .normal)
    }
    
    @objc func onTap(_ sender: UIButton) {
        
        isLikedByMe.toggle()
        likesCount += isLikedByMe ? 1 : -1
        
        self.setTitleDependingOnState()
    }
}

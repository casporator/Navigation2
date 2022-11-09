//
//  CustomButton.swift
//  Navigation
//
//  Created by Oleg Popov on 25.10.2022.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    
    var buttonAction: () -> Void = {} // замыкане в которое буду передавать действие
    
    @objc private func buttonTapped(){
        buttonAction()
    }
    
    init(title: String,
         titleColor: UIColor = .white,
         backgroundColor: UIColor = .systemBlue,
         cornerRadius: CGFloat = 14,
         maskToBounds: Bool = true) {
        
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.setTitleColor(UIColor.black, for: .highlighted)
        self.titleLabel?.font = UIFont(name: "Hannotate SC Bold", size: 30)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = maskToBounds
        self.toAutoLayout()
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}






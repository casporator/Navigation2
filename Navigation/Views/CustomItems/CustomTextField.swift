//
//  CustomTextField.swift
//  Navigation
//
//  Created by Oleg Popov on 25.10.2022.
//

import Foundation
import UIKit

final class CustomTextField: UITextField {
    
    var textFieldAction: () -> Void = {}
    
    @objc private func statusTextChanged(){
        textFieldAction()
    }
    
    init(placeholder: String,
         textAlignment: NSTextAlignment = .center,
         backgroundColor: UIColor = .white,
         cornerRadius: CGFloat = 12,
         borderWidth: CGFloat = 1,
         borderColor: UIColor = .black,
         maskToBounds: Bool = true) {
        
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.font = UIFont(name: "regular", size: 15.0)
        self.textAlignment = textAlignment
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.masksToBounds = maskToBounds
        self.toAutoLayout()
        addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



   
  

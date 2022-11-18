//
//  PlayerCustomButton.swift
//  Navigation
//
//  Created by Oleg Popov on 17.11.2022.
//

import Foundation
import UIKit

class PlayerButton: UIButton {
        
    var buttonAction: () -> Void = {} 
    @objc private func buttonTapped(){
        buttonAction()
    }
    
    init(image: String) {
    
        super.init(frame: .zero)
        
        let image = UIImage(systemName: image)
        self.setImage(image, for: .normal)
        self.tintColor = .white
       // self.backgroundColor = .white
        //self.layer.borderColor = UIColor.black.cgColor
       // self.layer.borderWidth = 1
       // self.layer.cornerRadius = 6
        self.clipsToBounds = true
        self.toAutoLayout()
        
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

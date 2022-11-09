//
//  File.swift
//  Navigation
//
//  Created by Oleg Popov on 11.09.2022.
//

import Foundation
import UIKit

class PhotosCollectionViewCell : UICollectionViewCell {

    private lazy var photoImage : UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.layer.borderWidth = 1.5
        image.layer.cornerRadius = 5
        image.layer.borderColor = UIColor(hexString: "#00000").cgColor
        image.toAutoLayout()
        
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
       
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(photoImage)

        NSLayoutConstraint.activate([
            photoImage.topAnchor.constraint(equalTo: topAnchor),
            photoImage.leftAnchor.constraint(equalTo: leftAnchor),
            photoImage.rightAnchor.constraint(equalTo: rightAnchor),
            photoImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
   func setup(name: String) {
        photoImage.image = UIImage(named: name)
    }
  
   
    func setupImagePublisher(image: UIImage){
        photoImage.image = image
    }
}




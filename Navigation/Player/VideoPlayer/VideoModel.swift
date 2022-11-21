//
//  VideoModel.swift
//  Navigation
//
//  Created by Oleg Popov on 21.11.2022.
//

import Foundation
import UIKit


struct Video {
    var image: UIImage
    var title: String
    var id: String
}

struct VideoModel{
    
    static let playlist = [
        Video(image: UIImage(named: "sydak2") ?? UIImage(),
              title: "Трудовая рыбалка - Зимний ленивый судак.",
              id: "Ql6Bgl_D7HQ"),
       
    ]
}


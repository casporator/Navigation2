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
    var fileName: String
}

struct VideoModel{
    
    static let videoList = [
        Video(image: UIImage(named: "alluxAva") ?? UIImage(), title: "Allux Ruthenium Match Evo", fileName: "allux")
       
    ]
}



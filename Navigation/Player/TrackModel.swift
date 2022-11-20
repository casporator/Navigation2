//
//  Tracks.swift
//  Navigation
//
//  Created by Oleg Popov on 17.11.2022.
//

import Foundation
import UIKit

struct Track {
    var artistName: String
    var trackName: String
    var image: UIImage
    var fileName: String
   
}

struct TrackModel {
    
    static var tracks: [Track] = [
    
        Track(artistName: "Led Zeppelin", trackName: "Immigrant Song", image: UIImage(named: "DrPP") ?? UIImage() , fileName: "Immigrant Song"),
        
        Track(artistName: "Imagine dragons", trackName: "Enemy", image: UIImage(named: "maxresdefault") ?? UIImage(), fileName: "Enemy"),
        
        Track(artistName: "3 Doors Down", trackName: "Kryptonite", image: UIImage(named: "72cd5f") ?? UIImage(), fileName: "Kryptonite"),
        
        Track(artistName: "Shocking Blue", trackName: "Send Me A Postcard", image: UIImage(named: "66453g") ?? UIImage(), fileName: "shockingblue")
        
    ]
    
}

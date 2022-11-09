//
//  Photo.swift
//  Navigation
//
//  Created by Oleg Popov on 11.09.2022.
//

import Foundation
import UIKit


var photoInSection : Int = 0
var photoCollection : [UIImage] = [
                                   UIImage(named: "pig1.jpeg") ?? UIImage(),
                                   UIImage(named: "pig2.jpeg") ?? UIImage(),
                                   UIImage(named: "pig3.jpeg") ?? UIImage(),
                                   UIImage(named: "pig4.jpeg") ?? UIImage(),
                                   UIImage(named: "pig5.jpeg") ?? UIImage(),
                                   UIImage(named: "pig6.jpeg") ?? UIImage(),
                                   UIImage(named: "pig7.jpeg") ?? UIImage(),
                                   UIImage(named: "pig8.jpeg") ?? UIImage(),
                                   UIImage(named: "pig9.jpeg") ?? UIImage(),
                                   UIImage(named: "pig10.jpeg") ?? UIImage(),
                                   UIImage(named: "pig11.jpeg") ?? UIImage(),
                                   UIImage(named: "pig12.jpeg") ?? UIImage(),
                                   UIImage(named: "pig13.jpeg") ?? UIImage(),
                                   UIImage(named: "pig14.jpeg") ?? UIImage(),
                                   UIImage(named: "pig15.jpeg") ?? UIImage(),
                                   UIImage(named: "pig16.jpeg") ?? UIImage(),
                                   UIImage(named: "pig17.jpeg") ?? UIImage(),
                                   UIImage(named: "pig18.jpeg") ?? UIImage(),
                                   UIImage(named: "pig19.jpeg") ?? UIImage(),
                                   UIImage(named: "pig20.jpeg") ?? UIImage(),
                                   UIImage(named: "pig21.jpeg") ?? UIImage(),
                                   UIImage(named: "pig22.jpeg") ?? UIImage(),
                                   UIImage(named: "pig23.jpeg") ?? UIImage(),
                                   UIImage(named: "pig24.jpeg") ?? UIImage(),
                                   UIImage(named: "pig25.jpeg") ?? UIImage(),
                                   UIImage(named: "pig26.jpeg") ?? UIImage(),
                                ]


let photoData = ["pig1.jpeg", "pig2.jpeg", "pig3.jpeg", "pig4.jpeg", "pig5.jpeg", "pig6.jpeg", "pig7.jpeg", "pig8.jpeg", "pig9.jpeg", "pig10.jpeg", "pig11.jpeg", "pig12.jpeg", "pig13.jpeg", "pig14.jpeg","pig15.jpeg", "pig16.jpeg", "pig17.jpeg", "pig18.jpeg", "pig19.jpeg", "pig20.jpeg", "pig21.jpeg", "pig22.jpeg", "pig28.jpeg", "pig24.jpeg", "pig25.jpeg", "pig26.jpeg"]

//MARK: задаю размер фотографий в ленте профиля
let photoSizeInFeed = (UIScreen.main.bounds.width - 48)/4
//MARK: задаю размер фотографий в альбоме
let photoSizeInAlbom = (UIScreen.main.bounds.width - 32)/3




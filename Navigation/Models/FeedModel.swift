//
//  FeedModel.swift
//  Navigation
//
//  Created by Oleg Popov on 25.10.2022.
//

import Foundation

class FeedModel {
    
    let secretWord = "secret"
    
    func check(word: String) -> Bool {
        secretWord == word ? true : false
    }
}

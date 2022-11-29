//
//  InfoNetwork.swift
//  Navigation
//
//  Created by Oleg Popov on 29.11.2022.
//

import Foundation

var planetTitle: String = ""

struct InfoNetworkManeger {
    
    static func titleRequest() {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/todos/1") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let unwrappedData = data {
                    
                    do {
                        let serializedDictionary = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        
                        if let dict = serializedDictionary as? [String: Any] {
                            if let title = dict["title"] as? String {
                                planetTitle = title
                                print(title)
                            }
                        }
                    } catch let error {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
}

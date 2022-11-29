//
//  NetworkService.swift
//  Navigation
//
//  Created by Oleg Popov on 23.11.2022.
//

import Foundation

enum AppConfiguration: String, CaseIterable {
    
    case people = "https://swapi.dev/api/people/8"
    case starships = "https://swapi.dev/api/starships/3"
    case planets = "https://swapi.dev/api/planets/5"
}



struct NetworkService {
    
    
    static func performRequest (with urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print (error.localizedDescription)
                return
            }
            if let safeData = data, let urlResponse = response as? HTTPURLResponse {
                let dataString = String(data: safeData, encoding: .utf8)
                print ("Data: \(dataString ?? "")")
                print ("Response code: \(urlResponse.statusCode)")
                print ("Response header fields:\(urlResponse.allHeaderFields)")
            }
        }
        
        task.resume()
    }
}

//  при отключенном интернет (WiFi у ноутбука): Code=-1009 "The Internet connection appears to be offline."




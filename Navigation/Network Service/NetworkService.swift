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
    
    case titleData = "https://jsonplaceholder.typicode.com/todos/1"
    case planetData = "https://swapi.dev/api/planets/1"
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


struct Planet: Decodable {
        var name : String
        var rotationPeriod : String
        var orbitalPeriod : String
        var diameter : String
        var climate : String
        var gravity : String
        var terrain : String
        var surfaceWater : String
        var population : String
        var residents : [String]
        var films : [String]
        var created : String
        var edited : String
        var url : String
    }


var dataTitle: String = ""
var orbitalPeriod: String = ""


struct InfoNetworkService {
    
    static func titleRequest(for configuration: AppConfiguration) {
        if let url = URL(string: configuration.rawValue) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let unwrappedData = data {
                    do {
                        let serializedDictionary = try JSONSerialization.jsonObject(with: unwrappedData, options: [])
                        
                        if let dict = serializedDictionary as? [String: Any] {
                            if let title = dict["title"] as? String {
                                dataTitle = title
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
    
    static func orbitaRequest(for configuration: AppConfiguration) {
        if let url = URL(string: configuration.rawValue) {
            
            let task = URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
                
                if let unwrappedData = data {
                    
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let planet = try decoder.decode(Planet.self, from: unwrappedData)
                        orbitalPeriod = planet.orbitalPeriod
                        print(planet.orbitalPeriod)
                        
                    } catch let error {
                        print(error)
                    }
                }
            })
            task.resume()
            
        }
    }
    
}

//
//  InfoNetwork.swift
//  Navigation
//
//  Created by Oleg Popov on 29.11.2022.
//

import Foundation

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
   


var planetTitle: String = ""
var orbitalPeriod: String = ""

struct InfoNetworkService {
    
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
    
    static func orbitaRequest() {
        if let url = URL(string: "https://swapi.dev/api/planets/1") {

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

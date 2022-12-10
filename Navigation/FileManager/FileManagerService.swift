//
//  FileManagerService.swift
//  Navigation
//
//  Created by Oleg Popov on 09.12.2022.
//

import Foundation
import UIKit

protocol FileManagerServiceProtocol {
    func contentsOfDirectory(_ url : URL) -> [String]
    func copyFile(from url: URL, to destination: URL, complition: () -> Void)
    func removeContent(_ url: URL, complition: () -> Void)
}

class FileManagerService : FileManagerServiceProtocol{
    
    func copyFile(from url: URL, to destination: URL, complition: () -> Void){
        do {
            try FileManager.default.copyItem(at: url, to: destination)
            complition()
        } catch {
            print(error)
        }
    }
    
    func removeContent(_ url: URL, complition: () -> Void){
        do {
            try FileManager.default.removeItem(at: url)
            complition()
        } catch {
            print(error)
        }
    }
    
    func contentsOfDirectory(_ url : URL) -> [String]{
        var content : [String] = []
        do {
            let URLs = try FileManager.default.contentsOfDirectory(at: url, includingPropertiesForKeys: [], options: .skipsHiddenFiles)
            for url in URLs {
                content.append(url.lastPathComponent)
            }
            return content
        } catch {
            print(error)
        }
        return []
    }
    
}




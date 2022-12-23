//
//  CoreDataManager.swift
//  Navigation
//
//  Created by Oleg Popov on 23.12.2022.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let defaultManager = CoreDataManager()
    var posts: [LikesPostModel] = []
    
    lazy var persistentConteiner: NSPersistentContainer = {
        
        let conteiner = NSPersistentContainer(name: "coreData")
        conteiner.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
                
            }
        })
        return conteiner
    } ()
    
    
    init() {
        reloadPosts()
    }
    
    func saveContext() {
        let context = persistentConteiner.viewContext
        if context.hasChanges {
            do {
                try context.save()
            }catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func addPost(author: String, descriptionText: String, image: String, likes: Int64, views: Int64) {
        let newPost = LikesPostModel(context: persistentConteiner.viewContext)
        newPost.author = author
        newPost.descriptionText = descriptionText
        newPost.likes = likes
        newPost.views = views
        newPost.image = image
     
        saveContext()
        reloadPosts()
    }
    
    func reloadPosts() {
        let request = LikesPostModel.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        do{
            let fetchedPost = try persistentConteiner.viewContext.fetch(request)
            posts = fetchedPost
        } catch {
            print("error")
            posts = []
        }
    }
    
    func delete(){
        let answer = LikesPostModel.fetchRequest()
        do {
            let posts = try persistentConteiner.viewContext.fetch(answer)
            let context = persistentConteiner.viewContext
            for post in posts {
                context.delete(post)
            }
            saveContext()
        } catch {
            print(error)
        }
    }

}

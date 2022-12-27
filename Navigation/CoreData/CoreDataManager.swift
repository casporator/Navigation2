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
    
    // создаем бэкграунд контекст
    lazy var backgroundContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentConteiner.persistentStoreCoordinator
        return context
    }()
    
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
    
    // сохраняем бэкграунд контекст
    func saveBackgroundContext() {
        let context = backgroundContext
        if context.hasChanges{
            do {
                try context.save()
            }catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
   // теперь добавление поста идет в бэкграунде
    func addPost(author: String, descriptionText: String, image: String, likes: Int64, views: Int64) {
        backgroundContext.perform { [self] in
            let newPost = LikesPostModel(context: backgroundContext)
            newPost.author = author
            newPost.descriptionText = descriptionText
            newPost.likes = likes
            newPost.views = views
            newPost.image = image
            
            saveBackgroundContext()
            reloadPosts()
        }
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
    
    
    //создаю функцию для удаление одного поста:
    func deleteOnePost(index: Int) {
        let answer = LikesPostModel.fetchRequest()
        do {
            let post = try persistentConteiner.viewContext.fetch(answer)
            let context = persistentConteiner.viewContext
                context.delete(post[index])

            saveContext()
        } catch {
            print(error)
        }
    }
    
    
    
    func deleteAllPosts(){
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
    
    func getSerchResault(by: String) {
        let answer = LikesPostModel.fetchRequest()
        answer.predicate = NSPredicate(format: "author CONTAINS[c] %@", by)
        do {
            let sortedPosts = try persistentConteiner.viewContext.fetch(answer)
            posts = sortedPosts
        } catch {
            print(error)
       
       }
    }
    
    
}

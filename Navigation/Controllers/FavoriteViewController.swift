//
//  FavoriteViewController.swift
//  Navigation
//
//  Created by Oleg Popov on 23.12.2022.
//

import Foundation
import UIKit

class FavoriteViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.sectionHeaderHeight = UITableView.automaticDimension
        table.sectionFooterHeight = 0
        table.rowHeight = UITableView.automaticDimension
        table.register(PostTableViewCell.self, forCellReuseIdentifier: "CustomCell")
        table.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIdentifier")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Favorite"
        view.backgroundColor = .white
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchByAutor))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(cancelSearch))
        navigationItem.rightBarButtonItems = [searchButton, cancelButton]
        setUpUI()
}


    func setUpUI() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc func searchByAutor() {
        showInputDialog(title: "by Autor:", actionHandler:  { text in
            if let result = text {
                CoreDataManager.defaultManager.getSerchResault(by: result)
                self.tableView.reloadData()
            }
        })
    }
    
    @objc func cancelSearch () {
        CoreDataManager.defaultManager.reloadPosts()
        tableView.reloadData()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        CoreDataManager.defaultManager.reloadPosts()
        tableView.reloadData()
    }
}

extension FavoriteViewController : UITableViewDelegate {

}

extension FavoriteViewController : UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataManager.defaultManager.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! PostTableViewCell
        cell.setupPostFromCoreData(post: CoreDataManager.defaultManager.posts[indexPath.row])
        return cell

    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Удаление элемента cвайпом
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            deleteAction(forRowAt: indexPath)
        ])
    }
    
    private func deleteAction(forRowAt indexPath: IndexPath) -> UIContextualAction {
        return UIContextualAction(style: .destructive, title: "Delete") { (action, swipeButtonView, completion) in
            CoreDataManager.defaultManager.delete(post: CoreDataManager.defaultManager.posts[indexPath.row])
            CoreDataManager().reloadPosts()
            self.tableView.reloadData()
            completion(true)
        }
}
}


  

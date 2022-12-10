//
//  FileViewController.swift
//  Navigation
//
//  Created by Oleg Popov on 08.12.2022.
//

import Foundation
import UIKit

class FileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITableViewDelegate {
    
    var currentDirectory : URL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    var content: [String] = []
    
    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "defaultCell")
        table.toAutoLayout()
        return table
    }()
    
    override func viewDidLoad() {
     super.viewDidLoad()
            
        view.backgroundColor = .systemIndigo
        view.addSubview(tableView)
        navBarCustomization()
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       tableView.reloadData()
    }
    
    
    func addConstraints(){
        NSLayoutConstraint.activate([
        
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
    
    func navBarCustomization () {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationItem.title = "File Manager"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(addPhoto))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
     
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let rawURL = info[.imageURL] {
            let stringURL = String(describing: rawURL)
            let url = URL(string: stringURL)

            if let url = url {
                let destination = currentDirectory.appendingPathComponent(url.lastPathComponent)

                FileManagerService().copyFile(from: url, to: destination) {
                    self.content = FileManagerService().contentsOfDirectory(self.currentDirectory)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

                    imagePicker.dismiss(animated: true)
                }
            }
        }

    }
    
    @objc func addPhoto() {
        present(imagePicker, animated: true)
        self.tableView.reloadData()
    }
    
}

extension FileViewController: UITableViewDataSource {
  
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultCell", for: indexPath)
        cell.textLabel?.text = content[indexPath.row]
        return cell
    }
    
  
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let url = currentDirectory.appendingPathComponent(content[indexPath.row])

            FileManagerService().removeContent(url) {
                self.content = FileManagerService().contentsOfDirectory(self.currentDirectory)
                self.tableView.reloadData()
            }
        }
    }
 
    
}

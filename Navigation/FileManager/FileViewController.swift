//
//  FileViewController.swift
//  Navigation
//
//  Created by Oleg Popov on 08.12.2022.
//

import Foundation
import UIKit

import UIKit

class FileViewController: UIViewController, UITableViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    
     //  путь в котором находимся:
    var path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    //массив файлов этой директории;
    var files: [String] {
        (try? FileManager.default.contentsOfDirectory(atPath: path)) ?? []
    }
   
    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    private lazy var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIdentifier")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        
        title = URL(fileURLWithPath: path).lastPathComponent

        let addFile = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(createFile))
        let addFolder = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(createFolder))
        navigationItem.rightBarButtonItems = [addFolder, addFile]
    

        view.addSubview(tableView)
        addConstraints()


      
    }

    func addConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    @objc
    func createFolder(){
        
        TextPicker.defaaultPicker.showPicker(in: self) { text in
            let newDirectoryPath = self.path + "/" + text
            try? FileManager.default.createDirectory(atPath: newDirectoryPath, withIntermediateDirectories: false)
            self.tableView.reloadData()
        }
    }
    
    @objc
    func createFile(){
        present(imagePicker, animated: true)
        self.tableView.reloadData()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let urlOfPhoto = info[.imageURL] as? URL {
            try? FileManager.default.moveItem(atPath: urlOfPhoto.relativePath, toPath: self.path + "/" + urlOfPhoto.lastPathComponent)
            imagePicker.dismiss(animated: true)
            self.tableView.reloadData()
        }
    }
    
    static func showFolder(in viewController: UIViewController, withPath path: String) {
        let vc = FileViewController()
        vc.path = path
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FileViewController : UITableViewDataSource{

    // Настраиваем кол-во секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Настраиваем кол-во строк в секциях
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }
    
    // Заполняем данными таблицу.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)
        
        cell.textLabel?.text = files[indexPath.row]
        
        //определяем что находится в ячейке (папка или файл)
        let fullPath = path + "/" + files[indexPath.row]
        var isDir: ObjCBool = false
       if FileManager.default.fileExists(atPath: fullPath, isDirectory: &isDir)
        {
           if isDir.boolValue == true {
               cell.detailTextLabel?.text = "Folder"
               cell.textLabel?.textColor = .blue
           } else {
               cell.detailTextLabel?.text = "photo"
           }
       }
         return cell
    
}

    // Обработка клика на строку в таблице. При клике переходим на другое вью контроллер
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let fullPath = path + "/" + files[indexPath.row]
        var isDir: ObjCBool = false
        if FileManager.default.fileExists(atPath: fullPath, isDirectory: &isDir)
         {
            if isDir.boolValue == true {
                FileViewController.showFolder(in: self, withPath: fullPath)
                
            } else {
                
            }
        }
    }
                    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // Удаление элемента
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let fullPath = path + "/" + files[indexPath.row]
            try? FileManager.default.removeItem(atPath: fullPath)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            
        }
    }
}

//
//  InfoViewController.swift
//  Navigation
//
//  Created by Oleg Popov on 16.08.2022.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDelegate {

    // создаем алерт c заголовок и сообщением
    let alertController = UIAlertController(title: "Внимание!", message: "Удалить пост №1 ?", preferredStyle: .alert)
    
    private var backButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont(name: "Hannotate SC Bold", size: 16)
        button.backgroundColor = .systemGray6
        button.toAutoLayout()
        return button
    }()
    
    private var delButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Delete post", for: .normal)
        button.titleLabel?.font = UIFont(name: "Hannotate SC Bold", size: 16)
        button.backgroundColor = .systemGray6
        button.toAutoLayout()
        return button
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = dataTitle
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
    private var orbitaLabel: UILabel = {
        let label = UILabel()
        label.text = "период обращения планеты:\n \(orbitalPeriod) дня "
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .gray
        label.toAutoLayout()
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "defaultTableCellIdentifier")
        table.toAutoLayout()
        return table
    }()
     
    override func viewDidLoad() {
           super.viewDidLoad()
            view.backgroundColor = .systemGray6
        
        
        //включаем отображение кнопки на экране:
        view.addSubview(tableView)
        view.addSubview(delButton)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(orbitaLabel)
       
        
        
        backButton.addTarget(self, action: #selector(goToPostController), for: .touchUpInside)
        delButton.addTarget(self, action: #selector(showMessage), for: .touchUpInside)
        
        // добавляем события
        alertController.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
                    print("Post №1 deleted")
                }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
                    print("delete cancel")
                }))
        
    
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10 ),
            backButton.widthAnchor.constraint(equalToConstant: 70),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
            delButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            delButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            delButton.widthAnchor.constraint(equalToConstant: 100),
            delButton.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 25),
            
            orbitaLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orbitaLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            
            tableView.topAnchor.constraint(equalTo: orbitaLabel.bottomAnchor, constant:  15),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            
        ])
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()

        }
    }
    
       // функция возврата на "ПостВью"
        @objc func goToPostController() {
          self.dismiss(animated: true, completion: nil)
        }
        
       
        @objc func showMessage() {
            self.present(alertController, animated: true, completion: nil)
            }
    
}


extension InfoViewController : UITableViewDataSource{

    // Настраиваем кол-во секций в таблице
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "defaultTableCellIdentifier", for: indexPath)

        InfoNetworkService.request(for: residents[indexPath.row], index: indexPath.row)
        cell.textLabel?.text = residentsName[indexPath.row]

        return cell

    }
}

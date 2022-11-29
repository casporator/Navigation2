//
//  InfoViewController.swift
//  Navigation
//
//  Created by Oleg Popov on 16.08.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    
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
        label.text = planetTitle
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
    
    
    override func viewDidLoad() {
           super.viewDidLoad()
            view.backgroundColor = .systemGray6
        
        
        //включаем отображение кнопки на экране:
        view.addSubview(delButton)
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(orbitaLabel)
        
        
        
        backButton.addTarget(self, action: #selector(goToPostController), for: .touchUpInside)
        delButton.addTarget(self, action: #selector(showMessage), for: .touchUpInside)
        
        // добавляем события
        alertController.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
                    print("Пост №1 был удалён")
                }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
                    print("отмена удаления поста №1")
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
            orbitaLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
                
        ])
        
    }
    
    
       // функция возврата на "ПостВью"
        @objc func goToPostController() {
          self.dismiss(animated: true, completion: nil)
        }
        
        // функция вывода сообщения
        @objc func showMessage() {
            self.present(alertController, animated: true, completion: nil)
            }
    }
    

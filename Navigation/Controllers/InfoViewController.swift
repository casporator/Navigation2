//
//  InfoViewController.swift
//  Navigation
//
//  Created by Oleg Popov on 16.08.2022.
//

import UIKit

class InfoViewController: UIViewController {
    
    let backButton = UIButton()
    let messageButton = UIButton()
    
    // создаем алерт c заголовок и сообщением
    let alertController = UIAlertController(title: "Внимание!", message: "Удалить пост №1 ?", preferredStyle: .alert)

    
    override func viewDidLoad() {
           super.viewDidLoad()
            view.backgroundColor = .systemGray6
        
        //настройки кнопкии удалить пост
        messageButton.setTitle(" удалить пост ", for: .normal)
        messageButton.frame = CGRect(x: 0, y: 0, width: 150, height: 35)
        messageButton.titleLabel?.font = UIFont(name: "Hannotate SC Bold", size: 20)
        messageButton.setImage(UIImage(systemName: "trash.square"), for: .normal)
        messageButton.backgroundColor = .white
        messageButton.setTitleColor(UIColor.black, for: .normal)
        messageButton.setTitleColor(UIColor.systemGray2, for: .highlighted)
        messageButton.center = self.view.center
        
        //настройки кнопка назад
        backButton.setTitle("Назад", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "Hannotate SC Bold", size: 20)
        backButton.setImage(UIImage(systemName: "arrow.left.square"), for: .normal)
        backButton.backgroundColor = .white
        backButton.setTitleColor(UIColor.black, for: .normal)
        backButton.setTitleColor(UIColor.systemGray2, for: .highlighted)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        
     
        
        //включаем отображение кнопки на экране:
        view.addSubview(messageButton)
        view.addSubview(backButton)
        //добавляем таргеты на кнопки
        backButton.addTarget(self, action: #selector(goToPostController), for: .touchUpInside)
        messageButton.addTarget(self, action: #selector(showMessage), for: .touchUpInside)
        
        // добавляем события
        alertController.addAction(UIAlertAction(title: "Delete", style: .default, handler: { _ in
                    print("Пост №1 был удалён")
                }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
                    print("отмена удаления поста №1")
                }))
        
        
        NSLayoutConstraint.activate([
                backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                backButton.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: 50 )
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
    

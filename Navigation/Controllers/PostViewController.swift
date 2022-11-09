//
//  PostViewController.swift
//  Navigation
//
//  Created by Oleg Popov on 15.08.2022.
//

import UIKit

class PostViewController: UIViewController {
    
    var titlePost: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        self.title = titlePost
        
    // создаем UIBarButtonItem
        let bar = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showBar))
        navigationItem.rightBarButtonItems = [bar]
    }
    
    // функция для отображения InfoViewController в модальном окне
    @objc func showBar() {
        let popupViewController = InfoViewController()
        popupViewController.modalPresentationStyle = .fullScreen
        self.present(popupViewController, animated: true, completion: nil)
    }
    
    
}


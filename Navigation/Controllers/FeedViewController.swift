//
//  FeedViewController.swift
//  Navigation
//
//  Created by Oleg Popov on 15.08.2022.
//

import UIKit

class FeedViewController: UIViewController {
    // Mark: создание обьекта Post
    var postTitle = HeadPost(title: "Пост")
    
    private let textField: CustomTextField = {
      let field =  CustomTextField(placeholder: "Введите секретное слово ")
        field.isSecureTextEntry = true 
        field.autocapitalizationType = .none
        
        return field
    }()
    
   private let button: CustomButton = {
        let button = CustomButton(title: " читать пост #1")
        button.layer.borderColor = UIColor.white.cgColor // этим кнопкам добавляю рамку
        button.layer.borderWidth = 2
        return button
    }()
       
    private let secondButton: CustomButton = {
       let button = CustomButton(title: " читать пост #2")
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
      return button
    }()
    
    private let checkGuessButton = CustomButton(title: "Проверить секретное слово")
    
    private let resultButton: CustomButton = CustomButton(title: "Проверка", backgroundColor: .systemYellow)
        
    private let stackView: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.spacing = 10.0
        stack.toAutoLayout()
       
        return stack
    }()
       
    override func viewDidLoad() {
     super.viewDidLoad()
            
        view.backgroundColor = .systemIndigo
    
        view.addSubview(stackView)
        addView()
        navBarCustomization()
        setConstraints()
        addButtunAction()
    }
        
         
    func addView(){
            stackView.addArrangedSubview(button)
            stackView.addArrangedSubview(secondButton)
            stackView.addArrangedSubview(textField)
            stackView.addArrangedSubview(checkGuessButton)
            stackView.addArrangedSubview(resultButton)
    }
        
    func setConstraints(){
       NSLayoutConstraint.activate([
           button.widthAnchor.constraint(equalToConstant: 250),
           button.heightAnchor.constraint(equalToConstant: 40),
        
           secondButton.widthAnchor.constraint(equalToConstant: 250),
           secondButton.heightAnchor.constraint(equalToConstant: 40),
        
           textField.heightAnchor.constraint(equalToConstant: 50),
           textField.widthAnchor.constraint(equalToConstant: 300),
           
           resultButton.widthAnchor.constraint(equalToConstant: 100),
           resultButton.heightAnchor.constraint(equalToConstant: 40),
           
           checkGuessButton.widthAnchor.constraint(equalToConstant: 250),
           checkGuessButton.heightAnchor.constraint(equalToConstant: 40),
        
           stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
       ])
    }

    // Mark: функция нажатия на кнопки
     func addButtunAction() {
       
         [button, secondButton].forEach{
            ($0).buttonAction = { [self] in
        let detailController = PostViewController()
        detailController.titlePost = postTitle.title //передаём наш пост в виде заголовка на PostView
        navigationController?.pushViewController(detailController, animated: false)
    }
  }

         checkGuessButton.buttonAction = { [self] in
             let inputWord = textField.text ?? ""
             let result: Bool = FeedModel().check(word: inputWord)
             if result == true {
                 resultButton.setTitle("Верно", for: .normal)
                 resultButton.backgroundColor = .systemGreen
                 textField.text = ""
             } else {
                 resultButton.setTitle("Не верно", for: .normal)
                 resultButton.backgroundColor = .systemRed
                 textField.text = ""
             }
         }
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
            self.navigationItem.title = "Лента"
            
            // Mark: добавляю кнопку справа нав бара
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
            self.navigationItem.rightBarButtonItem?.tintColor = .black
         
        
        
    }
}

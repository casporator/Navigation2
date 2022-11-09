//
//  LogInViewController.swift
//  Navigation
//
//  Created by Oleg Popov on 03.09.2022.
//

import UIKit

class LoginViewController : UIViewController {
    
    //Для класса LoginViewController сделайте свойство loginDelegate
    var loginDelegate : LoginViewControllerDelegate?
    

    // MARK: создаю скролвью
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        
        return scrollView
    }()
    
    // MARK: coздаю лого:
    
    private lazy var logoImageView: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "logo")
        logo.toAutoLayout()
        
        return logo
    }()
    
    // MARK: coздаю стэк для полей вводы пароля и почты:
    
    private lazy var stackViewTextFields : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.backgroundColor = .systemGray6
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.toAutoLayout()
        
        return stackView
        
    }()
    
    // MARK: создаю поле ввода почты
    
    private lazy var emailTextField : UITextField = {
        let email = UITextField()
        email.placeholder = "Email or phone"
        email.font = UIFont(name: "system", size: 16.0)
        email.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: email.frame.height))
        email.leftViewMode = .always
        email.toAutoLayout()
        email.autocapitalizationType = .none
        
        return email
    }()
    
    private lazy var line : UIView = {
        let line = UIView()
        line.backgroundColor = .lightGray
        line.toAutoLayout()
        
        return line
    }()
    
    // MARK: создаю поле ввода пароля
    private lazy var passwordTextField : UITextField = {
        let password = UITextField()
        password.placeholder = "Password"
        password.font = UIFont(name: "system", size: 16.0)
        password.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: password.frame.height))
        password.leftViewMode = .always
        password.toAutoLayout()
        password.isSecureTextEntry = true 
        password.autocapitalizationType = .none
      
        return password
    }()
    
    //MARK: добавляю кнопку логин
    private lazy var loginButton = CustomButton(title: "Log In", backgroundColor: UIColor(patternImage: UIImage(named: "blue_pixel.png") ?? UIImage()), cornerRadius: 10)
    

    // объявляю алертконтроллер (в случае неверного логина)
    let alertPassword = UIAlertController(title: "Error!", message: "You have entered an incorrect login or password", preferredStyle: .actionSheet)
  
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
        addViews()
        addConstraints()
        setupGestures()
        addButtonActions()
       
   }

    
    // MARK: клавиатура
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        
        NotificationCenter.default.addObserver(
            self,selector: #selector(self.didShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(
            self,selector: #selector(self.didShowKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func didShowKeyboard(_ notification: Notification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let loginButtonBottomPointY = self.loginButton.frame.origin.y + loginButton.frame.height
            
            let keyboardOriginY = self.view.frame.height - keyboardHeight
            
            let yOffset = keyboardOriginY < loginButtonBottomPointY
            ? loginButtonBottomPointY - keyboardOriginY + 35
            : 0
            
            self.scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    

    //MARK: Функция тапа клавиатуры
     func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.forcedHidingKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    //MARK: Функция сокрытия клавиатуры
    @objc func didHideKeyboard(_ notification: Notification){
        self.forcedHidingKeyboard()
    }
    @objc  func forcedHidingKeyboard() {
        self.view.endEditing(true)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
   
    //MARK: Функция нажатия кнопки Login
    func addButtonActions() {

        loginButton.buttonAction = { [self] in
     
        let incomingLogin = emailTextField.text
        let incomingPassword = passwordTextField.text
        
#if DEBUG
        let loginingUser = TestUserService()
#else
        let loginingUser = CurrentUserService()
#endif
        if loginDelegate?.checkLogin(controller: self, login: incomingLogin ?? "", password: incomingPassword ?? "") == true {
            
            let profileViewController = ProfileViewController()
            profileViewController.user1 = loginingUser.user
            navigationController?.pushViewController(profileViewController, animated: true)
        } else {
            self.present(alertPassword, animated: true, completion: nil)
            self.view.applyBlurEffect()
            
        }
      }
    }
    
    
    func addViews(){
  
        view.addSubview(scrollView)
     
        stackViewTextFields.addArrangedSubview(emailTextField)
        stackViewTextFields.addArrangedSubview(line)
        stackViewTextFields.addArrangedSubview(passwordTextField)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(stackViewTextFields)
        scrollView.addSubview(loginButton)
        
        alertPassword.addAction(UIAlertAction(title: "Forgot password", style: .default, handler: { action in
            self.view.removeBlurEffect() }))
        alertPassword.addAction(UIAlertAction(title: "Try again", style: .cancel, handler: { action in
            self.view.removeBlurEffect() }))
      
      
        
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            logoImageView.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            
            stackViewTextFields.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 120),
            stackViewTextFields.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 16),
            stackViewTextFields.heightAnchor.constraint(equalToConstant: 100),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 49.75),
            emailTextField.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            emailTextField.leftAnchor.constraint(equalTo: stackViewTextFields.leftAnchor),
            
            line.heightAnchor.constraint(equalToConstant: 0.5),
            line.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            line.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 16),

            passwordTextField.heightAnchor.constraint(equalToConstant: 49.75),
            passwordTextField.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: line.bottomAnchor),
            passwordTextField.leftAnchor.constraint(equalTo: stackViewTextFields.leftAnchor),
            
            loginButton.topAnchor.constraint(equalTo: stackViewTextFields.bottomAnchor, constant: 16),
            loginButton.centerXAnchor.constraint(equalTo: super.view.centerXAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.leftAnchor.constraint(equalTo: super.view.leftAnchor, constant: 16),
            
        ])
    }
}



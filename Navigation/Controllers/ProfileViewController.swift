//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Oleg Popov on 15.08.2022.
//


import Foundation
import UIKit
import StorageService
import iOSIntPackage


class ProfileViewController: UIViewController {
    
var user1: User = User(userName: "Mr.Pipin", userAvatar: UIImage(named: "pipin") ?? UIImage(), userStatus: "Мои шесть кубиков защищены слоем жира")
  
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "CustomPostCell")
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: "PhotosCell")
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    //MARK: объявляю дубликат аватара и длелаю его скрытым
    private lazy var duplicateAvatar : UIImageView = {
        let avatar = UIImageView()
        avatar.image = user1.userAvatar
        avatar.layer.cornerRadius = 60
        avatar.layer.masksToBounds = true
        avatar.layer.borderWidth = 3
        avatar.layer.borderColor = UIColor.white.cgColor
        avatar.isHidden = true
        avatar.toAutoLayout()
        
        return avatar
    }()
    
    //MARK: объявляю элемент закрытия и делаю его скрытым
    private lazy var xmarkView : UIImageView = {
        let xmark = UIImageView()
        xmark.image = UIImage(systemName: "xmark")
        xmark.tintColor = .white
        xmark.isHidden = true
        xmark.isUserInteractionEnabled = true
        xmark.toAutoLayout()
        
        return xmark
    }()
    
    //MARK: объявляю вью и делаю его скрытым
    private lazy var hiddenView : UIView = {
        var view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.isHidden = true
        view.toAutoLayout()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBarController?.tabBar.isHidden = false
       
        view.addSubviews(tableView, hiddenView, duplicateAvatar, xmarkView)
        addConstraints()
        tableView.reloadData()
        addGestures()
        addNotification()
        hideKeyboardWhenTappedAround()
        
        
#if DEBUG
           view.backgroundColor = .blue
       #else
       view.backgroundColor = .white
       #endif
       }
    
   
    @objc func didTouchAvatar(notification: Notification) {
        startAnimation()
    }
   
    @objc func didTouchXmark(_ gestureRecognizer: UITapGestureRecognizer){
        closeAnimation()
    }
    
    
    //MARK: анимация
    private func startAnimation() {
        
        self.hiddenView.isHidden = false
        self.hiddenView.alpha = 0.5
        self.tableView.applyBlurEffect()
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut) { [self] in
            //MARK: задаю все изменения дубликата аватара при анимации
            duplicateAvatar.isHidden = false
            duplicateAvatar.center = tableView.center
            duplicateAvatar.transform = CGAffineTransform(
                scaleX: tableView.frame.width / duplicateAvatar.frame.width,
                     y: tableView.frame.width / duplicateAvatar.frame.width)
            duplicateAvatar.isUserInteractionEnabled = false
            duplicateAvatar.layer.cornerRadius = 0
            
           
            //MARK: задаю появление xmarkView при окончании анимации
        } completion: { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.xmarkView.isHidden = false
            })
        }
    }
    
    //MARK: анимация закрытия
    private func closeAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut) {
            
            //возвращаю аватар
            self.duplicateAvatar.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.duplicateAvatar.center = CGPoint(x: 75, y: 120)
            self.duplicateAvatar.layer.cornerRadius = 60
            
            //возвращаю прозрачность скрытого вью
            self.hiddenView.alpha = 0
            // прячу xmark
            self.xmarkView.isHidden = true
            
           
            
        } completion: { _ in
           
            NotificationCenter.default.post(name: Notification.Name("userTouchXmark"), object: nil)
            self.duplicateAvatar.isHidden = true
            self.hiddenView.isHidden = true
            self.tableView.removeBlurEffect() //отключаю Блюр для тейблвью
        }
    }


    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func addNotification(){
        NotificationCenter.default.addObserver(self,
            selector: #selector(didTouchAvatar(notification:)),
            name: Notification.Name("userTouchAva"),
            object: nil)
    }
 
    func addConstraints(){
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), 
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            hiddenView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hiddenView.leftAnchor.constraint(equalTo: view.leftAnchor),
            hiddenView.rightAnchor.constraint(equalTo: view.rightAnchor),
            hiddenView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            duplicateAvatar.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            duplicateAvatar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            duplicateAvatar.widthAnchor.constraint(equalToConstant: 120),
            duplicateAvatar.heightAnchor.constraint(equalToConstant: 120),

            xmarkView.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 16),
            xmarkView.rightAnchor.constraint(equalTo: tableView.rightAnchor, constant: -16),
            xmarkView.widthAnchor.constraint(equalToConstant: 30),
            xmarkView.heightAnchor.constraint(equalToConstant: 30),
            
        ])
    }
    
    //MARK: устанавливаю реагирование на тач для xmarkView
    func addGestures(){
         let tapGestureRecognizerForXmark = UITapGestureRecognizer(target: self, action: #selector(self.didTouchXmark(_:)))
        self.xmarkView.addGestureRecognizer(tapGestureRecognizerForXmark)
    }
}
   
  

extension ProfileViewController : UITableViewDataSource, UITableViewDelegate {
    
    //MARK: передаю ProfileHeader в Хэдер
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let profile = ProfileHeaderView()
            profile.setupUserData(user: user1)
            return profile
        }
        return nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        if section == 1 {
            return viewModel.count
        }
        return 0
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            let photosViewController = PhotosViewController()
            navigationController?.pushViewController(photosViewController, animated: true)
        }
    }
   
    // ручная настройка высоты ячеек
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 160
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "PhotosCell", for: indexPath) as! PhotoTableViewCell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CustomPostCell", for: indexPath) as! PostTableViewCell
            cell.setupPost(post: viewModel[indexPath.row])
            return cell
        }
    }
    
}



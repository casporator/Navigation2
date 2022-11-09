//
//  PostTableView.swift
//  Navigation
//
//  Created by Oleg Popov on 07.09.2022.
//

import Foundation
import UIKit

class PostTableViewCell: UITableViewCell {
    
    struct ViewModel {
        let autor: String
        let descriptionText: String
        let likes : String
        let views: String
        let image: UIImage?

    }

    private lazy var autor : UILabel = {
        let label = UILabel()
        label.text = "Svinki.ru"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .black
        label.numberOfLines = 2
        label.toAutoLayout()
        
        return label
    }()
    
    private lazy var img : UIImageView = {
        let img = UIImageView()
        img.image =  UIImage(named: "pigs")
        img.contentMode = .scaleAspectFit
        img.backgroundColor = .black
        img.toAutoLayout()
        
        return img
    }()
    
    private lazy var descriptionText : UILabel = {
        let descriptionText = UILabel()
        descriptionText.text = "Находясь в естественных условиях, дикие морские свинки предпочитают проявлять свою активность, как с восходом солнца, так и с наступлением сумерек. Не смотря на свои размеры, зверьки бегают достаточно быстро и считаются весьма проворными, всегда находящимися настороже. /nОбитает дикая морская свинка, как в лесных массивах, так и в гористой местности. Для обустройства своего гнезда они подыскивают тихие укромные места, при этом нор они не роют. Чтобы сформировать свое жилище они пользуются сухой травой, пухом и тонкими ветками деревьев и кустарников."
        descriptionText.font = UIFont.systemFont(ofSize: 14.0)
        descriptionText.textColor = .systemGray
        descriptionText.numberOfLines = 0
        descriptionText.toAutoLayout()
        
        return descriptionText
    }()
    
    private lazy var likes : UILabel = {
        let likes = UILabel()
        likes.text = "Likes: 157032"
        likes.font = UIFont.systemFont(ofSize: 16.0)
        likes.textColor = .black
        likes.toAutoLayout()
        
        return likes
    }()
    
    private lazy var views : UILabel = {
        let views = UILabel()
        views.text = "Views: 250017"
        views.font = UIFont.systemFont(ofSize: 16.0)
        views.textColor = .black
        views.toAutoLayout()
        
        return views
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.addSubviews(autor, img, descriptionText, likes, views)
        addConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(with viewModel: ViewModel) {
        autor.text = viewModel.autor
        descriptionText.text = viewModel.descriptionText
        likes.text = viewModel.likes
        views.text = viewModel.views
        img.image = viewModel.image
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            autor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            autor.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
           
            img.topAnchor.constraint(equalTo: autor.bottomAnchor, constant: 12),
            img.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            img.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            img.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            descriptionText.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 16),
            descriptionText.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            descriptionText.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            likes.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 16),
            likes.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            views.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: 16),
            views.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),

            self.contentView.bottomAnchor.constraint(equalTo: views.bottomAnchor, constant: 16)
            
        ])
    }
}

    
    
    
    


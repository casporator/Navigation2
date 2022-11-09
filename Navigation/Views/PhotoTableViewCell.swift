//
//  PhotoTableViewCell.swift
//  Navigation
//
//  Created by Oleg Popov on 11.09.2022.
//

import Foundation
import UIKit
import StorageService

class PhotoTableViewCell : UITableViewCell {
    
    private lazy var titleLabel : UILabel = {
        let title = UILabel()
        title.text = "Photos"
        title.font = UIFont.boldSystemFont(ofSize: 24.0)
        title.textColor = .black
        title.toAutoLayout()
        
        return title
    }()
    
    private lazy var arrowImage: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "arrow.right")
        arrow.tintColor = .black
        arrow.toAutoLayout()
        
        return arrow
    }()
    
    
    private lazy var layout : UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // хотел сделать горризонтальный скролл! установил 8 ячеек..но скролла нет ((((  Или это так не работает? Нельщя засунуть в таблицу коллекцию и скролить по горизонтали?
        layout.collectionView?.isPagingEnabled = true
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        
        return layout
    }()
    
    private lazy var collectionInFeed: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.allowsSelection = false
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collection.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collection.delegate = self
        collection.dataSource = self
        
        collection.toAutoLayout()
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews(){
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImage)
        contentView.addSubview(collectionInFeed)
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            
            arrowImage.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            arrowImage.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            
            collectionInFeed.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            collectionInFeed.leftAnchor.constraint(equalTo: self.leftAnchor),
            collectionInFeed.rightAnchor.constraint(equalTo: self.rightAnchor),
          //  collectionInFeed.heightAnchor.constraint(equalToConstant: photoSizeInFeed),
            collectionInFeed.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12),
        ])
    }
}

extension PhotoTableViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        cell.setup(name: "\(photoData[indexPath.row])")
        cell.layer.cornerRadius = 6 //устанавливаю закругление согласно макету
        cell.clipsToBounds = true
        cell.backgroundColor = .clear
        
        return cell
    }
}
extension PhotoTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: photoSizeInFeed, height: photoSizeInFeed)

    }
}


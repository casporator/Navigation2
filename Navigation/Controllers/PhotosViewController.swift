//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Oleg Popov on 11.09.2022.
//

import Foundation
import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
 
 
   // private let facade = ImagePublisherFacade()
    var contentPhotoDataArray: [UIImage] = []
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return layout
    }()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "DefaultCell")
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: "CustomCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.toAutoLayout()
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = false
        self.title = "Photo Gallery"

        
        addViews()
        addConstraints()
        addFilter()
    }
      
    func addFilter() {
        
        let start = CFAbsoluteTimeGetCurrent()
        
        ImageProcessor().processImagesOnThread(sourceImages: photoCollection, filter: .fade, qos: .userInitiated) {filteredImages in
            
            for (index,item) in filteredImages.enumerated() {
                photoCollection[index] = UIImage(cgImage: item!)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                
                let diff = CFAbsoluteTimeGetCurrent() - start
                print ("время наложения фильтра на все картинки: \(diff)")
            }
        }
    }

    
/*
 
всего обрабатывается 26 картинок
разные фильтры, один и тот же qos:
    filter: .chrome, qos: .userInitiated = старт 1.9114, финиш 2.90006
    filter: .tonal, qos: .userInitiated = старт 1.8372, финиш 2.7847
    filter: .colorInvert, qos: .userInitiated = старт 1.87268, финиш 2.8132
    filter: .posterize, qos: .userInitiated = старт 1.9298, финиш 2.7627
    filter: .fade, qos: .userInitiated = старт 1.87128, финиш 2.8260
 
 один и тот же фильтр, но разный qos:
    filter: .chrome, qos: .userInitiated = старт 1.9114, финиш 2.90006
    filter: .chrome, qos: .userInteractive = старт 1.882, финиш 2.8421
    filter: .chrome, qos: .default = старт 1.8875, финиш 2.85869
    filter: .chrome, qos: .utility = старт 1.9441, финиш 2.92886
    filter: .chrome, qos: .background = старт 6.868, финиш 7.89184
 
*/
    
    
    func addViews(){
        view.addSubview(collectionView)
    }

    func addConstraints(){
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}

extension PhotosViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCollection.count
       
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? PhotosCollectionViewCell else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DefaultCell", for: indexPath)
            return cell
        }
        cell.setupImagePublisher(image: photoCollection[indexPath.row])
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: photoSizeInAlbom, height: photoSizeInAlbom)
    }
}

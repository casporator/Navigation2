//
//  TrackListController.swift
//  Navigation
//
//  Created by Oleg Popov on 20.11.2022.
//

import Foundation
import UIKit

final class TrackListController: UIViewController {
    
    private let musicButton: UIButton = {
        let button = UIButton()
        button.setTitle("Audio playlist", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 12
        button.toAutoLayout()
        return button
    }()
    
    private let videoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Video playlist", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        button.backgroundColor = .systemGray2
        button.layer.cornerRadius = 12
        button.toAutoLayout()
        button.addTarget(self, action: #selector(goToVideo), for: .touchUpInside)
        return button
    }()
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let tracklist = TrackModel.tracks
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //navigationController?.navigationBar.isHidden = false
      
        view.addSubviews(musicButton, videoButton)
        setupTableView()
        navBarCustomization()
        
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemCyan
        tableView.toAutoLayout()
        view.addSubviews(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        
            musicButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            musicButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 13),
            musicButton.heightAnchor.constraint(equalToConstant: 60),
            musicButton.rightAnchor.constraint(equalTo: view.centerXAnchor),
            
            videoButton.leftAnchor.constraint(equalTo: musicButton.rightAnchor),
            videoButton.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: 13),
            videoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            videoButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func goToVideo() {
        navigationController?.pushViewController(VideoListController(), animated: false)
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
        self.navigationItem.title = "Audio Playlist"
    }
}

extension TrackListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracklist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellID")
        let track = tracklist[indexPath.row]
        
        cell.accessoryType = .disclosureIndicator
        cell.detailTextLabel?.text = track.artistName
        cell.textLabel?.text = track.trackName
        cell.imageView?.image = track.image
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 300
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        }
}

extension TrackListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row
        let playerVC = PlayerController()
        playerVC.tracklist = tracklist
        playerVC.position = position
        navigationController?.present(playerVC, animated: true, completion: nil)
    }
    
}

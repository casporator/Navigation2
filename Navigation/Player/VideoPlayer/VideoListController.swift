//
//  VideoListController.swift
//  Navigation
//
//  Created by Oleg Popov on 21.11.2022.
//
import YoutubeKit
import Foundation
import UIKit
import AVKit


class VideoListController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    private let videoPlaylist = VideoModel.playlist
    
    private var player: YTSwiftyPlayer!
    
    private let musicButton: UIButton = {
        let button = UIButton()
        button.setTitle("Audio playlist", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        button.backgroundColor = .systemGray2 
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(backToAudio), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    private let videoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Video playlist", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 17)
        button.backgroundColor = .systemCyan
        button.layer.cornerRadius = 12
        button.toAutoLayout()
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Video"
        view.addSubview(musicButton)
        view.addSubview(videoButton)
        setupTableView()
        navBarCustomization()
    }

    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.toAutoLayout()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .systemCyan
        tableView.toAutoLayout()
        
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
    
    @objc func backToAudio() {
        navigationController?.popViewController(animated: false)    
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
        navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "Video Playlist"
    }
}

extension VideoListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoPlaylist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = UITableViewCell(style: .default, reuseIdentifier: "CellID")
        let video = videoPlaylist[indexPath.row]

        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = video.image
        cell.detailTextLabel?.text = video.title
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
        }
    
  
}

extension VideoListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let video = videoPlaylist[indexPath.row]
        let videoID = video.id
        let playerVC = VideoPlayerViewController(videoID: videoID)
        
        navigationController?.present(playerVC, animated: true, completion: nil)
    }
}


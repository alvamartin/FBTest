//
//  FacebookProfileViewController.swift
//  testApp
//
//  Created by Álvaro Martín on 27/01/2017.
//  Copyright © 2017 Álvaro Martín. All rights reserved.
//

import UIKit

class FacebookProfileViewController: UIViewController {

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let tf = UILabel()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailLabel: UILabel = {
        let tf = UILabel()
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(r: 50, g: 50, b: 140)
        button.setTitle("Dismiss", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        
        button.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 200, g: 200, b: 200)
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(closeButton)
        
        setupSubviews()
    
    }

    func setupSubviews() {
        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3)
        
        emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        emailLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        emailLabel.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3)
        
        closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        closeButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor).isActive = true
        closeButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/4).isActive = true
        closeButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3)
        
    }
    
    func dismissVC() {
        self.dismiss(animated: true, completion: nil)
        return
    }
}

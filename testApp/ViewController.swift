//
//  ViewController.swift
//  testApp
//
//  Created by Álvaro Martín on 27/01/2017.
//  Copyright © 2017 Álvaro Martín. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {

    var userName: String?
    var userEmail: String?
    var userProfilePicURL: URL?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)

        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2).isActive = true
        loginButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3)
        
        loginButton.delegate = self
        //loginButton.readPermissions = ["public_profile"]

    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("logged out of fb")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
        if error != nil {
            print (error)
            return
        }

        print("logged in to fb")
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email, picture.type(large)"]).start { (connection, resultAsAny, error) in
            
            if error != nil {
                print ("Failed to start graph request:", error!)
            }
            
            print (resultAsAny!)
            
            let result = resultAsAny as! NSDictionary
            
            if let name = result["name"] as? String {
                self.userName = name
            }
            
            
            if let email = result["email"] as? String  {
                self.userEmail = email
            }
            
            if let picture = result["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary,let picURL = data["url"]as? String
            {
                self.userProfilePicURL = URL (string: picURL)
            }
            
            
           let fbProfile = FacebookProfileViewController()
            
            // cargo la imagen de forma asíncrona
            fbProfile.profileImageView.downloadedFrom(url: self.userProfilePicURL!)
            fbProfile.nameLabel.text = self.userName
            fbProfile.emailLabel.text = self.userEmail
            
            self.present(fbProfile, animated: true, completion: nil)
        }
    }
    
}

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { () -> Void in
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}

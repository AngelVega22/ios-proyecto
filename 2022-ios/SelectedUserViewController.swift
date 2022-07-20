//
//  SelectedUserViewController.swift
//  2022-ios
//
//  Created by user190700 on 7/17/22.
//

import UIKit
import Firebase
import FirebaseStorage

class SelectedUserViewController: UIViewController {
    var uid = ""
    
    @IBOutlet weak var fullNamelbl: UILabel!
    @IBOutlet weak var correolbl: UILabel!
    @IBOutlet weak var infolbl: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        Database.database().reference().child("usuarios").child(uid).observeSingleEvent(of: .value,  with: {
              (snapshot) in
               print("1")
            if (snapshot.value as? [String: AnyObject]) != nil {
                    print("2")
                let nombres = (snapshot.value as! NSDictionary)["nombres"] as! String
                let apellidos = (snapshot.value as! NSDictionary)["apellidos"] as! String
                let correo = (snapshot.value as! NSDictionary)["email"] as! String
                let imageUrl = (snapshot.value as! NSDictionary)["userImageUrl"] as! String
                
                self.fullNamelbl.text = nombres + " " + apellidos
                self.correolbl.text = correo
                self.infolbl.text = "¡Hola! soy " + nombres
                
                self.profileImage.loadImage(URLAddress: imageUrl)
                self.profileImage.layer.cornerRadius = self.profileImage.bounds.height / 2
               }
        }, withCancel: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension UIImageView {
    func loadImage(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                        self?.image = loadedImage
                }
            }
        }
    }
}

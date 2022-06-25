//
//  RegisterViewController.swift
//  2022-ios
//
//  Created by user206629 on 5/21/22.
//
import Foundation
import UIKit
import FirebaseAuth
import Firebase
import FirebaseStorage

class RegisterViewController: UIViewController, UITextFieldDelegate{
    
    
    @IBOutlet weak var viewRegistra: UIImageView!
    
    @IBAction private func tapToCloseKeyboard(_ sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
        }
    
    //MARK Outlets to register user
    @IBOutlet weak var nameTextF: UITextField!
    @IBOutlet weak var lastNameTextF: UITextField!
    @IBOutlet weak var emailTextF: UITextField!
    @IBOutlet weak var passwordTextF: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var imageProfile: UIImageView!
    
    var imagePicker:UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(red:118.0/255.0, green:240.0/255.0, blue:152.0/255.0, alpha: 1.0).cgColor,
            UIColor(red:157.0/255.0, green:128.0/255.0, blue:251.0/255.0, alpha: 1.0).cgColor]
        gradient.frame = btnRegister.bounds
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        btnRegister.layer.insertSublayer(gradient, at: 0)
        btnRegister.layer.cornerRadius = 13
        btnRegister.layer.masksToBounds = true
        btnRegister.layer.cornerRadius = 12.0
        
        btnRegister.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        setRegisterButton(enabled: false)

        
        viewRegistra.layer.shadowColor = UIColor(red:119.0/255.0, green:42.0/255.0, blue:145.0/255.0, alpha: 1.0).cgColor
        viewRegistra.layer.shadowOffset = CGSize(width: 10, height: 10)
        viewRegistra.layer.shadowRadius = 1.7
        viewRegistra.layer.shadowOpacity = 0.45
        
        
        nameTextF.delegate = self
        lastNameTextF.delegate = self
        emailTextF.delegate = self
        passwordTextF.delegate = self

        
        nameTextF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        lastNameTextF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        emailTextF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordTextF.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)

        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        imageProfile.isUserInteractionEnabled = true
        imageProfile.addGestureRecognizer(imageTap)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
    }
    
    @objc func openImagePicker(_ sender:Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let name = nameTextF.text
        let lastname = lastNameTextF.text
        let email = emailTextF.text
        let password = passwordTextF.text
        let formfull = name != nil && name != "" && lastname != nil && lastname != "" && email != nil && email != "" && password != nil && password != ""
        setRegisterButton(enabled: formfull)
    }
    
    
    func setRegisterButton(enabled:Bool) {
        if enabled {
            btnRegister.alpha = 1.0
            btnRegister.isEnabled = true
        } else {
            btnRegister.alpha = 0.5
            btnRegister.isEnabled = false
        }
    }
    
    @objc func handleSignUp() {
        guard let name = nameTextF.text else { return }
        guard let lastname = lastNameTextF.text else { return }
        guard let email = emailTextF.text else { return }
        guard let password = passwordTextF.text else { return }
        guard let image = imageProfile.image else { return }
        
        setRegisterButton(enabled: false)
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("Usuario creado")
                    
                self.uploadProfileImage(image) { url in
                    
                    if url != nil {
                        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                        changeRequest?.displayName = name
                        changeRequest?.displayName = lastname
                        changeRequest?.photoURL = url
                        
                        changeRequest?.commitChanges { error in
                            if error == nil {
                                print("User display name changed!")
                                
                                self.saveProfile(name: name, lastname: lastname, profileImageURL: url!) { success in
                                    if success {
                                        self.dismiss(animated: true, completion: nil)
                                    }
                                }
                                
                            } else {
                                print("Error: \(error!.localizedDescription)")
                            }
                        }
                    } else {
                    }
                }
                
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
    }
    
    
    func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let storageRef = Storage.storage().reference().child("user/\(uid)")

        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }

        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"

        storageRef.putData(imageData, metadata: metaData) { metaData, error in
            if error == nil, metaData != nil {
                storageRef.downloadURL(completion: { (url, error) in print(url ?? 0)
                    if error != nil {
                        completion(nil)
                    } else {
                        completion(url?.absoluteURL)
                    }
                    })
            } else {
                // failed
                completion(nil)
            }
        }
    }
        
    
    
    func saveProfile(name:String,lastname:String,profileImageURL:URL, completion: @escaping ((_ success:Bool)->())) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let databaseRef = Database.database().reference().child("users/profile/\(uid)")
        
        let userObject = [
            "name": name,
            "lastname": lastname,
            "photoURL": profileImageURL.absoluteString
        ] as [String:Any]
        
        databaseRef.setValue(userObject) { error, ref in
            completion(error == nil)
        }
    }
}

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage {
            self.imageProfile.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}

    
    

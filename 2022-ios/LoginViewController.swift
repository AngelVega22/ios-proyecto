//
//  LoginViewController.swift
//  2022-ios
//
//  Created by user206629 on 5/19/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var btnIngresar: UIButton!
    
    @IBOutlet weak var viewIngresa: UIView!
    
    @IBAction private func tapToCloseKeyboard(_ sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        botonIngresar()
        viewShadow()
    }
    
    func botonIngresar() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(red:118.0/255.0, green:240.0/255.0, blue:152.0/255.0, alpha: 1.0).cgColor,
            UIColor(red:157.0/255.0, green:128.0/255.0, blue:251.0/255.0, alpha: 1.0).cgColor]
        gradient.frame = btnIngresar.bounds
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        btnIngresar.layer.insertSublayer(gradient, at: 0)
        btnIngresar.layer.cornerRadius = 13
        btnIngresar.layer.masksToBounds = true
        btnIngresar.layer.cornerRadius = 12.0
    }
    
    func viewShadow() {
        viewIngresa.layer.shadowColor = UIColor(red:119.0/255.0, green:42.0/255.0, blue:145.0/255.0, alpha: 1.0).cgColor
        viewIngresa.layer.shadowOffset = CGSize(width: 10, height: 10)
        viewIngresa.layer.shadowRadius = 1.7
        viewIngresa.layer.shadowOpacity = 0.45
    }
}


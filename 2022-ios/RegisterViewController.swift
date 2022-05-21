//
//  RegisterViewController.swift
//  2022-ios
//
//  Created by user206629 on 5/21/22.
//

import UIKit
class RegisterViewController: UIViewController {
    
    @IBOutlet weak var btnRegistrar: UIButton!
    
    @IBOutlet weak var viewRegistra: UIImageView!
    
    @IBAction private func tapToCloseKeyboard(_ sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        botonRegistrar()
        viewShadow()
    }
    
    func botonRegistrar() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(red:118.0/255.0, green:240.0/255.0, blue:152.0/255.0, alpha: 1.0).cgColor,
            UIColor(red:157.0/255.0, green:128.0/255.0, blue:251.0/255.0, alpha: 1.0).cgColor]
        gradient.frame = btnRegistrar.bounds
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        btnRegistrar.layer.insertSublayer(gradient, at: 0)
        btnRegistrar.layer.cornerRadius = 13
        btnRegistrar.layer.masksToBounds = true
        btnRegistrar.layer.cornerRadius = 12.0
    }
    
    func viewShadow() {
        viewRegistra.layer.shadowColor = UIColor(red:119.0/255.0, green:42.0/255.0, blue:145.0/255.0, alpha: 1.0).cgColor
        viewRegistra.layer.shadowOffset = CGSize(width: 10, height: 10)
        viewRegistra.layer.shadowRadius = 1.7
        viewRegistra.layer.shadowOpacity = 0.45
    }
}

//
//  ConfirmationCodeController.swift
//  2022-ios
//
//  Created by user194451 on 5/20/22.
//

import UIKit

class ConfirmationCodeController : UIViewController {
    
    @IBOutlet weak var btnConfirmar: UIButton!
    @IBAction private func tapToCloseKeyboard(_ sender: UITapGestureRecognizer) {
            self.view.endEditing(true)
        }
    override func viewDidLoad() {
        super.viewDidLoad()
        botonConfirmar()
    }
    func botonConfirmar() {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(red:118.0/255.0, green:240.0/255.0, blue:152.0/255.0, alpha: 1.0).cgColor,
            UIColor(red:157.0/255.0, green:128.0/255.0, blue:251.0/255.0, alpha: 1.0).cgColor]
        gradient.frame = btnConfirmar.bounds
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        btnConfirmar.layer.insertSublayer(gradient, at: 0)
        btnConfirmar.layer.cornerRadius = 13
        btnConfirmar.layer.masksToBounds = true
        btnConfirmar.layer.cornerRadius = 12.0
    }
}

//
//  InsertMailViewController.swift
//  2022-ios
//
//  Created by user206629 on 5/19/22.
//

import UIKit

class InsertMailViewController: UIViewController{
    
    @IBOutlet weak var plainRecupera: UITextField!
    
    @IBAction private func tapToCloseKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func plainRecuperar() {
        plainRecupera.textColor = .white
    }
}

//
//  UsersViewController.swift
//  2022-ios
//
//  Created by user190700 on 7/17/22.
//

import UIKit
import Firebase

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var searchUser: UITextField!
    @IBOutlet weak var tblUsers: UITableView!
    
    var userList = [UserModel]()
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user  = userList[indexPath.row]
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SelectedUserViewController") as? SelectedUserViewController{
            vc.name = user.name!
            vc.lastname = user.lastName!
            vc.email = user.email!
            vc.userImageUrl = user.userImageUrl!

            self.navigationController?.pushViewController(vc, animated: true)
        }
        
     }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return userList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let user: UserModel
        
        user = userList[indexPath.row]
        
        cell.userlbl.text = user.name! + " " + user.lastName!
        cell.profileImage.load(URLAddress: user.userImageUrl!)
        cell.profileImage.layer.cornerRadius = cell.profileImage.bounds.height / 2

        return cell
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refUsers = Database.database().reference().child("usuarios")
        
        refUsers.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                
                self.userList.removeAll()
                
                for users in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let userObject = users.value as? [String: AnyObject]
                    let userName  = userObject?["nombres"]
                    let userLastName  = userObject?["apellidos"]
                    let userImageUrl = userObject?["userImageUrl"]
                    let userEmail = userObject?["email"]
                    
                    let user = UserModel(name: userName as! String?, lastName: userLastName as! String?, userImageUrl: userImageUrl as! String?, email: userEmail as! String?)
                    
                    self.userList.append(user)
                }
                
                self.tblUsers.reloadData()
            }
        })
        
    }
    
}
extension UIImageView {
    func load(URLAddress: String) {
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



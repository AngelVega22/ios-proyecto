//
//  UsersViewController.swift
//  2022-ios
//
//  Created by user190700 on 7/17/22.
//

import UIKit
import Firebase

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tblUsers: UITableView!
    
    var userList = [UserModel]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return userList.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let user: UserModel
        
        user = userList[indexPath.row]
        
        cell.userlbl.text = user.name! + " " + user.lastName!
                
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
                    
                    let user = UserModel(name: userName as! String?, lastName: userLastName as! String?, userImageUrl: userImageUrl as! String?)
                    
                    self.userList.append(user)
                }
                
                self.tblUsers.reloadData()
            }
        })
        
    }
}



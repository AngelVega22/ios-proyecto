//
//  ActiveChatsViewController.swift
//  2022-ios
//
//  Created by user190700 on 7/17/22.
//

import UIKit
import Firebase

class ActiveChatsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var messagesList = [Message]()
    
    @IBOutlet weak var tblMessage: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeMessages()
    }
    
    func observeMessages(){
        let ref = Database.database().reference().child("messages")
        ref.observe(DataEventType.value, with: { (snapshot) in
        
            if snapshot.childrenCount > 0 {
                
                self.messagesList.removeAll()
                
                for messages in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let messageObject = messages.value as? [String: AnyObject]
                    let messageFromId  = messageObject?["fromId"]
                    let messageText  = messageObject?["text"]
                    let messageTime = messageObject?["timestamp"]
                    let mesageToId = messageObject?["toId"]
                    
                    let message = Message(fromId: messageFromId as! String?, text: messageText as! String?, timestamp: messageTime as! NSNumber?, toId: mesageToId as! String?)
                    
                    self.messagesList.append(message)
                }
                
                self.tblMessage.reloadData()
            }
        })
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return messagesList.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMessage", for: indexPath) as! TVCellChat
        let message = messagesList[indexPath.row]
        cell.fullname.text = message.toId
        cell.messagepv.text = message.text
        
        return cell
    }
}

//
//  UserModel.swift
//  2022-ios
//
//  Created by user190700 on 7/18/22.
//

class UserModel {
    
    var name: String?
    var lastName: String?
    var userImageUrl: String?
    
    init(name: String?, lastName: String?, userImageUrl: String?){
        self.name = name
        self.lastName = lastName
        self.userImageUrl = userImageUrl
    }
}

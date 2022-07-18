//
//  UserModel.swift
//  2022-ios
//
//  Created by user190700 on 7/18/22.
//

class UserModel {
    
    var nombres: String?
    var apellidos: String?
    var userImageUrl: String?
    
    init(nombres: String?, apellidos: String?, userImageUrl: String?){
        self.nombres = nombres
        self.apellidos = apellidos
        self.userImageUrl = userImageUrl
    }
}

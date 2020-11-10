//
//  ViewModelAssembly.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/24.
//

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register { HomeViewModel(userService: $0) }
        container.register { (userName: String, accessId: String) in
            try UserViewModel(userName: userName, accessId: accessId, userService: container.resolve())
        }
    }
}

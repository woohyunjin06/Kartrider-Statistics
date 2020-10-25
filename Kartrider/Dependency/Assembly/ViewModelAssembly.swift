//
//  ViewModelAssembly.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/24.
//

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register { HomeViewModel(userService: $0) }
    }
}

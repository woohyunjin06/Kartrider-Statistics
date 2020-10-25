//
//  ServiceAssembly.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/24.
//

class ServiceAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register() { UserServiceImpl(provider: $0) as UserService }
    }
}

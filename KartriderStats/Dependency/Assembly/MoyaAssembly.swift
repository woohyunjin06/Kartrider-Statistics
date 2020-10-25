//
//  MoyaAssembly.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/24.
//

class MoyaAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register { MoyaProvider<Users>() }
    }
}

//
//  CompositionRoot.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/24.
//

import Dip

class DependencyProvider {
    static let shared = DependencyProvider()
    
    let container: DependencyContainer!
    private init() {
        container = DependencyContainer.configure()
    }
}

extension DependencyContainer {
    static func configure() -> DependencyContainer {
        return DependencyContainer { container in
            
            let assember = Assembler().then {
                $0.add(MoyaAssembly())
                $0.add(ServiceAssembly())
                $0.add(ViewModelAssembly())
            }
            assember.assemble(in: container)
        }
    }
}

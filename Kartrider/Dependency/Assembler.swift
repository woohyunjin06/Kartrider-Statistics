//
//  DependencyContainer+Assembler.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/24.
//

import Dip
import Then

class Assembler {
    
    private var assemblies: [Assembly]
    init(_ assemblies: [Assembly] = []) {
        self.assemblies = assemblies
    }
    
    func add(_ assembly: Assembly) {
        assemblies.append(assembly)
    }
    
    func assemble(in container: DependencyContainer) {
        assemblies.forEach { assembly in
            assembly.assemble(container: container)
        }
    }
}

typealias Container = DependencyContainer
protocol Assembly {
    func assemble(container: Container)
}

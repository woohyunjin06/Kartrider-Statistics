//
//  CompositionRoot.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/24.
//

import Dip
import Foundation
import Then

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

class MetadataProvider {
    static let shared = MetadataProvider()
    
    private var metadata: [MetadataType:MetadataStore]!
    private init() {
        self.metadata = MetadataType.allCases.reduce([MetadataType:MetadataStore]()) { (dict, type) in
            var dict = dict
            dict[type] = _metadata(for: type)
            return dict
        }
    }
    
    private func metadata(for type: MetadataType) -> MetadataStore {
        return metadata[type]!
    }
    
    
    func character(id: String) -> String {
        metadata(for: .character).data[id] ?? "알수없음"
    }
    
    func flyingPet(id: String) -> String {
        metadata(for: .flyingPet).data[id] ?? "알수없음"
    }
    
    func gameType(id: String) -> String {
        metadata(for: .gameType).data[id] ?? "알수없음"
    }
    
    func kart(id: String) -> String {
        metadata(for: .kart).data[id] ?? "알수없음"
    }
    
    func pet(id: String) -> String {
        metadata(for: .pet).data[id] ?? "알수없음"
    }
    
    func track(id: String) -> String {
        metadata(for: .track).data[id] ?? "알수없음"
    }
    
    private func _metadata(for type: MetadataType) -> MetadataStore? {
        guard let path = Bundle.main.path(forResource: type.rawValue, ofType: "json") else { return nil }
        if let data = try? String(contentsOfFile: path).data(using: .utf8) {
            if let metadataList = try? JSONDecoder().decode([Metadata].self, from: data) {
                return MetadataStore(metadataList)
            }
        }
        return nil
    }
    
    enum MetadataType: String, CaseIterable {
        case character
        case flyingPet
        case gameType
        case kart
        case pet
        case track
    }
    
    struct MetadataStore {
        
        let data: [String:String]
        init(_ data: [Metadata]) {
            self.data = data.reduce([String:String]()) { (dict, metadata) in
                var dict = dict
                dict[metadata.id] = metadata.name
                return dict
            }
        }
    }
}

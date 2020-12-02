//
//  Encodable+Extension.swift
//  Kartrider
//
//  Created by 현진 on 2020/10/25.
//

import Foundation

extension Encodable {
    var dictionary: [String:Any] {
        guard let data = try? JSONEncoder().encode(self) else { return [:] }
        let dictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        return dictionary ?? [:]
    }
}

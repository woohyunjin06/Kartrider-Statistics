//
//  String+Bool.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//

import Foundation

extension String {
    func toBool() throws -> Bool {
        guard let integer = Int(self) else {
            throw JustError(
                message: "String given cannot be converted to int"
            )
        }
        return integer == 1
    }
}

struct JustError: Error {
    let message: String
    
}

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
            return false
        }
        return integer == 1
    }
}

struct JustError: Error {
    let message: String
    
}

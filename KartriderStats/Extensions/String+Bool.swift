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
            throw UnexpectedError(
                message: "String given cannot be converted to int"
            )
        }
        return integer == 1
    }
}

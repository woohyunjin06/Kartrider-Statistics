//
//  String+Extension.swift
//  Kartrider
//
//  Created by 현진 on 2020/10/25.
//

extension String {
    func asOptional() -> String? {
        if self == "" { return nil }
        return self
    }
}

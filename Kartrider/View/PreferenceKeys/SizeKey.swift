//
//  SizeKey.swift
//  Kartrider
//
//  Created by 현진 on 2020/10/29.
//

import SwiftUI

struct SizeKey: PreferenceKey {
    static func reduce(value: inout CGFloat?, nextValue: () -> CGFloat?) {
        value = nextValue()
    }
}

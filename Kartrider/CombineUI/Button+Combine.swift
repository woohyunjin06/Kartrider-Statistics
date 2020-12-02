//
//  Button+Combine.swift
//  Kartrider
//
//  Created by 현진 on 2020/11/01.
//

import SwiftUI
import Combine

extension Button where Label: View {
    
    public init(_ event: PassthroughSubject<Void, Never>, @ViewBuilder label: () -> Label) {
        self.init(action: {
            event.send(Void())
        }, label: label)
    }
    
    public init<E>(_ event: PassthroughSubject<E, Never>, mapper: @escaping (() -> E), @ViewBuilder label: () -> Label) {
        self.init(action: {
            event.send(mapper())
        }, label: label)
    }
    
}

extension Button where Label == Text {
    public init(_ titleKey: LocalizedStringKey, _ event: PassthroughSubject<Void, Never>) {
        self.init(titleKey) {
            event.send(Void())
        }
    }
    
    public init<E>(_ titleKey: LocalizedStringKey, _ event: PassthroughSubject<E, Never>, mapper: @escaping (() -> E)) {
        self.init(titleKey) {
            event.send(mapper())
        }
    }
    
    public init<S>(_ title: S, _ event: PassthroughSubject<Void, Never>) where S: StringProtocol {
        self.init(title) {
            event.send(Void())
        }
    }
    
    public init<S, E>(_ title: S, _ event: PassthroughSubject<E, Never>, mapper: @escaping (() -> E)) where S: StringProtocol {
        self.init(title) {
            event.send(mapper())
        }
    }
}

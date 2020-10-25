//
//  KartriderApp.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//

import SwiftUI

@main
struct KartriderApp: App {
    
    var body: some Scene {
        WindowGroup {
            HomeContentView(
                viewModel: DependencyProvider.shared.resolve()
            )
        }
    }
}

//
//  HomeViewModel.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/04.
//

import Foundation

import Combine

class HomeViewModel: ObservableObject {
    
    // Inputs
    @Published var nickname: String = ""
    
    // Outputs
    @Published var error: String = ""
    @Published var accessId: String = ""
    @Published var result: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func searchAccessId() {
        userService.accessId(nickname: nickname)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case let .failure(error):
                        self?.error = error.localizedDescription
                        break
                    default:
                        break
                    }
                }, receiveValue: { [weak self] accessId in
                    self?.result = true
                    self?.accessId = accessId
                }
            ).store(in: &cancellables)
    }
    
}

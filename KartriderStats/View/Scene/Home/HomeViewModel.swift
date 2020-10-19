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
    
    private var cancellables = Set<AnyCancellable>()
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
        
//        $nickname
//            .dropFirst()
//            .sink(receiveValue: searchAccessId(nickname:))
//            .store(in: &cancellables)
    }
    
    private func searchAccessId() {
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
                    self?.accessId = accessId
                }
            ).store(in: &cancellables)
    }
    
}

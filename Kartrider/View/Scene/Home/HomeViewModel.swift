//
//  HomeViewModel.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/04.
//

import Combine

class HomeViewModel: ObservableObject {

    // Outputs
    @Published var errorMessage: String = ""
    @Published var errorAlertPresenting: Bool = false
    
    @Published var userName: String = ""
    @Published var accessId: String = ""
    @Published var userDetailPresenting: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    private let userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func searchAccessId(userName: String) {
        userService.accessId(userName: userName)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case let .failure(error):
                        if case let .statusError(code) = error, 400..<500 ~= code {
                            self?.errorMessage = "존재하지 않는 유저입니다."
                        } else {
                            self?.errorMessage = error.localizedDescription
                        }
                        self?.errorAlertPresenting = true
                        break
                    default:
                        break
                    }
                }, receiveValue: { [weak self] accessId in
                    self?.userDetailPresenting = true
                    self?.userName = userName
                    self?.accessId = accessId
                }
            ).store(in: &cancellables)
    }
}

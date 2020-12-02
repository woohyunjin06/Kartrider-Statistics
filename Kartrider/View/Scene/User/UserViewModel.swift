//
//  UserViewModel.swift
//  Kartrider
//
//  Created by 현진 on 2020/10/25.
//

import Combine

class UserViewModel: ObservableObject {
    
    @Published var userName: String?
    @Published var accessId: String?
    
    @Published var error: String = ""
    @Published var matches: [MatchInfo] = []
    
    private var offset: Int = 0
    
    private var cancellables = Set<AnyCancellable>()
    private let userService: UserService
    
    init(
        userName: String,
        accessId: String,
        userService: UserService
    ) {
        self.userName = userName.asOptional()
        self.accessId = accessId.asOptional()
        self.userService = userService
    }
    
    func clear() {
        offset = 0
        matches = []
    }
    
    func fetchMatches() {
        guard let accessId = accessId else { return }
        let request = UserMatchesRequest(offset: offset)
        userService.matches(accessId: accessId, request: request)
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case let .failure(error):
                        self?.error = error.localizedDescription
                        break
                    default:
                        break
                    }
                }, receiveValue: { [weak self] matches in
                    self?.matches.append(contentsOf: matches)
                    self?.offset += matches.count
                }
            ).store(in: &cancellables)
    }
    
}

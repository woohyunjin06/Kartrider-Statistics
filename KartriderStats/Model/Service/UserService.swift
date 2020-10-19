//
//  UserService.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/18.
//

import Combine

protocol UserService {
    func accessId(nickname: String) -> AnyPublisher<String, NetworkError>
    func nickname(accessId: String) -> AnyPublisher<String, NetworkError>
}

class UserServiceImpl: UserService {
    
    let provider: MoyaProvider<Users>
    
    init(provider: MoyaProvider<Users>) {
        self.provider = provider
    }
    
    func accessId(nickname: String) -> AnyPublisher<String, NetworkError> {
        return provider.request(
            .searchAccessId(nickname: nickname),
            type: User.self
        ).map {
            $0.data.accessId
        }.eraseToAnyPublisher()
    }
    
    func nickname(accessId: String) -> AnyPublisher<String, NetworkError> {
        return provider.request(
            .searchNickname(accessId: accessId),
            type: User.self
        ).map {
            $0.data.name
        }.eraseToAnyPublisher()
    }
}

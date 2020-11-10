//
//  UserService.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/18.
//

import Combine

protocol UserService {
    func accessId(userName: String) -> AnyPublisher<String, NetworkError>
    func userName(accessId: String) -> AnyPublisher<String, NetworkError>
    func matches(accessId: String, request: UserMatchesRequest) -> AnyPublisher<[MatchInfo], NetworkError>
}

class UserServiceImpl: UserService {
    
    let provider: MoyaProvider<Users>
    
    init(provider: MoyaProvider<Users>) {
        self.provider = provider
    }
    
    func accessId(userName: String) -> AnyPublisher<String, NetworkError> {
        return provider.request(
            .searchAccessId(userName: userName),
            type: User.self
        ).map {
            $0.data.accessId
        }.eraseToAnyPublisher()
    }
    
    func userName(accessId: String) -> AnyPublisher<String, NetworkError> {
        return provider.request(
            .searchUserName(accessId: accessId),
            type: User.self
        ).map {
            $0.data.name
        }.eraseToAnyPublisher()
    }
    
    func matches(accessId: String, request: UserMatchesRequest) -> AnyPublisher<[MatchInfo], NetworkError> {
        return provider.request(
            .fetchMatches(accessId: accessId, request: request),
            type: MatchesResponse.self
        ).map {
            $0.data.matches
                .flatMap { $0.matches }
                .sorted { $0.startTime > $1.startTime }
        }.eraseToAnyPublisher()
    }
    
}

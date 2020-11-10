//
//  MoyaProvider.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//

import Combine
import Foundation

import CombineMoya
import Moya
import Then

class MoyaProvider<Target>: Moya.MoyaProvider<Target> where Target: TargetType {
    func request<R: Decodable>(_ target: Target, type: R.Type) -> AnyPublisher<Response<R>, NetworkError> {
        super.requestPublisher(target)
            .tryMap { response -> Response<R> in
                guard 200..<300 ~= response.statusCode else {
                    throw NetworkError.statusError(code: response.statusCode)
                }
                
                do {
                    let decoder = JSONDecoder().then {
                        $0.dateDecodingStrategy = .formatted(.dateTime)
                    }
                    let data = try decoder.decode(R.self, from: response.data)
                    return Response(statusCode: response.statusCode, data: data)
                } catch {
                    throw NetworkError.decodeError(message: error.localizedDescription)
                }
            }.mapError { error -> NetworkError in
                if let networkError = error as? NetworkError{
                    return networkError
                } else {
                    return NetworkError.unexpectedError
                }
            }
            .eraseToAnyPublisher()
    }
    
    struct Response<R: Decodable> {
        let statusCode: Int
        let data: R
    }
}
extension Formatter {
    static var dateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter
    }()
}

extension JSONDecoder: Then {}

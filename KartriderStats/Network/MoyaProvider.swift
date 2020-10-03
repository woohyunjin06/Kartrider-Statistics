//
//  MoyaProvider.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//

import Combine
import Foundation

import Moya
import CombineMoya


class MoyaProvider<Target>: Moya.MoyaProvider<Target> where Target: TargetType {
    func request<R: Decodable>(_ target: Target, type: R.Type) -> AnyPublisher<Response<R>, Error> {
        super.requestPublisher(target)
            .tryMap { response -> Response<R> in
                guard 200..<300 ~= response.statusCode else { throw NetworkError.StatusCodeOutOfRange }
                
                do {
                    let data = try JSONDecoder().decode(R.self, from: response.data)
                    return Response(statusCode: response.statusCode, data: data)
                } catch {
                    throw NetworkError.DecodingFail
                }
            }.mapError { error -> Error in
                if let networkError = error as? NetworkError{
                    return networkError
                } else {
                    return NetworkError.Unexpected(message: "알수없는 오류가 발생하였습니다")
                }
            }
            .eraseToAnyPublisher()
    }
    
    struct Response<R: Decodable> {
        let statusCode: Int
        let data: R
    }
}

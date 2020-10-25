//
//  NetworkError.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//

import Foundation

enum NetworkError: Error {
    case statusError(code: Int)
    case decodeError(message: String)
    case unexpectedError
    
}
extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .statusError(code):
            return "\(code): 문제가 발생했습니다.\n개발자에게 문의해주세요."
        case let .decodeError(message):
            return "예상치 못한 문제가 발생했습니다.\n개발자에게 문의해주세요.\n로그: \(message)"
        case .unexpectedError:
            return "예상치 못한 문제가 발생했습니다.\n개발자에게 문의해주세요."
        }
    }
}

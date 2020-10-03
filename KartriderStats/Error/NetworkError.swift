//
//  NetworkError.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//

import Foundation

enum NetworkError: Error {
    case DecodingFail
    case StatusCodeOutOfRange
    case Unexpected(message: String)
}

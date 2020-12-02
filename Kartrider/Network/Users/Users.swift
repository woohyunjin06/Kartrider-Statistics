//
//  Users.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//

import Moya
import Foundation

enum Users {
    case searchAccessId(userName: String)
    case searchUserName(accessId: String)
    case fetchMatches(accessId: String, request: UserMatchesRequest)
}

extension Users: TargetType {
    var baseURL: URL {
        URL(string: "\(Constants.baseURL)/users")!
    }
    
    var path: String {
        switch self {
        case .searchAccessId(let userName):
            return "/nickname/\(userName)"
        case .searchUserName(let accessId):
            return "/\(accessId)"
        case .fetchMatches(let accessId, _):
            return "/\(accessId)/matches"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Task {
        switch self {
        case .fetchMatches(_, let request):
            return .requestParameters(
                parameters: request.dictionary,
                encoding: URLEncoding.default
            )
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        ["Authorization" : Constants.accessToken]
    }
    
}

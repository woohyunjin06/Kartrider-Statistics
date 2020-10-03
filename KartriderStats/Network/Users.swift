//
//  Users.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//

import Moya
import Foundation

enum Users {
    case searchAccessId(nickname: String)
    case searchNickname(accessId: String)
}

extension Users: TargetType {
    var baseURL: URL {
        URL(string: "\(Constants.baseURL)/users")!
    }
    
    var path: String {
        switch self {
        case .searchAccessId(let nickname):
            return "/nickname/\(nickname)"
        case .searchNickname(let accessId):
            return "/\(accessId)"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Task {
        .requestPlain
    }
    
    var headers: [String : String]? {
        ["Authorization" : Constants.accessToken]
    }
    
}

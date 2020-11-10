//
//  Matches.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//

import Moya
import Foundation

enum Matches {
    case searchAccessId(userName: String)
    case searchUserName(accessId: String)
}

//extension Users: TargetType {
//    var baseURL: URL {
//        URL(string: "\(Constants.baseURL)/users")!
//    }
//
//    var path: String {
//        switch self {
//        case .searchAccessId(let userName):
//            return "/nickname/\(userName)"
//        case .searchUserName(let accessId):
//            return "/\(accessId)"
//        }
//    }
//
//    var method: Moya.Method {
//        .get
//    }
//
//    var task: Task {
//        .requestPlain
//    }
//
//    var headers: [String : String]? {
//        ["Authorization" : Constants.accessToken]
//    }
//
//}

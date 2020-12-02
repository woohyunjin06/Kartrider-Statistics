//
//  MatchesResponse.swift
//  Kartrider
//
//  Created by 현진 on 2020/10/26.
//

import Foundation

struct MatchesResponse: Decodable {
    let nickName: String
    let matches: [Match]
}

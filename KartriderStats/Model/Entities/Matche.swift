//
//  Matche.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//

struct Match: Decodable {
    let matchType: String
    let matches: [MatchInfo]
}

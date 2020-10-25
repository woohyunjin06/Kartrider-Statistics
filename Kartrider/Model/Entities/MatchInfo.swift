//
//  MatchInfo.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//

import Foundation

struct MatchInfo: Decodable {
    let accountNo: String
    let matchId: String
    let matchType: String
    let teamId: String
    let character: String
    let startTime: Date
    let endTime: Date
    let channelName: String
    let trackId: String
    let playerCount: Int
    let player: Player
}

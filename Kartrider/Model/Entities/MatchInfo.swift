//
//  MatchInfo.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//

import Foundation
import SwiftUI

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
    
    var rank: Rank {
        if player.matchWin {
            return .Win(playerCount: playerCount)
        } else if player.matchRank == "" {
            return .Retire(playerCount: playerCount)
        } else {
            if Int(player.matchRank)! > 8 {
                return .Retire(playerCount: playerCount)
            }
            return .Rank(rank: Int(player.matchRank)!, playerCount: playerCount)
        }
    }
    
    enum Rank {
        case Win(playerCount: Int)
        case Retire(playerCount: Int)
        case Rank(rank: Int, playerCount: Int)
        
        var title: String {
            switch self {
            case let .Win(playerCount):
                return "Winner of \(playerCount)"
            case .Retire:
                return "Retire"
            case let .Rank(rank, playerCount):
                return "\(rank)/\(playerCount)"
            }
        }
        
        var titleSize: CGFloat {
            switch self {
            case .Win:
                return 12
            case .Retire:
                return 12
            case .Rank:
                return 12
            }
        }
        
        var backgroundColor: Color {
            switch self {
            case .Win:
                return .yellow
            case .Retire:
                return .red
            case .Rank:
                return .blue
            }
        }
    }
    
}

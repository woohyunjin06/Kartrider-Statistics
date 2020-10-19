//
//  Player.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//

struct Player: Decodable {
    let character: String
    let kart: String
    let license: String
    let pet: String
    let flyingPet: String
    let partsEngine: String
    let partsHandle: String
    let partsWheel: String
    let partsKit: String
    let matchRank: String
    let matchWin: Bool
    let matchTime: String
    let matchRetired: Bool
    let rankinggrade2: String
    let characterName: String
    
    private enum CodingKeys: String, CodingKey {
        case character, kart, license, pet, flyingPet,
             partsEngine, partsHandle, partsWheel, partsKit,
             matchRank, matchWin, matchTime, matchRetired,
             rankinggrade2, characterName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.character = try container.decode(String.self, forKey: .character)
        self.kart = try container.decode(String.self, forKey: .kart)
        self.license = try container.decode(String.self, forKey: .license)
        self.pet = try container.decode(String.self, forKey: .pet)
        self.flyingPet = try container.decode(String.self, forKey: .flyingPet)
        self.partsEngine = try container.decode(String.self, forKey: .partsEngine)
        self.partsHandle = try container.decode(String.self, forKey: .partsHandle)
        self.partsWheel = try container.decode(String.self, forKey: .partsWheel)
        self.partsKit = try container.decode(String.self, forKey: .partsKit)
        self.matchRank = try container.decode(String.self, forKey: .matchRank)
        self.matchWin = try container.decode(String.self, forKey: .matchWin).toBool()
        self.matchTime = try container.decode(String.self, forKey: .matchTime)
        self.matchRetired = try container.decode(String.self, forKey: .matchRetired).toBool()
        self.rankinggrade2 = try container.decode(String.self, forKey: .rankinggrade2)
        self.characterName = try container.decode(String.self, forKey: .characterName)
    }
}

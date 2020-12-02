//
//  UserMatchesRequest.swift
//  Kartrider
//
//  Created by 현진 on 2020/10/25.
//

import Foundation

struct UserMatchesRequest: Encodable {
    
    let offset: Int?
    let limit: Int?
    
    let startDate: Date?
    let endDate: Date?
    
    let matchTypes: String?
    
    init(
        offset: Int? = nil,
        limit: Int? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil,
        matchTypes: String? = nil
    ) {
        self.offset = offset
        self.limit = limit
        self.startDate = startDate
        self.endDate = endDate
        self.matchTypes = matchTypes
    }
    
}

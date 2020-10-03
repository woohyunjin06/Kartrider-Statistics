//
//  UnexpectError.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//


struct UnexpectedError: Error {
    
    let message: String
    
    var localizedDescription: String {
        message
    }
}

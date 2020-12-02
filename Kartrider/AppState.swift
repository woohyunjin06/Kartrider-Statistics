//
//  AppState.swift
//  Kartrider
//
//  Created by 현진 on 2020/11/10.
//

import SwiftUI

class AppState: ObservableObject {
    
    private let FavoriteUsersKey = "favoriteUsers"
    private let UserSelfKey = "userName"
    
    @Published private(set) var favoriteUsers: [String]
    @Published var userName: String? {
        didSet {
            if userName == nil {
                UserDefaults.standard.removeObject(forKey: UserSelfKey)
            } else {
                UserDefaults.standard.set(userName, forKey: UserSelfKey)
            }
        }
    }
    
    init() {
        favoriteUsers = UserDefaults.standard.stringArray(forKey: FavoriteUsersKey) ?? []
        userName = UserDefaults.standard.string(forKey: UserSelfKey)
    }
    
    func addFavoriteUser(userName: String?) {
        guard let userName = userName else { return }
        favoriteUsers.append(userName)
        apply()
    }
    
    func removeFavoriteUser(userName: String?) {
        guard let userName = userName else { return }
        favoriteUsers = favoriteUsers.filter { $0 != userName }
        apply()
    }
    
    func isFavoriteUser(userName: String?) -> Bool {
        guard let userName = userName else { return false }
        return favoriteUsers.contains(userName)
    }
    
    fileprivate func apply() {
        UserDefaults.standard.set(favoriteUsers, forKey: FavoriteUsersKey)
    }
    
}

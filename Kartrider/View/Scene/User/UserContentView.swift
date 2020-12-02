//
//  UserContentView.swift
//  Kartrider
//
//  Created by 현진 on 2020/10/25.
//

import SwiftUI

struct UserContentView: View {
    
    @Environment(\.localStatusBarStyle) var statusBarStyle
    @ObservedObject var viewModel: UserViewModel
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                UserProfileView(viewModel: viewModel)
                MatchListView(viewModel: viewModel)
            }
        }.onAppear {
            statusBarStyle.currentStyle = .darkContent
        }.navigationBarTitle("", displayMode: .inline)
        .navigationBarItems(
            trailing: Button(
                action: {
                    if appState.isFavoriteUser(userName: viewModel.userName) {
                        appState.removeFavoriteUser(userName: viewModel.userName)
                    } else {
                        appState.addFavoriteUser(userName: viewModel.userName)
                    }
                },
                label: {
                    if appState.isFavoriteUser(userName: viewModel.userName) {
                        Image(systemName: "star.fill")
                    } else {
                        Image(systemName: "star")
                    }
                }
            )
        )
    }
    
    fileprivate struct UserProfileView: View {
        
        @ObservedObject var viewModel: UserViewModel
        @EnvironmentObject var appState: AppState
        var body: some View {
            HStack(alignment: .top, spacing: 20) {
                if let latestMatch = viewModel.matches.first {
                    ZStack {
                        Image("kart/\(latestMatch.player.kart)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipped()
                        Image("character/\(latestMatch.player.character)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.all, 5)
                            .clipped()
                    }
                }
                VStack(alignment: .leading) {
                    Text(viewModel.userName ?? "유저")
                        .font(.system(size: 20, weight: .bold))
                    Spacer()
                    HStack {
                        Button(action: {
                            viewModel.clear()
                        }) {
                            Text("전적 갱신")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 10)
                        .frame(height: 30)
                        .background(Color.blue)
                        .cornerRadius(15)
                        
                        Button(action: {
                            if appState.userName == viewModel.userName {
                                appState.userName = nil
                            } else {
                                appState.userName = viewModel.userName
                            }
                        }) {
                            if appState.userName == viewModel.userName {
                                Text("내 아이디가 아님")
                                    .font(.system(size: 12))
                                    .foregroundColor(.red)
                            } else {
                                Text("내 아이디로 등록")
                                    .font(.system(size: 12))
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal, 10)
                        .frame(height: 30)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(
                                    appState.userName == viewModel.userName ?
                                        Color.red : Color.blue
                                )
                        )
                    }
                }
//                Spacer()
            }.frame(maxWidth: .infinity, maxHeight: 60)
            .padding([.horizontal, .top], 20)
            
        }
    }
    
    fileprivate struct MatchListView: View {
        
        @ObservedObject var viewModel: UserViewModel
        @State var maxWidth: CGFloat = .zero
        
        var body: some View {
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.matches, id: \.matchId) {
                        MatchListItem(matchInfo: $0, maxWidth: self.$maxWidth)
                    }
                    Text("로딩중 ..")
                        .onAppear {
                            viewModel.fetchMatches()
                        }
                }
            }
        }
    }
    
    fileprivate struct MatchListItem: View {
        
        var matchInfo: MatchInfo
        @Binding var maxWidth: CGFloat
        
        var body: some View {
            HStack {
                Text(matchInfo.rank.title)
                    .foregroundColor(.white)
                    .font(.system(size: matchInfo.rank.titleSize))
                    .padding(.vertical, 20)
                    .frame(width: 80)
                    .background(matchInfo.rank.backgroundColor)
                    .background(GeometryReader {
                        Color.clear.preference(key: SizeKey.self, value: $0.size.width)
                    }.scaledToFill())
                    .onPreferenceChange(SizeKey.self) {
                        self.maxWidth = $0
                    }
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(MetadataProvider.shared.track(id: matchInfo.trackId))
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Text(MetadataProvider.shared.kart(id: matchInfo.player.kart))
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                    }
                    VStack {
                        Spacer()
                        Text(MetadataProvider.shared.track(id: matchInfo.trackId))
                            .font(.system(size: 20))
                        Spacer()
                    }
                }
                Spacer()
            }.frame(maxWidth: .infinity)
            
        }
        
        struct SizeKey: PreferenceKey {
            static var defaultValue: CGFloat = .zero
            
            static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
                let nextValue = nextValue()
                guard nextValue > value else { return }
                value = nextValue
            }
        }

    }
    
}
struct UserContentView_Previews: PreviewProvider {
    static var previews: some View {
        UserContentView(
            viewModel: DependencyProvider.shared.resolve(arguments: "", "")
        )
    }
}

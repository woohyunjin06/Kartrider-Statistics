//
//  HomeContentView.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//

import SwiftUI

struct HomeContentView: View {
    
    @Environment(\.localStatusBarStyle) var statusBarStyle
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    HomeHeaderView()
                        .frame(height: geometry.size.height/5)
                    HomeInputView(viewModel: viewModel)
                        .frame(height: 100)
                    
                    ScrollView {
                        VStack(spacing: 20) {
                            ProfileRow(viewModel: viewModel)
                            FavoriteList(viewModel: viewModel)
                        }.padding(.horizontal, 20)
                    }
                    
                    NavigationLink(
                        "",
                        destination: UserContentView(
                            viewModel: DependencyProvider.shared.resolve(
                                arguments: viewModel.userName, viewModel.accessId
                            )
                        ),
                        isActive: $viewModel.userDetailPresenting
                    ).hidden()
                    
                }.ignoresSafeArea()
            }.onAppear {
                statusBarStyle.currentStyle = .lightContent
            }
            .alert(isPresented: $viewModel.errorAlertPresenting) {
                Alert(
                    title: Text(viewModel.errorMessage),
                    message: nil,
                    dismissButton: .default(Text("확인"))
                )
            }
        }
    }
    
    fileprivate struct HomeHeaderView: View {
        var body: some View {
            Rectangle()
                .foregroundColor(.blue)
        }
    }
    
    fileprivate struct HomeInputView: View {
        
        @ObservedObject var viewModel: HomeViewModel
        @State var userName: String = ""
        
        var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .top) {
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(
                            height: geometry.size.height/2
                        )
                    
                    VStack {
                        Spacer()
                        TextField(
                            "닉네임을 입력해주세요.",
                            text: $userName,
                            onEditingChanged: { _ in
                                
                            },
                            onCommit: {
                                viewModel.searchAccessId(userName: userName)
                            }
                        )
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .textFieldStyle(PlainTextFieldStyle())
                        .frame(
                            height: 50
                        )
                        .background(Color.white)
                        .cornerRadius(12)
                        .shadow(radius: 12)
                            
                        Spacer()
                    }.padding(.horizontal, geometry.size.width/10)
                    
                }
            }
        }
    }
    
    fileprivate struct ProfileRow: View {
        
        @EnvironmentObject var appState: AppState
        @ObservedObject var viewModel: HomeViewModel
        
        var body: some View {
            
            if let userName = appState.userName {
                Text(userName)
                    .foregroundColor(.gray)
                    .padding(.all, 30)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(
                                Color.gray,
                                style: StrokeStyle(lineWidth: 0.7,  dash: [3])
                            )
                    ).onTapGesture {
                        viewModel.searchAccessId(userName: userName)
                    }
            } else {
                Text("본인의 아이디를 등록해 주세요")
                    .foregroundColor(.gray)
                    .padding(.all, 30)
                    .frame(maxWidth: .infinity)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(
                                Color.gray,
                                style: StrokeStyle(lineWidth: 0.7,  dash: [3])
                            )
                    )
            }

        }
    }
    fileprivate struct FavoriteList: View {
        
        @EnvironmentObject var appState: AppState
        @ObservedObject var viewModel: HomeViewModel

        var body: some View {
            LazyVStack(alignment: .leading) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("즐겨찾기")
                        .font(.title2)
                        .foregroundColor(.yellow)
                        .fontWeight(.bold)
                }
                if appState.favoriteUsers.count == 0 {
                    HStack {
                        Spacer()
                        Image(systemName: "exclamationmark.octagon.fill")
                            .foregroundColor(.gray)
                        Text("즐겨찾기 한 유저가 없습니다")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        Spacer()
                    }
                    .padding(.vertical, 30)
                    .frame(maxWidth: .infinity)
                } else {
                    ForEach(appState.favoriteUsers, id: \.self) {
                        FavoriteUserRow(userName: $0, viewModel: viewModel)
                    }
                    .padding(.top, 5)
                }
            }
            
        }
        
        struct FavoriteUserRow: View {
            
            @EnvironmentObject var appState: AppState
            
            let userName: String
            @ObservedObject var viewModel: HomeViewModel
            
            var body: some View {
                HStack {
                    Button(action: {
                        viewModel.searchAccessId(userName: userName)
                    }, label: {
                        HStack {
                            Circle()
                                .foregroundColor(.black)
                                .frame(width: 5, height: 5)
                                .padding(.horizontal, 10)
                            Text(userName)
                                .foregroundColor(.black)
                                .padding(.vertical, 8)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Spacer()
                        }
                    })
                    Button(action: {
                        appState.removeFavoriteUser(userName: userName)
                    }, label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                    })
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView(
            viewModel: DependencyProvider.shared.resolve()
        )
    }
}

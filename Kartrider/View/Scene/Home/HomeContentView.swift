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
                    NavigationLink("", destination: Text("Test"), isActive: $viewModel.result).hidden()
                }.ignoresSafeArea()
            }.onAppear {
                statusBarStyle.currentStyle = .lightContent
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
                            "Input",
                            text: $viewModel.nickname,
                            onEditingChanged: { _ in
                                
                            },
                            onCommit: {
                                viewModel.searchAccessId()
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
}

struct ProfileRow: View {
    var body: some View {
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

struct FavoriteRow: View {

    let items =
        ["1", "2", "3","4", "5", "6", "8", "9", "10", "11", "12", "13"]

    var body: some View {
        LazyVStack(alignment: .leading) {
            Text("즐겨찾기")
                .font(.title)
                .fontWeight(.bold)
            ForEach(items, id: \.self) {
                FavoriteUserRow(userName: $0)
            }
        }
        
    }
}

struct FavoriteUserRow: View {
    
    let userName: String
    
    var body: some View {
        Text(userName)
            .padding([.top, .bottom], 10)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeContentView(
            viewModel: DependencyProvider.shared.resolve()
        )
    }
}

//
//  HomeContentView.swift
//  KartriderStats
//
//  Created by 현진 on 2020/10/03.
//

import SwiftUI

struct HomeContentView: View {
    
//    let detailView = NavigationLink(<#LocalizedStringKey#>, destination: <#_#>)
    @ObservedObject var viewModel: HomeViewModel
    
    @State var nickname: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: -20) {
                GeometryReader { geometry in
                    ZStack(alignment: .top) {
                        VStack {  }
                        .frame(
                            width: geometry.size.width,
                            height: geometry.size.height-25,
                            alignment: .center)
                        .background(Color.blue)
                        .shadow(radius: 10)
                        
                        VStack(spacing: 0) {
                            Spacer()
                            TextField("placeholder_username", text: $nickname, onEditingChanged: { change in
                                
                            }, onCommit: {
                                viewModel.searchAccessId()
                            })
                            .foregroundColor(.black)
                            .frame(
                                height: 50
                            )
                            .multilineTextAlignment(.center)
                            .textFieldStyle(PlainTextFieldStyle())
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(radius: 12)
                        }.padding([.leading, .trailing], 60)
                        
                    }
                }.frame(
                    width: geometry.size.width,
                    height: geometry.size.height/3,
                    alignment: .center
                ).zIndex(1)
                ScrollView {
                    VStack(spacing: 20) {
                        ProfileRow()
                        FavoriteRow()
                    }
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 50)
                }
            }.ignoresSafeArea(.all, edges: .top)
        }.preferredColorScheme(.light)
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

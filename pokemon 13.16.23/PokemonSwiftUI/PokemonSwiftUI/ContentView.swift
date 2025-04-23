//
//  ContentView.swift
//  PokemonSwiftUI
//
//  Created by inoue ayumu on 2025/04/15.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var pokemonViewModel = PostViewModel()
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest private var sessionList: FetchedResults<NSFetchRequestResult>
//       
//    init() {
//        _sessionList = FetchRequest(
//            sortDescriptors: []
//        )
//    }
    
    var body: some View {
        //ナビゲーションの設定
        NavigationStack {
            Text("ポケモン一覧")
            //テキストのサイズを調整
                .frame(width: 400, height: 40)
            //上下左右に間隔を広げ、テキストの余白を調整
                .padding()
            //背景の色
                .background(Color.pink)
            //文字の色
                .foregroundColor(Color.white)
            //文字のサイズ
                .font(Font.headline)
            
            
            //LazyVGrid,LazyHGridを使用してブロックを並べたようなデザイン
            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible())
            ]
            
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        //同じ作業の繰り返し（ポケモンViewのポストポケの順番通りに一番から）
                        ForEach(pokemonViewModel.postPoke.sorted(by: { $0.id < $1.id})) { index in
                            ZStack {
                                NavigationLink(destination: Navigation(postpoke: index)) {
                                    Circle()
                                        .trim(from: 0.5, to: 1.0)
                                        .foregroundColor(Color.color)
                                        .frame(height: 180)
                                }
                                    VStack {
                                       
                                        //ポケモンの番号
                                        Text("No.\(index.id)").foregroundColor(.black)
                                        
                                        if let url = URL(string: index.sprites.frontDefault) {
                                            AsyncImage(url: url) { phase in
                                                switch phase {
                                                case .empty:
                                                    ProgressView()
                                                case .success(let image):
                                                    image
                                                        .resizable()
                                                        .scaledToFit()
                                                        .frame(width: 80, height: 80)
                                                case .failure:
                                                    Image(systemName: "photo")
                                                @unknown default:
                                                    EmptyView()
                                                }
                                            }
                                        }
                                        
                                        
                                        //画像にテキストを重ねる方法
                                        Text("\(index.name)").foregroundColor(.black)
                                    }
                                }
                            }
                            //Circleの外枠の線
                            .overlay(Circle().stroke(Color.black, lineWidth: 1))
                        }
                        .padding(.bottom)
                    
                    }
                    //画面を表示する際に動く
                
                    .onAppear(){
                        pokemonViewModel.fetchPosts()
                        
                    }
                }
            }
        }
}
    
    #Preview {
        ContentView()
    }


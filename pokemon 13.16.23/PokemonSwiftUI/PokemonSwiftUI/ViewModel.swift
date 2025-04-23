//
//  ViewModel.swift
//  PokemonSwiftUI
//
//  Created by inoue ayumu on 2025/04/15.
//

import Foundation
    
    @MainActor
    struct Post: Decodable, Identifiable {
        let id: Int
        let name: String
        let sprites: Sprites
        
        
        struct Sprites: Codable {
            let frontDefault: String
            
            enum CodingKeys: String, CodingKey {
                case frontDefault = "front_default"
            }
        }
    }
    
class PostViewModel: ObservableObject {
    //配列、55行までの処理したものがここに入る
    @Published var postPoke: [Post] = []
    
//    init() {
//          fetchPosts()
//      }
    
    func fetchPosts() {
        //1から151までの情報を繰り返す
        for i in 1...151 {
            guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(i)/")else {
                print("url")
                return
            }
            
            
            
            URLSession.shared.dataTask(with: url) { data,response,error in
                print("data", data)
                print("response",response)
                print("error",error)
                if let data = data {
                    // エラーを対処する
                    do {
                        //JSONデータをswiftの構造体クラスに変更する際に、データ構造を解析し適切な型に変換
                        _ = JSONDecoder()
                        let posts = try JSONDecoder().decode(Post.self, from: data)
                        print("デコードする前の情報\(posts)")
                        DispatchQueue.main.async {
                            //配列に要素を追加して、追加した要素を表示する
                            self.postPoke.append(posts)
                            
                            
                            
                            
                            
                            print("decodedPosts")
                            print("取ってきた中身\(self.postPoke)")
                        }
                        // do内 try の処理でエラーが発生した場合の処理
                    } catch {
                        print("Decode error:", error)
                    }
                } else if let error = error {
                    print("Error:", error)
                }
            }
            
            //一時停止していたアニメーションや処理を再開させるメソッド
            .resume()
        }
    }
}

//
//  ContentView.swift
//  betaTest01
//
//  Created by 森田裕 on 2019/10/07.
//  Copyright © 2019 森田裕. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView{
            //コンテナ
            VStack{
                //コンテナ
                VStack(alignment:.leading){
                    //Listに並べる
                    List{
                        //タイトル
                        navigationBarTitle(Text("会議室リスト"))
                        VStack{
                            //HStack.横の並べる
                            HStack{
                                Text("4人部屋")
                                .font(.headline)
                                Text("会議室")
                                .font(.callout)
                                //ただのスペース
                                Spacer()
                                //お気に入り機能、星の画像をSystenImageから取得
                                Image(systemName: "star.fill")
                                    .imageScale(.medium)
                                    .foregroundColor(.yellow)
                            }
                        }
                        HStack{
                            Text("8人部屋")
                            Text("会議室")
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
    
}


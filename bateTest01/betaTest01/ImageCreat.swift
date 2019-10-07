//
//  ImageCreat.swift
//  betaTest01
//
//  Created by 森田裕 on 2019/10/07.
//  Copyright © 2019 森田裕. All rights reserved.
//

import SwiftUI

struct ImageCreat: View {
    var body: some View {
        //Assetsに入れた画像の挿入
        Image("sax")
            //クリッピング、円形に画像編集(切り取りをしている訳ではなく、円形の枠をはめている)
            .clipShape(Circle())
            //オーバーレイとして、clipShapeにデザイン追加
            .overlay(Circle().stroke(Color.gray,lineWidth: 4))
//            .frame(width: 10, height: 10, alignment: .center)
            //半径15ポイントの影を追加
            .shadow(radius: 15)
    }
}

struct ImageCreat_Previews: PreviewProvider {
    static var previews: some View {
        ImageCreat()
    }
}

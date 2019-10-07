//
//  LandmarkRow.swift
//  betaTest01
//
//  Created by 森田裕 on 2019/10/07.
//  Copyright © 2019 森田裕. All rights reserved.
//

import SwiftUI

struct LandmarkRow: View {
    var landmark:Landmark
    
    var body: some View {
        HStack{
            landmark.image
                .ressizable()
                .frame(width:50,height:50)
            Text(landmark.name)
        }
    }
}

struct LandmarkRow_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkRow(landmark: landmarkData[0])
    }
}

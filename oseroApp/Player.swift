//
//  Player.swift
//  ImageChange
//
//  Created by 森田裕 on 2019/10/08.
//  Copyright © 2019 森田裕. All rights reserved.
//

import Foundation

class Player {

    func play(board: Board, stone: Int) -> (Int,Int) {
        return Random(available: board.available(stone: stone))
    }

    // 打てるところにランダムで打ちます。
    // swift には random.choice()　みたいなものありますか？
    func Random(available: [[Int]]) -> (Int,Int) {
        let int = Int.random(in: 0..<available.count)
        return (available[int][0], available[int][1])
    }
}

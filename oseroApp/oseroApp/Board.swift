//
//  Board.swift
//  oseroApp
//
//  Created by 森田裕 on 2019/10/08.
//  Copyright © 2019 森田裕. All rights reserved.
//

import UIKit

//      オセロの白黒判定
let Judge_Range=[[-1,-1],[0,-1],[1,-1],
                 [-1,0] ,        [1,0],
                 [-1,1], [0,1],  [1,1]]




class Board: UIView{
    var square:[[Int]] = []    //判定用２次元配列
    var blackcnt:Int=0              //白の石の数
    var whitecnt:Int=0              //黒の石の数
    
    var finishfont:Bool = false     //ゲームが終わった時のメッセ
    var allcnt:Int=64               //盤面の空きはどのぐらいか
    
    var BlankCheckList:[[Int]] = []         //次の人が置けるマス目の座標を格納。
    
    
    
//    ---------------------------
//      オセロ盤の初期化(配列に白黒緑の情報を格納)
//    ---------------------------
    func Board_Init(){
        for _ in 0...num{
            var array:[Int]=[]
            for _ in 0...num{
                array+=[0]
            }
            square+=[array]
        }
        
//        黒が連続する場合
//                square[1][1]=2
//                square[1][3]=2
//                square[1][4]=2
//                square[1][6]=2
//
//                square[2][1]=2
//                square[2][2]=2
//                square[2][3]=2
//                square[2][4]=2
//                square[2][5]=2
//                square[2][6]=2
//
//                square[3][1]=2
//                square[3][2]=2
//                square[3][3]=2
//                square[3][4]=2
//                square[3][5]=1
//                square[3][6]=2
//                square[3][7]=2
//                square[3][8]=2
//
//                square[4][1]=2
//                square[4][2]=2
//                square[4][3]=2
//                square[4][4]=2
//                square[4][5]=2
//                square[4][6]=1
//                square[4][7]=2
//
//                square[5][1]=2
//                square[5][2]=2
//                square[5][3]=2
//                square[5][4]=1
//                square[5][5]=1
//                square[5][6]=2
//                square[5][7]=2
//
//                square[6][1]=2
//                square[6][2]=2
//                square[6][3]=2
//                square[6][4]=2
//                square[6][5]=2
//                square[6][6]=2
//                square[6][7]=2
//
//                square[7][1]=2
//                square[7][3]=2
//                square[7][4]=2
//
//                square[8][3]=2

//        二箇所ひっくり返る場合
//        square[4][4]=2
//        square[4][5]=1
//        square[5][4]=1
//        square[5][5]=2
//        square[6][5]=1
//        square[6][6]=2
        
//        三箇所ひっくり返る場合
//        square[3][4]=1
//        square[4][4]=1
//        square[4][5]=2
//        square[4][6]=2
//        square[5][3]=2
//        square[5][4]=2
//        square[5][5]=2
//        square[5][6]=2
//        square[6][5]=1
//        square[6][6]=2
        
//        一番最初の状態生成
        square[4][4]=2
        square[5][5]=2
        square[5][4]=1
        square[4][5]=1

//        番兵
        for i in 0...num{
            square[0][i]=3
            square[9][i]=3
            square[i][0]=3
            square[i][9]=3
        }
        
        Now_Count()
    }
    
    
    
    
    
    
//    ---------------------------
//     石が置かれた時
//    ---------------------------
    func put(mybtn:OSERO,mycolor:Int){
        print("置かれた座標 X\(mybtn.frameX) : Y\(mybtn.frameY)")
//        置いた場所を中心に前後左右斜めの座標をチェック
        for i in 0...7{
            let dx=Judge_Range[i][0]
            let dy=Judge_Range[i][1]
            if(Cnt_Change(mybtn: mybtn, x: dx, y: dy, color: mycolor)>0){
                for i in 0...Cnt_Change(mybtn: mybtn, x: dx, y: dy, color: mycolor){
                    square[mybtn.frameY+i*dy][mybtn.frameX+i*dx]=mycolor
                }
            }
        }
//       フォントの変更
        Now_Count()
    }
    
    
    
    
    
    
    
//    ---------------------------
//    石の色を変更
//    ---------------------------
    func Cnt_Change(mybtn:OSERO,x:Int,y:Int,color:Int)->Int{
        var cx=mybtn.frameX
        var cy=mybtn.frameY
        
        for i in 0...num{
            cx=x+cx
            cy=y+cy
            if(square[cy][cx]==0){  //空白
                return 0
            }
            else if(square[cy][cx]==3){  //範囲外
                return 0
            }
            else if(square[cy][cx]==color){  //範囲内
                return i
            }
        }
        return 0
    }
    
    
    
    
    
    
    
    
//    ---------------------------------------------------------------------
//                        盤面全体の空白チェック
//    ---------------------------------------------------------------------
//    BOARDの8*8を一つずつチェック
    func BlankCheck(mycolor:Int)-> [[Int]]{
        var Blanksquare : [[Int]] = []
        for y in 1..<num{
            for x in 1..<num{
                if(self.Blank(x:x, y:y, mycolor:mycolor)){
                    //現在のmycolorが置ける場所のマス座標が格納される。
                    Blanksquare += [[y,x]]
                }
            }
        }
        return Blanksquare
    }
    
    
    func Blank(x:Int, y:Int, mycolor:Int)->Bool{
//        チェックするマスが白or黒ならばtrue。空白ならばfalse。
        if(square[y][x] != 0){
            return false
        }
//        前後左右斜めの座標をチェック
//        置けるなら、true->Blanksquareへその座標を格納。
        for i in 0..<8{
            let dx=Judge_Range[i][0]
            let dy=Judge_Range[i][1]
            if(self.count_Blank(x:x, y:y, dx:dx, dy:dy, mycolor:mycolor)>0){
                return true
            }
        }
        return false
    }
    
    
    func count_Blank(x:Int, y:Int, dx:Int, dy:Int, mycolor:Int)->Int{
        var _y:Int = y
        var _x:Int = x
        for i in 0..<8{
            _y = _y+dy
            _x = _x+dx
            if(square[_y][_x]==0){  //空白
                return 0
            }
            else if(square[_y][_x]==3){  //範囲外
                return 0
            }
            else if(square[_y][_x]==mycolor){  //範囲内
                return i
            }
        }
        return 0
    }
    
    
    
    
    
    
//    -----------------------ゲッター-------------------------------------
//    黒石の数取得
    func GetBlack()->Int{
        return blackcnt
    }
//    白石の数取得
    func GetWhite()->Int{
        return whitecnt
    }
//    フォント取得
    func GetFinishFont()->Bool{
        return finishfont
    }
//    盤面上の石の状態
    func Return_Color()->[[Int]]{
        return square
    }
//        -----------------------終了-------------------------------------
        
    
    
    
    
    
    
//    ---------------------------
//    現在の盤面上にある石のカウント
//    ---------------------------
    func Now_Count(){
        blackcnt=0
        whitecnt=0
        allcnt=64
        for y in 0...num{
            for x in 0...num{
                if(square[y][x]==1){
                    blackcnt+=1
                }
                else if(square[y][x]==2){
                    whitecnt+=1
                }
            }
        }
        allcnt = allcnt-(blackcnt+whitecnt)
        if(allcnt==0){
            finishfont=true
        }
    }
    
    
    
    

}

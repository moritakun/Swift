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
    
    var font : Int = 0
    var allcnt:Int=64               //盤面の空きはどのぐらいか

    var nowOsero:Bool=false         //falseが黒、trueが白

    var notposition:Int=0                   //石が置けない場合の変数
    var takeposition:Int=0                   //石が置ける場合の変数
    
    
    
    //---------------------------
    //  オセロ盤の初期化(配列に白黒緑の情報を格納)
    //---------------------------
    func Board_Init(){
        for _ in 0...num{
            var array:[Int]=[]
            for _ in 0...num{
                array+=[0]
            }
            square+=[array]
        }
        //一番最初の状態生成
        square[4][4]=2
        square[5][5]=2
        square[5][4]=1
        square[4][5]=1

        //番兵
        for i in 0...num{
            square[0][i]=3
            square[9][i]=3
            square[i][0]=3
            square[i][9]=3
        }
    }
    
    
    
    //---------------------------
    // 石が置かれた時
    //---------------------------
    func put(mybtn:OSERO,mycolor:Int){
        var AuthenticityControl : Int = 0         //true,falseの制御
        notposition=0
        print("置かれた座標X,\(mybtn.frameX):Y,\(mybtn.frameY)")
            //自分を中心とした前後左右斜めに色違いの石があるか
        for i in 0...7{
            let dx=Judge_Range[i][0]
            let dy=Judge_Range[i][1]
            let n=Cnt_Change(mybtn: mybtn, x: dx, y: dy, color: mycolor)
            if(n==0){
                notposition += 1
//              print("そこにはおけない")
            }
            else{
                if(AuthenticityControl == 0){
                    if(!nowOsero){
                        nowOsero=true
                    }
                    else{
                        nowOsero=false
                    }
                }
                AuthenticityControl += 1
                takeposition = 2
//                print("aa:\(AuthenticityControl)")
                for i in 0...n{
                    square[mybtn.frameY+i*dy][mybtn.frameX+i*dx]=mycolor
                }
            }
        }
        //盤面全体の空白テェック
//        BlankCheck(mybtn:mybtn,mycolor:mycolor)
        //フォントの変更
        Now_Count()
    }
    
    
    
    
    //---------------------------
    //石の色を変更
    //---------------------------
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
    
    
    
    //---------------------------------------------------------------------
    //                    盤面全体の空白チェック
    //---------------------------------------------------------------------
    func BlankCheck(mycolor:Int){
        var Blanksquarey : [Int] = []
        var Blanksquarex : [Int] = []
        
        //初期値入力
        for _ in 0...num{
//            var array:[Int]=[]
//            array += [0]
            Blanksquarey += [0]
            Blanksquarex += [0]
        }
        //空白チェック
        for y in 0...num{
            for x in 0...num{
                if(square[y][x] == 0){
                    Blanksquarey[y] = y
                    Blanksquarex[x] = x
        
                    print("Blanksquare y,\(Blanksquarey[y]):x,\(Blanksquarex[x])")
                }
            }
        }
        
        func Blank(x:Int, y:Int, color:Int)->Int{
            for a in 0...7{
                    var dx=Judge_Range[a][0]
                    var dy=Judge_Range[a][1]
                for i in 0...num{
                     dx=x+dx
                     dy=y+dy
                     if(square[dy][dx]==0){  //空白
                         return 0
                     }
                     else if(square[dy][dx]==3){  //範囲外
                         return 0
                     }
                     else if(square[dy][dx]==color){  //範囲内
                         return i
                     }
                 }
            }
            return 0
        }
            
        
        for h in Blanksquarey{
            for i in Blanksquarex{
                let blank = Blank(x: Blanksquarex[i], y: Blanksquarey[h], color:mycolor)
                if(blank != 0){
                    print("おけます。")
                }
                else{
                    print("置けません。")
                }
            }
        }
    }

    //-----------------------ゲッター-------------------------------------
        //石が置けないコメントの取得
        func GetNotPosition()->Int{
            return notposition
        }
        //石が置けるコメントの取得
        func GetTakePosition()->Int{
            return takeposition
        }
        //黒石の数取得
        func GetBlack()->Int{
            return blackcnt
        }
        //白石の数取得
        func GetWhite()->Int{
            return whitecnt
        }
        //フォント取得
        func GetFont()->Int{
            return font
        }
        //現在の白か黒か取得
        func GetNowOsero()->Bool{
            return nowOsero
        }
        //盤面上の石の状態
        func Return_Color()->[[Int]]{
            return square
        }
        
        //-----------------------終了-------------------------------------
        
    
    
    
    //---------------------------
    //現在の盤面上にある石のカウント
    //---------------------------
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
            font=3
        }
    }

}

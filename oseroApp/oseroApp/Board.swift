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
    
    var BlankCheckList:[[Int]] = []         //次の人が置けるマス目の座標を格納。
    
    
    
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
        print("置かれた座標X,\(mybtn.frameX):Y,\(mybtn.frameY)")
            //自分を中心とした前後左右斜めに色違いの石があるか
        for i in 0...7{
            let dx=Judge_Range[i][0]
            let dy=Judge_Range[i][1]
            let n=Cnt_Change(mybtn: mybtn, x: dx, y: dy, color: mycolor)
            if(n==0){
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
                for i in 0...n{
                    square[mybtn.frameY+i*dy][mybtn.frameX+i*dx]=mycolor
                }
            }
        }
        
          //盤面全体の空白チェック
        if(mycolor == 1){
            BlankCheckList = BlankCheck(mycolor:Color.WHITE.rawValue)
        }else if(mycolor == 2){
            BlankCheckList = BlankCheck(mycolor:Color.BLACK.rawValue)
        }
//        print("BlankCheckList全体:\(BlankCheckList)")
//        print("BlankCheckList数値指定:\(BlankCheckList[0][0])")
        
        
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
    //BOARDの8*8を一つずつチェック
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
        //xチェックするマスが白or黒ならばfalse。空白ならば下へ。
        if(square[y][x] != 0){
            return false
        }
        //空白ならば、、周りの確認へ。
        //square8*8を順番に見ていって、mycolorでおける場所があるなら。
        //trueでBlancsquareへ格納する。
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
    
    
    
    //-----------------------ゲッター-------------------------------------
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
    
    //置けないマス目の取得
    func blankchecklist()->[[Int]]{
        return BlankCheckList
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

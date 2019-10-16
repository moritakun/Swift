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




class Board: UIView
{
//    var Enemy=enemy()       //エネミーのcppのクラス持ってくる
    //var cnt:Int=1           //
    var square:[[Int]] = []    //判定用２次元配列
   // var count:Int=1
    var blackcnt:Int=0              //白の石の数
    var whitecnt:Int=0              //黒の石の数
    
    var font:Int=0
    var allcnt:Int=64               //盤面の空きはどのぐらいか
    
    
    var nowOsero:Bool=false         //falseが黒、trueが白

    var a:Int=0
    var b:Int=0
    
    //---------------------------
    //  オセロ盤の初期化
    //---------------------------
    func Board_Init()
    {
        for _ in 0...num
        {
            var array:[Int]=[]
            for _ in 0...num
            {
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
        for i in 0...num
        {
            square[0][i]=3
            square[9][i]=3
            
            square[i][0]=3
            square[i][9]=3
        }
    }
    
    //---------------------------
    // 石が置かれた時
    //---------------------------
    func put(mybtn:OSERO,mycolor:Int)
    {
        a=0
            print("置かれた座標X:\(mybtn.frameX)Y:\(mybtn.frameY)")
           // square[mybtn.frameY][mybtn.frameX]=1
        
            //自分を中心とした前後左右斜めに色違いの石があるか
            for i in 0...7
            {
                let dx=Judge_Range[i][0]
                let dy=Judge_Range[i][1]
                let n=Cnt_Change(mybtn: mybtn, x: dx, y: dy, color: mycolor)
                if(n==0)
                {
                    a += 1
                    print("そこにはおけない")
                    
                }
                
                else
                {
                    for i in 0..<(n+1)
                    {
                        b = 2
                    square[mybtn.frameY+i*dy][mybtn.frameX+i*dx]=mycolor
                    print("更新されるはずのボタン座標X:\(mybtn.frameX+i*dx),Y:\(mybtn.frameY+i*dy),square\(square[mybtn.frameX+i*dx][mybtn.frameY+i*dy])")
                    }
                    //フォントの変更
                       if(!nowOsero)
                       {
                               nowOsero=true
                               font=2
                       }
                       else
                       {
                           nowOsero=false
                           font=1
                       }
                }
            }
        
   
        //count+=1
        Now_Count()
    }
    
    
    //---------------------------
    //現在の盤面上にある石のカウント
    //---------------------------
    func Now_Count()
    {
        blackcnt=0
        whitecnt=0
        allcnt=64
        for y in 0...num
        {
            for x in 0...num
            {
                if(square[y][x]==1)
                {
                     blackcnt+=1
                }
                else if(square[y][x]==2)
                {
                   whitecnt+=1
                }
            }
        }
        allcnt = allcnt-(blackcnt+whitecnt)
        print(allcnt)
        if(allcnt<=0)
        {
            font=3
        }
    }
    
    //-----------------------ゲッター-------------------------------------
    //石が置けないコメントの取得
    func GetA()->Int{
        return a
    }
    
    //石が置けるコメントの取得
    func GetB()->Int{
        return b
    }
    //黒石の数取得
    func GetBlack()->Int
    {
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
    func GetNowOsero()->Bool
    {
        return nowOsero
    }
    
    //盤面上の石の状態
    func Return_Color()->[[Int]]
    {
        return square
    }
    
    //-----------------------終了-------------------------------------
    
    //---------------------------
    //石の色を変更
    //---------------------------
    func Cnt_Change(mybtn:OSERO,x:Int,y:Int,color:Int)->Int
    {
        var cx=mybtn.frameX
        var cy=mybtn.frameY
        
        for i in 0...num{
            cx=x+cx
            cy=y+cy
            if(square[cy][cx]==0)   //空白
            {
               
                return 0
            }
            else if(square[cy][cx]==3)  //範囲外
            {
              
                return 0
            }
            
            else if(square[cy][cx]==color)  //範囲内
            {
                Blockosero()
                
//                print("範囲内:座標\(square)に\(color)がある。")
                return i
            }
            print("i\(i)")
            //Blockosero()
        }
        return 0
    }
    
    
    func Blockosero(){
        print("a\(a)")
        if(a==0){
        print("そこには置けない")
      
        }
    }
    
    //---------------------------
    //デバッグ用
    //---------------------------
    func debug()
    {
       print(square)
    }
}

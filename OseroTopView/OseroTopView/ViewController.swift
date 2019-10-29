//
//  ViewController.swift
//  OseroTopView
//
//  Created by 森田裕 on 2019/10/28.
//  Copyright © 2019 森田裕. All rights reserved.
//

import UIKit

let num:Int=9

//画像用の構造体
var image: [UIImage] = [
    UIImage(named:"osero")!,         //オセロの板画像
    UIImage(named:"black")!,         //黒色オセロ
    UIImage(named:"white")!          //白色オセロ
]

enum Color:Int{
    case BOARD = 0
    case BLACK=1
    case WHITE=2
    case NULL=3
}

//var player_Color:Int = Color(rawValue: 1)!.rawValue
var player_Color:Int = 1

//オセロクラス
class OSERO:UIButton{
    var frameX:Int              //Xの座標
    var frameY:Int              //Yの座標
    var cnt:Int
    init(frameX:Int,frameY :Int,cnt:Int,frame:CGRect){
        self.frameX=frameX
        self.frameY=frameY
        self.cnt=cnt
        super.init(frame:frame)
    }
    required init?(coder aDecoder: NSCoder){
        fatalError("error")
    }
}






class ViewController: UIViewController {

     var button=UIButton()
     var ButtonArray:[UIButton]=[]
     var board = Board()
    var Square:[[Int]] = []
    var labelArray:[UILabel]=[]
     let label=UILabel()
    let label1=UILabel()
     let label2 = UILabel()
    var getblankchecklist:[[Int]]=[]
    
//    画面上に表示するフォント構造体
    let font:[String]=["黒の(_・ω・)_ﾊﾞｧﾝ",      //0
                         "白の(_・ω・)_ﾊﾞｧﾝ"]       //1
    
    let FinishFont:String = "終了|ω･) "

    
    
    
    
    
//    ------------------------------
//              オセロ盤初期化
//    ------------------------------
    func InitImageView(){
        let ScreenW:CGFloat=view.frame.size.width
        let imgWidth:CGFloat = ScreenW/8
        var cnt:Int=0
        for y in 0...num{
            for x in 0...num{
                let posx: CGFloat=CGFloat(50*(x-1))
                let posy: CGFloat=CGFloat(50*(y-1))
                let button : UIButton = OSERO(frameX: x, frameY: y, cnt: cnt, frame: CGRect(x: posx+5, y: posy+175, width: imgWidth, height: imgWidth))
                button.addTarget(self, action: #selector(ViewController.pushed), for: .touchUpInside)
//                resetButtonの表示
                self.view.addSubview(button)
                ButtonArray.append(button)
                ButtonArray[cnt].setImage(image[0],for:.normal)
                cnt+=1
            }
        }
        LabelInit()
        board.Board_Init()
        Draw()
        farstblankchecklist()
    }
    
    
    
    
    
    
    
//      ------------------------
//      画面表示用フォントの初期化
//      -------------------------
    func LabelInit(){
      let ScreenW:CGFloat=view.frame.size.width
      
      label.frame=CGRect(x:0,y:50,width:ScreenW,height:100)
      label.font=UIFont.systemFont(ofSize:50)
      label.textAlignment=NSTextAlignment.center
      label.backgroundColor=UIColor.red
      self.view.addSubview(label)
      labelArray.append(label)
        
      label1.frame=CGRect(x:ScreenW/2,y:600,width:ScreenW/2,height:100)
      label1.font=UIFont.systemFont(ofSize:50)
      label1.textAlignment=NSTextAlignment.center
      label1.backgroundColor=UIColor.blue
      self.view.addSubview(label1)
      labelArray.append(label1)
         
      label2.frame=CGRect(x:0,y:600,width:ScreenW/2,height:100)
      label2.font=UIFont.systemFont(ofSize:50)
      label2.textAlignment=NSTextAlignment.center
      label2.backgroundColor=UIColor.orange
      self.view.addSubview(label2)
      labelArray.append(label2)
       
      for i in labelArray{
          view.addSubview(i)
      }
    }
      
    
    
    
    
    
    
//    -----------------------------------
//             オセロ盤タップ
//    -----------------------------------
    @objc func pushed(mybtn:OSERO){
        if(player_Color == 1){
            //mycolorをtrue&falseで渡したい。未実装
            board.put(mybtn:mybtn,mycolor:Color.BLACK.rawValue)
        }
        else{
            board.put(mybtn:mybtn,mycolor:Color.WHITE.rawValue)
        }
        Draw()
        blankchecklistDraw()
    }

    

    
    
    
    
//    -----------------------------------
//          描画
//    -----------------------------------
    func Draw(){
        let colorJudge=board.Return_Color()
        let getblack=board.GetBlack()
        let getwhite=board.GetWhite()
       
        var cnt=0
        for y in 0...num{
            for x in 0...num{
                if(colorJudge[y][x]==Color.BLACK.rawValue){
                    ButtonArray[cnt].setImage(image[Color.BLACK.rawValue], for: .normal)
                    ButtonArray[cnt].isEnabled=false
                }
                else if(colorJudge[y][x]==Color.WHITE.rawValue){
                    ButtonArray[cnt].setImage(image[Color.WHITE.rawValue], for: .normal)
                    ButtonArray[cnt].isEnabled=false
                }
                else if(colorJudge[y][x]==Color.NULL.rawValue){
//                範囲外判定
                    ButtonArray[cnt].isHidden=true
                }
                else{
                    ButtonArray[cnt].setImage(image[Color.BOARD.rawValue], for: .normal)
                    ButtonArray[cnt].isEnabled = false
                }
                cnt+=1
            }
        }
        
        label1.text="白:\(getwhite)"
        label2.text="黒:\(getblack)"
        view.addSubview(label1)
        view.addSubview(label2)
    }
        
    
    
    
    

    
//    ----------------------------------------------------
//                       blankの描画
//    ----------------------------------------------------
    func blankchecklistDraw(){
        let getfinishfont=board.GetFinishFont()
        
        if(player_Color == 1){  //現在黒
            let WHITEavailablelist = board.BlankCheck(mycolor:Color.WHITE.rawValue)  //白チェック
                
            let WHITEavailablelistEmpty = WHITEavailablelist.isEmpty
            if(WHITEavailablelistEmpty == true){  //要素が無い
                let BLACKavailablelist = board.BlankCheck(mycolor:Color.BLACK.rawValue)  //黒再チェック
                for i in 0..<(BLACKavailablelist.count){
                    let y = BLACKavailablelist[i][0]
                    let x = BLACKavailablelist[i][1]
                    ButtonArray[y*10+x].isEnabled = true
                    player_Color = 1
                }
            }
            else{  //要素有る
                for i in 0..<(WHITEavailablelist.count){
                    let y = WHITEavailablelist[i][0]
                    let x = WHITEavailablelist[i][1]
                    ButtonArray[y*10+x].isEnabled = true
                    player_Color = 2
                }
            }
        }
        else if(player_Color == 2){  //現在白
            let BLACKavailablelist = board.BlankCheck(mycolor:Color.BLACK.rawValue)  //黒チェック
            
            let BLACKavailablelistEmpty = BLACKavailablelist.isEmpty
            if(BLACKavailablelistEmpty == true){  //要素が無い
                let WHITEavailablelist = board.BlankCheck(mycolor:Color.WHITE.rawValue)  //白再チェック
                for i in 0..<(WHITEavailablelist.count){
                    let y = WHITEavailablelist[i][0]
                    let x = WHITEavailablelist[i][1]
                    ButtonArray[y*10+x].isEnabled = true
                    player_Color = 2
                }
            }
            else{  //要素有る
                for i in 0..<(BLACKavailablelist.count){
                    let y = BLACKavailablelist[i][0]
                    let x = BLACKavailablelist[i][1]
                    ButtonArray[y*10+x].isEnabled = true
                    player_Color = 1
                }
            }
        }
        
        if(player_Color == 1){
            label.text=font[0]
        }
        else{
            label.text=font[1]
        }
        
        if(getfinishfont == true){
            label.text = FinishFont
        }
        view.addSubview(label)
    }
    
    
    
    
    
    
    
//    ----------------------------------------------------------------
//               blankchecklistの初期化
//    ----------------------------------------------------------------
    func farstblankchecklist(){
//        let getblack=board.GetBlack()
//        let getwhite=board.GetWhite()
        
        getblankchecklist = board.BlankCheck(mycolor: 1)
        for i in 0..<(getblankchecklist.count){
            let y = getblankchecklist[i][0]
            let x = getblankchecklist[i][1]
            ButtonArray[y*10+x].isEnabled = true
        }
        label.text=font[0]
//        label1.text="白:\(getwhite)"
//        label2.text="黒:\(getblack)"
        view.addSubview(label)
//        view.addSubview(label1)
//        view.addSubview(label2)
        print("\(getblankchecklist)\n")
    }
    
    
    
    
    
    
//        ----------------------------------------------------------------
//                       初めの呼び出し関数
//        ----------------------------------------------------------------
    override func viewDidLoad(){
        super.viewDidLoad()
        InitImageView()
    }
    
    
    
    
    
}

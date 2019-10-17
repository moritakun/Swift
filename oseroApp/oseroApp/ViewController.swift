//
//  ViewController.swift
//  oseroApp
//
//  Created by 森田裕 on 2019/10/08.
//  Copyright © 2019 森田裕. All rights reserved.
//

import UIKit

let num:Int=9

var cnt:Int=0
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

//オセロクラス
class OSERO:UIButton{
    var frameX:Int              //Xの座標
    var frameY:Int              //Yの座標
    var cnt:Int
    
    
    init(frameX:Int,frameY :Int,cnt:Int,frame:CGRect)
    {
        self.frameX=frameX
        self.frameY=frameY
        self.cnt=cnt
        super.init(frame:frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("error")
    }
}


class ViewController: UIViewController {
    
     var button=UIButton()
     var ButtonArray:[UIButton]=[]
     var imagecnt=0                 //何番目の画像を描画するか
     var board = Board()
    var Square:[[Int]] = []
    var labelArray:[UILabel]=[]
     let label=UILabel()
    let label1=UILabel()
     let label2 = UILabel()
    let label3 = UILabel()
    
    //画面上に表示するフォント構造体
    let font:[String]=["オセロスタート",           //0
                         "黒の(_・ω・)_ﾊﾞｧﾝ",      //1
                         "白の(_・ω・)_ﾊﾞｧﾝ",       //2
                         "終了|ω･) "]             //3
      
    
    //置けるか置けないかのコメント構造体
    let judgefont:String="置けません"
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        InitImageView()
        // Do any additional setup after loading the view.
    }

    
    //------------------------------
    //          オセロ盤初期化
    //------------------------------
    func InitImageView()
    {
        let ScreenW:CGFloat=view.frame.size.width
        let imgWidth:CGFloat = ScreenW/8
        var cnt:Int=0
        for y in 0...num
        {
            for x in 0...num
            {
                let posx: CGFloat=CGFloat(50*(x-1))
                let posy: CGFloat=CGFloat(50*(y-1))
                let button : UIButton = OSERO(frameX: x, frameY: y, cnt: cnt, frame: CGRect(x: posx+5, y: posy+175, width: imgWidth, height: imgWidth))
                button.addTarget(self, action: #selector(ViewController.pushed), for: .touchUpInside)
                //resetButtonの表示
                self.view.addSubview(button)
                ButtonArray.append(button)
                ButtonArray[cnt].setImage(image[imagecnt],for:.normal)
                cnt+=1
            }
            
        }
        LabelInit()
        board.Board_Init()
        Draw()
    }
    
    //------------------------
    //画面表示用フォントの初期化
    //-------------------------
  func LabelInit()
  {
    var _:Int=0
    
       
        let ScreenW:CGFloat=view.frame.size.width
    
       
        label.frame=CGRect(x:0,y:50,width:ScreenW,height:100)
        label.font=UIFont.systemFont(ofSize:50)
        label.textAlignment=NSTextAlignment.center
        label.backgroundColor=UIColor.red
        self.view.addSubview(label)
        labelArray.append(label)
        print(labelArray)
    
     
      
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
    
    label3.frame=CGRect(x: 0, y: 750, width: ScreenW, height: 100)
    label3.font=UIFont.systemFont(ofSize: 50)
    label3.textAlignment=NSTextAlignment.center
    label3.backgroundColor=UIColor.gray
    self.view.addSubview(label3)
    labelArray.append(label3)
        
        for i in labelArray
        {
            view.addSubview(i)
        }
    }
    
    
    //-----------------------------------
    //         オセロ盤タップ
    //-----------------------------------
    @objc func pushed(mybtn:OSERO)
    {
        let judge:Bool=board.GetNowOsero()
        
        if(!judge)
        {
              board.put(mybtn:mybtn,mycolor:Color.BLACK.rawValue)
            
        }
        else
        {
              board.put(mybtn:mybtn,mycolor:Color.WHITE.rawValue)
        }
      
        Draw()
        judgeposition()
        cnt+=1
    }

    
    //-----------------------------------
    //      描画
    //-----------------------------------
    func Draw()
    {
        let colorJudge=board.Return_Color()
        let get=board.GetBlack()
        let getwhite=board.GetWhite()
        let getfont=board.GetFont()
        var cnt=0
        for y in 0...num
        {
            for x in 0...num
            {
                if(colorJudge[y][x]==Color.BLACK.rawValue)
                {
                    ButtonArray[cnt].setImage(image[Color.BLACK.rawValue], for: .normal)
                    ButtonArray[cnt].isEnabled=false
                }
                else if(colorJudge[y][x]==Color.WHITE.rawValue)
                {
                    ButtonArray[cnt].setImage(image[Color.WHITE.rawValue], for: .normal)
                    ButtonArray[cnt].isEnabled=false
                }
                else if(colorJudge[y][x]==Color.NULL.rawValue)
                {
                    //範囲外判定

                    ButtonArray[cnt].isHidden=true
                    
                }
                else
                {
                     ButtonArray[cnt].setImage(image[Color.BOARD.rawValue], for: .normal)
                      
                }
                cnt+=1
            }
        }
        
         label.text=font[getfont]
        label1.text="白:\(getwhite)"
         label2.text="黒:\(get)"
        for i in labelArray
        {
            view.addSubview(i)
        }
    }
    
    func judgeposition(){
        let A=board.GetA()
//        print("A:\(A)")
        let B=board.GetB()
//        print("B:\(B)")
        print("\n\n\n")
        if(A==8){
            label3.isHidden = false
            label3.text=judgefont
        }else if(A<8 && B==2){
            //label3を隠す。
        }
    }
}

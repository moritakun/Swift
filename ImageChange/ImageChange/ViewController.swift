//
//  ViewController.swift
//  ImageChange
//
//  Created by 森田裕 on 2019/10/04.
//  Copyright © 2019 森田裕. All rights reserved.
//

import UIKit
class ViewController: UIViewController {

    
    //UIImageコンテナ
    let image : [UIImage] = [
        UIImage(named: "board")!,
        UIImage(named: "black")!,
        UIImage(named: "white")!
    ]
    var imagecount : Int = 0


    class buttonclass:UIButton{
        var x : Int
        var y : Int
        var judge : Int
        var count : Int
        init( x:Int, y:Int, judge:Int, count:Int, frame: CGRect ) {
            self.x = x
            self.y = y
            self.judge = judge
            self.count = count
            super.init(frame:frame)
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }


    // UIButton のインスタンスを生成
    var button = UIButton()

    //btnを行配列にして表示
    var ButtonArray : [UIButton] = []
    
    // BOARDSIZE　で　ボードのサイズを変更できます。
    let BOARDSIZE = 8
    
    //reset,passButton
    var resetButton = UIButton()
    var passButton = UIButton()
    //StoneCount,muchCountLabel
    var viewStoneCount = UILabel()
    var muchCount = UILabel()
    

    //初期の盤配置
    func defoult(){
        let ScreeenW:CGFloat = view.frame.size.width
        let imagewidth:CGFloat = ScreeenW/8
        var count : Int = 0
                    
        for y in 1...8{
            for x in 1...8{
                imagecount = 0
                //btnサイズ、配列表示開始位置
                let pox: CGFloat=CGFloat(52*(x-1))
                let poy: CGFloat=CGFloat(52*(y-1))
                let button : UIButton = buttonclass(x: x, y: y, judge: imagecount, count: count, frame: CGRect(x: pox, y: poy+150, width: imagewidth, height: imagewidth))
                //盤のbtn付与
                button.addTarget(self, action: #selector(ViewController.push), for: .touchUpInside)
                            
                //resetButtonの表示
                resetButton.frame = CGRect(x: 125, y: 575, width: 125, height: 45)
                resetButton.addTarget(self, action: #selector(ViewController.resetpush), for: .touchUpInside)
//                resetButton.isEnabled = true
                //resetButtonの表示非表示
//                resetButton.isHidden = true
                resetButton.setTitle("RESET", for: .normal)
                resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
                resetButton.setTitleColor(.white, for: .normal)
                resetButton.backgroundColor = UIColor(red: 0.3, green: 0.7, blue: 0.6, alpha: 1)
                resetButton.layer.cornerRadius = 25
                resetButton.layer.shadowOpacity = 0.5
                resetButton.layer.shadowOffset = CGSize(width: 2, height: 2)
                self.view.addSubview(resetButton)

                self.view.addSubview(button)
                ButtonArray.append(button)
                if(x==5&&y==5 || x==4&&y==4){
                    imagecount = 1
                    button.isEnabled = false
                }
                if(x==4&&y==5 || x==5&&y==4){
                    imagecount = 2
                    button.isEnabled = false
                }
                ButtonArray[count].setImage(image[imagecount],for:.normal)
                count += 1
            }
        }
    }


    
    //btnを押されたときの石があるかないか
    @objc func push(btnpush:buttonclass){
        if(btnpush.judge == 0){
            btnpush.isEnabled = false
            imagecount = 1
            ButtonArray[btnpush.count].setImage(image[imagecount], for: .normal)
            self.view.addSubview(button)
        print("たっぷ")
        print(btnpush.isEnabled)
        }
    }
    
    //リセットbtn
    @objc func resetpush(resetOle:buttonclass){
        viewDidLoad()
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.defoult()
    }
    
}

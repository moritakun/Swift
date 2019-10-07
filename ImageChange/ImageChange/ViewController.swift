//
//  ViewController.swift
//  ImageChange
//
//  Created by 森田裕 on 2019/10/04.
//  Copyright © 2019 森田裕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let boardimage = UIImage(named: "board")!
    let blackimage = UIImage(named: "black")!
    let whiteimage = UIImage(named: "white")!
    
    // 画面の横幅を取得
      var screenWidth:CGFloat = 0
      var screenHeight:CGFloat = 0
    
    // UIButton のインスタンスを生成
       let button = UIButton()
    
      var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 画面の横幅を取得
          screenWidth = view.frame.size.width
          screenHeight = view.frame.size.height
        
        // Buttonが画面の中央で横幅いっぱいのサイズになるように設定
           button.frame = CGRect(x:0, y:screenHeight/2-screenWidth/2,width:screenWidth, height:screenWidth)
        
        // 画像を設定
        button.setImage(boardimage, for: .normal)
        
        // Aspect Fit
        button.imageView?.contentMode = .scaleAspectFit
        // Horizontal 拡大
        button.contentHorizontalAlignment = .fill
        // Vertical 拡大
        button.contentVerticalAlignment = .fill
        
        // ViewにButtonを追加
        self.view.addSubview(button)
        
        // タップされたときのactionをセット
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.buttonTapped(_:))))
        
        // 背景色を設定
           self.view.backgroundColor = UIColor(displayP3Red: 0.937,
                                               green: 0.894, blue: 1.0, alpha: 1.0)
        
        
        
        
        
        
        
        var numbers = [1, 2, 3, 4, 5]
        let numbersCopy = numbers
        numbers[0] = 100
        print(numbers)
        // Prints "[100, 2, 3, 4, 5]"
        print(numbersCopy)
        // Prints "[1, 2, 3, 4, 5]"
        print(numbers[0])
        // print "[100]"
        let board = [0, 1, 2, 3, 4, 5, 6, 7]
        print(board)
        
        
        
        
        
        
        
        //UIImageコンテナ
//        let image : [UIImage] = [
//            UIImage(named: "board")!,
//            UIImage(named: "black")!
//        ]
        //コンテナからの画像を変数にin
//        let imageview = UIImageView(image: image[0])
//        let revView = UIImageView(image: image[1])
//
//        imageview.isUserInteractionEnabled = true
//        let imagesize : CGRect = CGRect(x: 0, y: 150, width: 200, height: 200)
//
////        imageview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.imageViewTapped(_:))))
//        self.view.addSubview(imageview)
//        imageview.frame = imagesize
//
//        let revsize : CGRect = CGRect(x: 0, y: 150, width: 200, height: 200)
//        revView.frame = revsize
////        let reverseView: UIImageView = UIImageView(frame:  CGRect(x: 100, y: 360, width: 80, height: 80))
////        revView.image = UIImage(named: "black")
//        view.addSubview(imageview)
////        view.addSubview(revView)
//
//
    
    
    }
    
    // 画像がタップされたら呼ばれる
    @objc func buttonTapped(_ sender: AnyObject) {
        count += 1
         
         if(count%3 == 0){
             button.setImage(boardimage, for: .normal)
         }
         else if(count%3 == 1){
             button.setImage(blackimage, for: .normal)
         }
         else if(count%3 == 2){
             button.setImage(whiteimage, for: .normal)
         }
         else{
         }
                //UIImageコンテナ
//                let image : [UIImage] = [
//                    UIImage(named: "board")!,
//                    UIImage(named: "black")!,
//                    UIImage(named: "white")!
//                ]
//                //コンテナからの画像を変数にin
//                let boardview = UIImageView(image: image[0])
//                let blackview = UIImageView(image: image[1])
//                let whiteview = UIImageView(image: image[0])
//
////                imageview.isUserInteractionEnabled = true
//                let boardsize : CGRect = CGRect(x: 0, y: 150, width: 200, height: 200)
////                imageview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.imageViewTapped(_:))))
////                self.view.addSubview(imageview)
//                boardview.frame = boardsize
//
//                let blacksize : CGRect = CGRect(x: 0, y: 150, width: 200, height: 200)
//                blackview.frame = blacksize
//        //        let reverseView: UIImageView = UIImageView(frame:  CGRect(x: 100, y: 360, width: 80, height: 80))
//        //        revView.image = UIImage(named: "black")
//                let whitesize : CGRect = CGRect(x: 0, y: 150, width: 200, height: 200)
//                whiteview.frame = whitesize
////                view.addSubview(imageview)
//                view.addSubview(blackview)
        
    print("タップ")
        
    }
}


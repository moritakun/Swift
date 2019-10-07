//
//  ViewController.swift
//  ImageChange
//
//  Created by 森田裕 on 2019/10/04.
//  Copyright © 2019 森田裕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var numbers = [1, 2, 3, 4, 5]
        let numbersCopy = numbers
        numbers[0] = 100
        print(numbers)
        // Prints "[100, 2, 3, 4, 5]"
        print(numbersCopy)
        // Prints "[1, 2, 3, 4, 5]"
        print(numbers[0])
        // print "[100]"
        
        
        //UIImageコンテナ
        let image : [UIImage] = [
            UIImage(named: "board")!,
            UIImage(named: "black")!
        ]
        //コンテナからの画像を変数にin
        let imageview = UIImageView(image: image[0])
        let revView = UIImageView(image: image[1])
        let imagesize : CGRect = CGRect(x: 0, y: 150, width: 200, height: 200)
        imageview.frame = imagesize
        
        let revsize : CGRect = CGRect(x: 0, y: 150, width: 200, height: 200)
        revView.frame = revsize
//        let reverseView: UIImageView = UIImageView(frame:  CGRect(x: 100, y: 360, width: 80, height: 80))
//        revView.image = UIImage(named: "black")
        view.addSubview(imageview)
        view.addSubview(revView)
        



        let board = [0, 1, 2, 3, 4, 5, 6, 7]
        print(board)
        
        
        
        
        
        
        
        
        //構造体定義
        struct Article {
          //ストアドプロパティ定義（初期値なし）
          let id: Int
          let title: String
          let body: String

          //initを使用することでイニシャライザ定義
          init(id: Int, title: String, body: String) {
            self.id = id
            self.title = title
            self.body = body
          }

            func printBody() {
            print(body)
          }
        }

        //インスタンス化時に引数に値を置くことで、イニシャライザで初期値を与える
       // let article = Article(id: 1, title: "title", body: "body")

        //実行結果
        //body
    }

    
    
    
    

}


//
//  ViewController.swift
//  Changeimage02
//
//  Created by 森田裕 on 2019/10/02.
//  Copyright © 2019 森田裕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var label : UILabel!
    @IBOutlet var button : UIButton!
    @IBOutlet var countNum: UILabel!
    @IBOutlet weak var nextBtn: UIButton!

    
    var count = 0
    
    
    
    //親呼び出し
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "test"
        button.setTitle("Button", for:UIControl.State.normal)
    }

    
    @IBAction func ButtonClick(sender:Any){
        count += 1
        countNum.text = String(count)
          if count%2 == 0 {
              label.text = "偶数クリック"
          }else{
              label.text = "奇数クリック"
        }
        
        //ボタンクリックで画面遷移
         func NextBtn(_ sender: Any) {
//             super.viewDidLoad()
         }
    }

    
}


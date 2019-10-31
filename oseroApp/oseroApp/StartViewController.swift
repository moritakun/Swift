//
//  StartViewController.swift
//  oseroApp
//
//  Created by 森田裕 on 2019/10/29.
//  Copyright © 2019 森田裕. All rights reserved.
//

import UIKit
 
class StartViewController: UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
        let titlelabel = UILabel(frame: CGRect(x: 0, y: 200, width: 414, height: 100))
        titlelabel.text="リバーシ"
        titlelabel.backgroundColor=UIColor.darkGray
        titlelabel.textAlignment=NSTextAlignment.center
        titlelabel.font=UIFont.systemFont(ofSize: 60)
        titlelabel.textColor=UIColor.white
        self.view.addSubview(titlelabel)
        
        let nextButton = UIButton(frame: CGRect(x:100,y:500,width: 200,height:100))
        nextButton.setTitle("START!", for: .normal)
        nextButton.backgroundColor = UIColor.green
        
        nextButton.addTarget(self, action: #selector(StartViewController.goNext(_:)), for: .touchUpInside)
        view.addSubview(nextButton)
    }
    
    @objc func goNext(_ sender: UIButton) {
        let nextvc = ViewController()
        nextvc.view.backgroundColor = UIColor.white
        self.present(nextvc, animated: true, completion: nil)
    }
    
    
    
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
     }
    
}

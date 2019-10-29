//
//  AppDelegate.swift
//  OseroTopView
//
//  Created by 森田裕 on 2019/10/28.
//  Copyright © 2019 森田裕. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.(アプリケーション起動後のカスタマイズのオーバーライドポイント。)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        //Called when a new scene session is being created.(新しいシーンセッションが作成されるときに呼び出されます。)
        //Use this method to select a configuration to create the new scene with.(このメソッドを使用して、新しいシーンを作成する構成を選択します。)
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.(ユーザーがシーンセッションを破棄するときに呼び出されます。)
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.(アプリケーションが実行されていない間にセッションが破棄された場合、これはapplication：didFinishLaunchingWithOptionsの直後に呼び出されます。)
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.(このメソッドを使用して、破棄されたシーンに固有のリソースを解放します。これらのリソースは戻らないためです。)
    }


}


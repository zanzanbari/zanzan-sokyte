//
//  AppDelegate.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/01/29.
//

import UIKit

import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

import NaverThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // MARK: - 카카오 로그인
        // FIXME: - key값을 명시적으로 입력하지 않고 로그인 가능하도록
        KakaoSDK.initSDK(appKey: "NATIVE_APP_KEY")
        
        let naverThirdPartyLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
        // 네이버 앱으로 인증하는 방식을 활성화하려면 앱 델리게이트에 다음 코드를 추가합니다.
        naverThirdPartyLoginInstance?.isNaverAppOauthEnable = true
        // SafariViewContoller에서 인증하는 방식을 활성화하려면 앱 델리게이트에 다음 코드를 추가합니다.
        naverThirdPartyLoginInstance?.isInAppOauthEnable = true
        
        // 인증 화면을 아이폰의 세로모드에서만 적용
        naverThirdPartyLoginInstance?.isOnlyPortraitSupportedInIphone()
        
        naverThirdPartyLoginInstance?.serviceUrlScheme = kServiceAppUrlScheme // 앱을 등록할 때 입력한 URL Scheme
        naverThirdPartyLoginInstance?.consumerKey = kConsumerKey // 상수 - client id
        naverThirdPartyLoginInstance?.consumerSecret = kConsumerSecret // pw
        naverThirdPartyLoginInstance?.appName = (Bundle.main.infoDictionary?[kCFBundleNameKey as String] as? String) ?? ""
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        // 세로방향 고정
        return UIInterfaceOrientationMask.portrait
    }
}


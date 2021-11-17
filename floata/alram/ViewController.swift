//
//  ViewController.swift
//  floting
//
//  Created by 홍태희 on 2021/10/25.
//
//  로컬 푸시 구현창

import UIKit
import UserNotifications

class ViewController: UIViewController {
    
    //싱글톤 객체 활용
    let waterNotificationCenter = UNUserNotificationCenter.current() //추가
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestNotificationAuthorization()
        waterNotificationCenter.delegate = self
    }

    //유저에게 알림권한요청
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        waterNotificationCenter.requestAuthorization(options: authOptions) { [weak self] success, error in
            if success {
                self?.sendNotification(seconds: 5) //5초 후 알림
            } else {
                print("알림허용 요청오류 : \(error?.localizedDescription ?? "nill")")
            }
        }
    }
    
    //유저에게 알림보내기
    func sendNotification(seconds: Double) {
        let notiContent = UNMutableNotificationContent()

        notiContent.title = "알림"
        notiContent.body = "똑똑! 식물에게 물을 줄 시간이에요 :)"

        //전달받은 시간 이후에 알림이 전달되도록 구현 (트리거)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notiContent,
                                            trigger: trigger)

        waterNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}

extension ViewController: UNUserNotificationCenterDelegate {
    
    //사용자가 알림 배너를 터치하였을때
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //처리방식지정
        completionHandler([.banner, .list, .sound, .badge])
    }
}

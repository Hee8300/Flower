//
//  InternetViewController.swift
//  floting
//
//  Created by 홍태희 on 2021/10/25.
//

import UIKit
import Reachability

class InternetViewController: UIViewController {

    let myStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

    //declare this property where it won't go out of scope relative to your listener
    let reachability = try! Reachability()

    //여기서 화면 하나 낭비안하고 그냥 연결이 안됐을때만 구현해도 되려나?
    override func viewDidLoad() {
        super.viewDidLoad()

        //인터넷 연결 O
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")

                //와이파이 연결시 메인화면으로
                let mainB = self.myStoryboard.instantiateViewController(identifier: "MainBar")

                mainB.modalPresentationStyle = .fullScreen
                self.present(mainB, animated: true, completion: nil)

            } else {
                print("Reachable via Cellular")

                //셀룰러 연결시 메인화면으로
                let mainB = self.myStoryboard.instantiateViewController(identifier: "MainBar")

                mainB.modalPresentationStyle = .fullScreen
                self.present(mainB, animated: true, completion: nil)
            }
        }
        //인터넷 연결 X
        reachability.whenUnreachable = { _ in
            print("Not reachable")

            let alert = UIAlertController(title: "Error", message: "와이파이 연결을 확인하세요", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel) { (action) in

                //(강제)종료
                exit(0)
            }

            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }



}

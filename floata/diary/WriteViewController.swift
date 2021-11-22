//
//  WriteViewController.swift
//  floata
//
//  Created by 홍태희 on 2021/11/22.
//

import UIKit

class WriteViewController: UIViewController {

    //편집모드 ( DiaryVC에 있는 수정 버튼 )
    var editTarget : Writer?
    //편집 이전의 메모내용 저장
    var originalMemoContent : String?
    
    @IBAction func memoCancelBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func memoSaveBtn(_ sender: Any) {
        
        //아무런 글자도 적혀있지 않을 때
        guard let memo = writeTextView.text, memo.count > 0 else {
            alert(message: "메모를 입력하세요")
            
            return
        }
        
        //수정모드인 경우
        if let target = editTarget {
            //텍스트뷰에 입력된 값으로 메모를 변경
            target.pages = memo
            //saveContext 메소드 호출
            DataManager.shared.saveContext()
            
            NotificationCenter.default.post(name: WriteViewController.memoDidChange, object: nil)
        } else {
            //쓰기모드라면
            DataManager.shared.addNewMemo(memo)
            
            //앱을 구성하는 모든 객체로 전달 (Notification)
            NotificationCenter.default.post(name: WriteViewController.newMemoDidInsert, object: nil)
        }
        
        //새로 만든 창 닫기
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var writeTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //초기화 코드 구현
        if let memo = editTarget {
             //전달된 메모존재
            navigationItem.title = "메모 편집"
            writeTextView.text = memo.pages
            
            originalMemoContent = memo.pages
        } else {
            //없을시
            navigationItem.title = "새 메모"
            writeTextView.text = ""
        }
        
        writeTextView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.presentationController?.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.presentationController?.delegate = nil
    }
}

//경고창 함수
extension WriteViewController {
    
    func alert(title : String = "알림", message : String) {
        //preferredStyle : 경고문 팝업 스타일
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        //handler : 버튼을 탭했을 때 실행될 코드설정
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        
        //경고창 화면에 표시
        present(alert, animated: true, completion: nil)
    }
}

extension WriteViewController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        //원본과 다른지 비교
        if let original = originalMemoContent, let edited = textView.text {
            if #available(iOS 13.0, *) {
                isModalInPresentation = original != edited
            } else {
                // Fallback on earlier versions
            }
        }
    }
}

extension WriteViewController : UIAdaptivePresentationControllerDelegate {
    //위의 시트에서 풀다운시 호출
    func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
        //경고창
        let alert = UIAlertController(title: "알림", message: "편집한 내용을 저장할까요?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default) { [weak self] (action) in
            self?.memoSaveBtn(action)
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { [weak self] (action) in
            self?.memoCancelBtn(action)
        }
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension WriteViewController {
    static let newMemoDidInsert = Notification.Name(rawValue: "newMemoDidInsert")
    static let memoDidChange = Notification.Name(rawValue: "memoDidChange")
}

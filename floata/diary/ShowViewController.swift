//
//  ShowViewController.swift
//  floata
//
//  Created by 홍태희 on 2021/11/22.
//

import UIKit

class ShowViewController: UIViewController {

    @IBOutlet weak var editTableView: UITableView!
    
    @IBAction func delWriteBtn(_ sender: Any) {
        
        let alert = UIAlertController(title: "삭제 확인", message: "메모를 삭제할까요?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "삭제", style: .destructive) { [weak self] (action) in
            DataManager.shared.deleteMemo(self?.memo)
            
            //메모창을 pop 하기위해서 navigationController 호출
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination.children.first as? WriteViewController {
            vc.editTarget = memo
        }
    }
    
    //Notification 토큰 저장
    var token : NSObjectProtocol?
    
    //옵저버 해제 코드
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    var memo : Writer?
    
    let formatter : DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.dateFormat = "yyyy-MM-dd HH:mm:ss"
        f.locale = Locale(identifier: "Ko_kr") //월(April)을 한글로
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
}

extension ShowViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            let cell = editTableView.dequeueReusableCell(withIdentifier: "listcell", for: indexPath)
            
            cell.textLabel?.text = memo?.pages
            
            return cell
            
        case 1:
            let cell = editTableView.dequeueReusableCell(withIdentifier: "formatcell", for: indexPath)
            
            cell.textLabel?.text = formatter.string(for: memo?.time)
            
            return cell
            
        default:
            fatalError()
        }
    }
}

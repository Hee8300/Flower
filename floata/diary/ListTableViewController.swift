//
//  ListTableViewController.swift
//  floata
//
//  Created by 홍태희 on 2021/11/22.
//

import UIKit

class ListTableViewController: UITableViewController {

    let formatter : DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .short
        f.dateFormat = "yyyy-MM-dd HH:mm:ss"
        f.locale = Locale(identifier: "Ko_kr") //월(April)을 한글로
        return f
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        
        DataManager.shared.fetchMemo() //호출시 배열이 데이터로 채워짐
        tableView.reloadData() //호출시 배열에 저장된 데이터를 기반으로 테이블뷰 업뎃
    }
    
    var token : NSObjectProtocol?
    
    //소멸자에서 해제
    deinit {
        if let token = token {
            NotificationCenter.default.removeObserver(token)
        }
    }
    
    //세그웨이가 연결된 화면 생성, 화면을 전환하기 직전에 호출
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell){
            if let vc = segue.destination as? ShowViewController {
                vc.memo = DataManager.shared.memoList[indexPath.row]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //옵저버를 실행하는 코드 + 옵저버 해제 (메모리 낭비 방지 -- token 선언함.)
        token = NotificationCenter.default.addObserver(forName: WriteViewController.newMemoDidInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
            
            
            
            //테이블뷰 리로드
            self?.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataManager.shared.memoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "viewcells", for: indexPath)

        // Configure the cell...
        let target = DataManager.shared.memoList[indexPath.row]
        cell.textLabel?.text = target.pages
        
        cell.detailTextLabel?.text = formatter.string(for : target.time)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        //편집기능 활성화
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            //메모 삭제코드 (new)
            let target = DataManager.shared.memoList[indexPath.row]
            DataManager.shared.deleteMemo(target)
            //데베 뿐만이 아니라 배열에서도 삭제해야한다 (언제나 두 갯수가 같아야한다)
            DataManager.shared.memoList.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
           
        }
    }
}

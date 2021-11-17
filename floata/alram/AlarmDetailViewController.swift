//
//  AlarmDetailViewController.swift
//  floting
//
//  Created by 홍태희 on 2021/11/03.
//

import UIKit

class AlarmDetailViewController: UIViewController {

    let myStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    @IBOutlet weak var dayTable: UITableView?
    
    let date = ["월요일마다", "화요일마다", "수요일마다", "목요일마다", "금요일마다", "토요일마다", "일요일마다"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dayTable?.delegate = self
        dayTable?.dataSource = self
    }

}

extension AlarmDetailViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return date.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 내가 정의한 Cell 만들기
        let cell: DetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "repluscell", for: indexPath) as! DetailTableViewCell
        
        // Cell의 내용 지정
        cell.monthCell?.text = date[indexPath.row]
                
        // 생성한 Cell 리턴
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("cell is touch now")
        
        //저장을 완료한 후 나갔을 때, 안함이 해당 누른 요일로 변경되어있어야한다.
        dismiss(animated: true)
    }
    
}

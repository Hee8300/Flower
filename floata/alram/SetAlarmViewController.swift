//
//  SetAlarmViewController.swift
//  floting
//
//  Created by 홍태희 on 2021/11/02.
//

import UIKit

class SetAlarmViewController: UIViewController {
    
    @IBOutlet weak var alramTable: UITableView?
    
    @IBAction func cancelBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        //유저가 설정한 알람(데이터) 저장 및 나가기
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        alramTable?.delegate = self
        alramTable?.dataSource = self
    }
}

extension SetAlarmViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: UITableViewCell
        
        //내가 정의한 Cell 만들기
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "dpcell", for: indexPath) as! DpTableViewCell
        } else if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: "repeatcell", for: indexPath) as! RepeatTableViewCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "alramcell", for: indexPath) as! AlarmTableViewCell
            
            //add switch in realramcell
            let switchView = UISwitch(frame: .zero)
            switchView.setOn(false, animated: true)
            switchView.tag = indexPath.row
            switchView.addTarget(self, action: #selector(self.switchChange(_:)), for: .valueChanged)
            cell.accessoryView = switchView
        }

        return cell
    }
    
    //Switch
    @objc func switchChange(_ sender : UISwitch){
        print("sender is \(sender.tag)")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            //datepicker cell
            
        } else if indexPath.row == 1 {
            //repeat cell
            
            
        } else {
            //realram cell
            
        }
    }
}

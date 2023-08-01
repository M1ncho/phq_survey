//
//  MainController.swift
//  phqsurvey_ios
//
//  Created by KJW on 2023/06/07.
//

import UIKit
import Foundation
import Alamofire

class MainController: UIViewController {

    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var memberListView: UITableView!
    
    var members: [Member] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        registerLabel.layer.cornerRadius = 10
        registerLabel.layer.masksToBounds = true
        
        memberListView.delegate = self
        memberListView.dataSource = self
        memberListView.rowHeight = UITableView.automaticDimension
        
        
        getMembers()
        
        
        let showPopup = UITapGestureRecognizer(target: self, action: #selector(clickPopupShow(recognizer:)))
        registerLabel.addGestureRecognizer(showPopup)
    }
    
    
    
    
    // MARK: - Objc Function
    @objc func clickPopupShow(recognizer: UITapGestureRecognizer) {
        let popup = self.storyboard?.instantiateViewController(withIdentifier: "RegisterPopupController") as? RegisterPopupController
        popup?.modalPresentationStyle = .overCurrentContext
        
        self.present(popup!, animated: false)
    }
    
    
    
    // MARK: - API 통신
    func getMembers() {
        HttpApi.getMemberList() { response in
            if let error = response.error {
                print("===== ERROR =====")
                print(error)
            }
            else {
                if let result = response.value {
                    guard let list = result.member_list else { return }
                    for item in list {
                        self.members.append(item)
                    }
                    
                    self.memberListView.reloadData()
                }
            }
        }
    }
    
    
    
}





// MARK: - Extension
extension MainController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        memberListView.backgroundColor = UIColor.white
        let cell = memberListView.dequeueReusableCell(withIdentifier: "memberView", for: indexPath) as! MemberListCell
        
        cell.memberData = members[indexPath.row]
        cell.indexPath = indexPath
        cell.delegate = self
        
        return cell
    }
    
}


extension MainController: MemberClickDelegate {
    func selectMember(index: Int) {
        let id = members[index].member_id
        let num = members[index].number
        
        let surveyController = self.storyboard?.instantiateViewController(withIdentifier: "SurveyController") as? SurveyController
        surveyController?.modalPresentationStyle = .fullScreen
        surveyController?.modalTransitionStyle = .coverVertical
        surveyController?.member_id = id
        surveyController?.memberNum = num
        
        self.present(surveyController!, animated: true)
    }
    
}

//
//  RegisterPopupController.swift
//  phqsurvey_ios
//
//  Created by KJW on 2023/06/07.
//

import UIKit

class RegisterPopupController: UIViewController {

    @IBOutlet weak var popLayoutView: UIView!
    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var memberIdTextField: UITextField!
    @IBOutlet weak var memberNumTextField: UITextField!
    @IBOutlet weak var registLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        popLayoutView.layer.cornerRadius = 20
        popLayoutView.layer.masksToBounds = true
        
        registLabel.layer.cornerRadius = 15
        registLabel.layer.masksToBounds = true
        
        
        let closePopup = UITapGestureRecognizer(target: self, action: #selector(clickClose(recognizer:)))
        closeImageView.addGestureRecognizer(closePopup)
        
        let clickRegist = UITapGestureRecognizer(target: self, action: #selector(registerClick(recognizer:)))
        registLabel.addGestureRecognizer(clickRegist)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

    // MARK: - Objc Function
    @objc func clickClose(recognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    @objc func registerClick(recognizer: UITapGestureRecognizer) {
        if memberIdTextField.text != nil {
            registMember()
        }
        else {
            print("ID 없음")
        }
    }
    
    
    
    
    // MARK: - API 통신
    func registMember() {
        let memberData = RegisterData()
        memberData.number = memberIdTextField.text!
        memberData.patient_number = memberNumTextField.text ?? ""
        
        HttpApi.registerMember(data: memberData) { response in
            if let error = response.error {
                print("===== ERROR =====")
                print(error)
            }
            else {
                if let result = response.value {
                    if result.result {
                        print("등록 성공")
                        
                        let id = result.member_id
                        
                        let surveyController = self.storyboard?.instantiateViewController(withIdentifier: "SurveyController") as? SurveyController
                        surveyController?.modalPresentationStyle = .fullScreen
                        surveyController?.modalTransitionStyle = .coverVertical
                        surveyController?.member_id = id
                        surveyController?.memberNum = memberData.number
                        
                        self.present(surveyController!, animated: true)
                    }
                    else {
                        print("등록 실패")
                    }
                }
            }
        }
    }
    
    
    
}

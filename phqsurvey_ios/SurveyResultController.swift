//
//  SurveyResultController.swift
//  phqsurvey_ios
//
//  Created by KJW on 2023/06/08.
//

import UIKit

class SurveyResultController: UIViewController {

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var lineLayoutView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var doneLabel: UILabel!
    
    var resultScore = 0
    var resultValues = ""
    var memberNum = ""
    var memberId = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameLabel.text = "\(memberNum)님은"
        
        scoreLabel.text = "\(resultScore)점"
        scoreLabel.asColor(targetString: "\(resultScore)", color: UIColor(named: "deepSkyBlue") ?? UIColor.blue)
        
        
        if resultScore <= 4 {
            gradeLabel.text = "우울증이 아닙니다."
        }
        else if resultScore >= 5 && resultScore <= 9 {
            gradeLabel.text = "가벼운 우울증입니다."
            gradeLabel.asColor(targetString: "가벼운 우울증", color: UIColor(named: "deepSkyBlue") ?? UIColor.blue)
        }
        else if resultScore >= 10 && resultScore <= 19 {
            gradeLabel.text = "중간정도 우울증입니다."
            gradeLabel.asColor(targetString: "중간정도 우울증", color: UIColor(named: "deepSkyBlue") ?? UIColor.blue)
        }
        else if resultScore >= 20 {
            gradeLabel.text = "심한 우울증입니다."
            gradeLabel.asColor(targetString: "심한 우울증", color: UIColor(named: "deepSkyBlue") ?? UIColor.blue)
        }
        
        
        lineLayoutView.layer.borderWidth = 3
        lineLayoutView.layer.borderColor = UIColor(named: "cobalt")?.cgColor
        
        doneLabel.layer.masksToBounds = true
        doneLabel.layer.cornerRadius = 8
        
        
        let moveBack = UITapGestureRecognizer(target: self, action: #selector(clickBack(recognizer:)))
        backImageView.addGestureRecognizer(moveBack)
        
        let clickDone = UITapGestureRecognizer(target: self, action: #selector(clickDone(recognizer:)))
        doneLabel.addGestureRecognizer(clickDone)
        
    }
    
    
    
    // MARK: - Objc Function
    @objc func clickBack(recognizer: UITapGestureRecognizer) {
        self.dismiss(animated: false)
    }
    
    @objc func clickDone(recognizer: UITapGestureRecognizer) {
        sendSurveyResult()
    }
    
    
    
    // MARK: - API 통신
    func sendSurveyResult() {
        let data = SurveyData()
        data.member_id = memberId
        data.score = resultScore
        data.value = resultValues
        
        HttpApi.phqSurveyPost(data: data) { response in
            if let error = response.error {
                print("===== ERROR =====")
                print(error)
            }
            else {
                if let result = response.value {
                    if result.result {
                        print("전송 성공")
                        
                        let mainController = self.storyboard?.instantiateViewController(withIdentifier: "MainController") as? MainController
                        mainController?.modalPresentationStyle = .fullScreen
                        mainController?.modalTransitionStyle = .coverVertical
                        self.present(mainController!, animated: false)
                    }
                    else {
                        print("전송 실패")
                    }
                }
            }
        }
    }
    
    
}





extension UILabel {
    func asColor(targetString: String, color: UIColor) {
        let fullText = text ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        let range = (fullText as NSString).range(of: targetString)
        
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        attributedText = attributedString
    }
}

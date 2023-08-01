//
//  SurveyController.swift
//  phqsurvey_ios
//
//  Created by KJW on 2023/06/07.
//

import UIKit
import Foundation

class SurveyController: UIViewController {
    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var qnaLayoutView: UIView!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var nonLabel: UILabel!
    @IBOutlet weak var twosixLabel: UILabel!
    @IBOutlet weak var sevenmoreLabel: UILabel!
    @IBOutlet weak var everyLabel: UILabel!
    
    @IBOutlet weak var prevLabel: UILabel!
    @IBOutlet weak var replayLabel: UILabel!
    @IBOutlet weak var nextdoneLabel: UILabel!
    
    @IBOutlet weak var circle1View: UIView!
    @IBOutlet weak var circle2View: UIView!
    @IBOutlet weak var circle3View: UIView!
    @IBOutlet weak var circle4View: UIView!
    @IBOutlet weak var circle5View: UIView!
    @IBOutlet weak var circle6View: UIView!
    @IBOutlet weak var circle7View: UIView!
    @IBOutlet weak var circle8View: UIView!
    @IBOutlet weak var circle9View: UIView!
    
    
    var member_id = 0
    var memberNum = ""
    
    var nowIndex = 1
    var surveyList = NSDictionary()
    var answerList = Dictionary<Int, Int>()
    var resultValue = 0
    var resultList = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        qnaLayoutView.layer.borderWidth = 2
        qnaLayoutView.layer.borderColor = UIColor(named: "cobalt")?.cgColor
        
        nonLabel.layer.borderWidth = 2
        nonLabel.layer.borderColor = UIColor(named: "cobalt")?.cgColor
        twosixLabel.layer.borderWidth = 2
        twosixLabel.layer.borderColor = UIColor(named: "cobalt")?.cgColor
        sevenmoreLabel.layer.borderWidth = 2
        sevenmoreLabel.layer.borderColor = UIColor(named: "cobalt")?.cgColor
        everyLabel.layer.borderWidth = 2
        everyLabel.layer.borderColor = UIColor(named: "cobalt")?.cgColor
        
        prevLabel.layer.masksToBounds = true
        prevLabel.layer.cornerRadius = 8
        prevLabel.layer.borderWidth = 2
        prevLabel.layer.borderColor = UIColor(named: "cobalt")?.cgColor
        
        replayLabel.layer.masksToBounds = true
        replayLabel.layer.cornerRadius = 8
        replayLabel.layer.borderWidth = 2
        replayLabel.layer.borderColor = UIColor(named: "cobalt")?.cgColor
        
        nextdoneLabel.layer.masksToBounds = true
        nextdoneLabel.layer.cornerRadius = 8
        
        
        circle1View.layer.cornerRadius = 10
        circle1View.layer.masksToBounds = true
        circle2View.layer.cornerRadius = 10
        circle2View.layer.masksToBounds = true
        circle3View.layer.cornerRadius = 10
        circle3View.layer.masksToBounds = true
        circle4View.layer.cornerRadius = 10
        circle4View.layer.masksToBounds = true
        circle5View.layer.cornerRadius = 10
        circle5View.layer.masksToBounds = true
        circle6View.layer.cornerRadius = 10
        circle6View.layer.masksToBounds = true
        circle7View.layer.cornerRadius = 10
        circle7View.layer.masksToBounds = true
        circle8View.layer.cornerRadius = 10
        circle8View.layer.masksToBounds = true
        circle9View.layer.cornerRadius = 10
        circle9View.layer.masksToBounds = true
        
        
        
        guard let surveyUrl = Bundle.main.url(forResource: "phq9Survey", withExtension: "plist") else { return }
        surveyList = NSDictionary(contentsOf: surveyUrl)!
        
        questionLabel.text = surveyList["question\(nowIndex)"] as? String
        TTSManager.shared.play(surveyList["question\(nowIndex)"] as! String)
        
        
        
        let clickBack = UITapGestureRecognizer(target: self, action: #selector(moveBack(recognizer:)))
        backImageView.addGestureRecognizer(clickBack)
        
        let clickNon = UITapGestureRecognizer(target: self, action: #selector(clickNon(recognizer:)))
        nonLabel.addGestureRecognizer(clickNon)
        
        let clickTwomore = UITapGestureRecognizer(target: self, action: #selector(clickTwosixday(recognizer:)))
        twosixLabel.addGestureRecognizer(clickTwomore)
        
        let clickSevenmore = UITapGestureRecognizer(target: self, action: #selector(clickSevenmoreday(recognizer:)))
        sevenmoreLabel.addGestureRecognizer(clickSevenmore)
        
        let clickEvery = UITapGestureRecognizer(target: self, action: #selector(clickEvery(recognizer:)))
        everyLabel.addGestureRecognizer(clickEvery)
        
        let clickNext = UITapGestureRecognizer(target: self, action: #selector(nextQuestion(recognizer:)))
        nextdoneLabel.addGestureRecognizer(clickNext)
        
        let clickPrev = UITapGestureRecognizer(target: self, action: #selector(prevQuestion(recognizer:)))
        prevLabel.addGestureRecognizer(clickPrev)
        
        let clickReplay = UITapGestureRecognizer(target: self, action: #selector(replayTTS(recognizer:)))
        replayLabel.addGestureRecognizer(clickReplay)
    }
    
    

    
    // MARK: - Objc Function
    @objc func moveBack(recognizer: UITapGestureRecognizer) {
        self.dismiss(animated: true)
    }
    
    @objc func clickNon(recognizer: UITapGestureRecognizer) {
        nonLabel.backgroundColor = UIColor(named: "darkRoyalBlue")
        nonLabel.textColor = UIColor.white
        twosixLabel.backgroundColor = UIColor.white
        twosixLabel.textColor = UIColor(named: "cobalt")
        sevenmoreLabel.backgroundColor = UIColor.white
        sevenmoreLabel.textColor = UIColor(named: "cobalt")
        everyLabel.backgroundColor = UIColor.white
        everyLabel.textColor = UIColor(named: "cobalt")
        
        answerList.updateValue(0, forKey: nowIndex)
    }
    
    @objc func clickTwosixday(recognizer: UITapGestureRecognizer) {
        nonLabel.backgroundColor = UIColor.white
        nonLabel.textColor = UIColor(named: "cobalt")
        twosixLabel.backgroundColor = UIColor(named: "darkRoyalBlue")
        twosixLabel.textColor = UIColor.white
        sevenmoreLabel.backgroundColor = UIColor.white
        sevenmoreLabel.textColor = UIColor(named: "cobalt")
        everyLabel.backgroundColor = UIColor.white
        everyLabel.textColor = UIColor(named: "cobalt")
        
        answerList.updateValue(1, forKey: nowIndex)
    }
    
    @objc func clickSevenmoreday(recognizer: UITapGestureRecognizer) {
        nonLabel.backgroundColor = UIColor.white
        nonLabel.textColor = UIColor(named: "cobalt")
        twosixLabel.backgroundColor = UIColor.white
        twosixLabel.textColor = UIColor(named: "cobalt")
        sevenmoreLabel.backgroundColor = UIColor(named: "darkRoyalBlue")
        sevenmoreLabel.textColor = UIColor.white
        everyLabel.backgroundColor = UIColor.white
        everyLabel.textColor = UIColor(named: "cobalt")
        
        answerList.updateValue(2, forKey: nowIndex)
    }
    
    @objc func clickEvery(recognizer: UITapGestureRecognizer) {
        nonLabel.backgroundColor = UIColor.white
        nonLabel.textColor = UIColor(named: "cobalt")
        twosixLabel.backgroundColor = UIColor.white
        twosixLabel.textColor = UIColor(named: "cobalt")
        sevenmoreLabel.backgroundColor = UIColor.white
        sevenmoreLabel.textColor = UIColor(named: "cobalt")
        everyLabel.backgroundColor = UIColor(named: "darkRoyalBlue")
        everyLabel.textColor = UIColor.white
        
        answerList.updateValue(3, forKey: nowIndex)
    }
    
    
    @objc func nextQuestion(recognizer: UITapGestureRecognizer) {
        nowIndex += 1
        
        if nowIndex < 10 {
            questionLabel.text = surveyList["question\(nowIndex)"] as? String
            
            if answerList[nowIndex] != nil {
                let index = answerList[nowIndex] ?? 0
                answerSetting(value: index)
                TTSManager.shared.play(surveyList["question\(nowIndex)"] as! String)
            }
            else {
                answerReset()
                TTSManager.shared.play(surveyList["question\(nowIndex)"] as! String)
            }
            
            if nowIndex == 9 {
                nextdoneLabel.text = "확인"
            }
            
            dotSetting(index: nowIndex)
        }
        else {
            nowIndex = 9
            SumValues()
            
            if answerList.count == 9 {
                let resultController = self.storyboard?.instantiateViewController(identifier: "SurveyResultController") as? SurveyResultController
                resultController?.modalPresentationStyle = .fullScreen
                resultController?.modalTransitionStyle = .crossDissolve
                resultController?.resultScore = resultValue
                resultController?.resultValues = resultList
                resultController?.memberNum = memberNum
                resultController?.memberId = member_id
                
                self.present(resultController!, animated: false)
            }
        }
    }
    
    @objc func prevQuestion(recognizer: UITapGestureRecognizer) {
        nowIndex -= 1
        
        if nowIndex >= 1 {
            questionLabel.text = surveyList["question\(nowIndex)"] as? String
            
            if answerList[nowIndex] != nil {
                let index = answerList[nowIndex] ?? 0
                answerSetting(value: index)
                TTSManager.shared.play(surveyList["question\(nowIndex)"] as! String)
            }
            else {
                answerReset()
                TTSManager.shared.play(surveyList["question\(nowIndex)"] as! String)
            }
            
            dotSetting(index: nowIndex)
        }
        else {
            nowIndex = 1
        }
    }
    
    
    @objc func replayTTS(recognizer: UITapGestureRecognizer) {
        TTSManager.shared.play(surveyList["question\(nowIndex)"] as! String)
    }
    
    
    
    
    
    
    // MARK: - Function
    func answerReset() {
        nonLabel.backgroundColor = UIColor.white
        nonLabel.textColor = UIColor(named: "cobalt")
        twosixLabel.backgroundColor = UIColor.white
        twosixLabel.textColor = UIColor(named: "cobalt")
        sevenmoreLabel.backgroundColor = UIColor.white
        sevenmoreLabel.textColor = UIColor(named: "cobalt")
        everyLabel.backgroundColor = UIColor.white
        everyLabel.textColor = UIColor(named: "cobalt")
    }
    
    func answerSetting(value: Int) {
        if value == 0 {
            nonLabel.backgroundColor = UIColor(named: "darkRoyalBlue")
            nonLabel.textColor = UIColor.white
            twosixLabel.backgroundColor = UIColor.white
            twosixLabel.textColor = UIColor(named: "cobalt")
            sevenmoreLabel.backgroundColor = UIColor.white
            sevenmoreLabel.textColor = UIColor(named: "cobalt")
            everyLabel.backgroundColor = UIColor.white
            everyLabel.textColor = UIColor(named: "cobalt")
        }
        else if value == 1 {
            nonLabel.backgroundColor = UIColor.white
            nonLabel.textColor = UIColor(named: "cobalt")
            twosixLabel.backgroundColor = UIColor(named: "darkRoyalBlue")
            twosixLabel.textColor = UIColor.white
            sevenmoreLabel.backgroundColor = UIColor.white
            sevenmoreLabel.textColor = UIColor(named: "cobalt")
            everyLabel.backgroundColor = UIColor.white
            everyLabel.textColor = UIColor(named: "cobalt")
        }
        else if value == 2 {
            nonLabel.backgroundColor = UIColor.white
            nonLabel.textColor = UIColor(named: "cobalt")
            twosixLabel.backgroundColor = UIColor.white
            twosixLabel.textColor = UIColor(named: "cobalt")
            sevenmoreLabel.backgroundColor = UIColor(named: "darkRoyalBlue")
            sevenmoreLabel.textColor = UIColor.white
            everyLabel.backgroundColor = UIColor.white
            everyLabel.textColor = UIColor(named: "cobalt")
        }
        else {
            nonLabel.backgroundColor = UIColor.white
            nonLabel.textColor = UIColor(named: "cobalt")
            twosixLabel.backgroundColor = UIColor.white
            twosixLabel.textColor = UIColor(named: "cobalt")
            sevenmoreLabel.backgroundColor = UIColor.white
            sevenmoreLabel.textColor = UIColor(named: "cobalt")
            everyLabel.backgroundColor = UIColor(named: "darkRoyalBlue")
            everyLabel.textColor = UIColor.white
        }
    }
    
    func SumValues() {
        let sortedAnswer = answerList.sorted { $0.0 < $1.0 }
        
        for item in sortedAnswer {
            resultValue += item.value
            
            if item.key == 9 {
                resultList += "\(item.value)"
            }
            else {
                resultList += "\(item.value),"
            }
        }
        
        //print("\(resultValue) :: \(resultList)")
    }
    
    
    // dot indicater 표시
    func dotSetting(index: Int) {
        if index == 1 {
            circle1View.backgroundColor = UIColor(named: "cobalt")
            circle2View.backgroundColor = UIColor(named: "whiteGrey")
            circle3View.backgroundColor = UIColor(named: "whiteGrey")
            circle4View.backgroundColor = UIColor(named: "whiteGrey")
            circle5View.backgroundColor = UIColor(named: "whiteGrey")
            circle6View.backgroundColor = UIColor(named: "whiteGrey")
            circle7View.backgroundColor = UIColor(named: "whiteGrey")
            circle8View.backgroundColor = UIColor(named: "whiteGrey")
            circle9View.backgroundColor = UIColor(named: "whiteGrey")
        }
        else if index == 2 {
            circle1View.backgroundColor = UIColor(named: "whiteGrey")
            circle2View.backgroundColor = UIColor(named: "cobalt")
            circle3View.backgroundColor = UIColor(named: "whiteGrey")
            circle4View.backgroundColor = UIColor(named: "whiteGrey")
            circle5View.backgroundColor = UIColor(named: "whiteGrey")
            circle6View.backgroundColor = UIColor(named: "whiteGrey")
            circle7View.backgroundColor = UIColor(named: "whiteGrey")
            circle8View.backgroundColor = UIColor(named: "whiteGrey")
            circle9View.backgroundColor = UIColor(named: "whiteGrey")
        }
        else if index == 3 {
            circle1View.backgroundColor = UIColor(named: "whiteGrey")
            circle2View.backgroundColor = UIColor(named: "whiteGrey")
            circle3View.backgroundColor = UIColor(named: "cobalt")
            circle4View.backgroundColor = UIColor(named: "whiteGrey")
            circle5View.backgroundColor = UIColor(named: "whiteGrey")
            circle6View.backgroundColor = UIColor(named: "whiteGrey")
            circle7View.backgroundColor = UIColor(named: "whiteGrey")
            circle8View.backgroundColor = UIColor(named: "whiteGrey")
            circle9View.backgroundColor = UIColor(named: "whiteGrey")
        }
        else if index == 4 {
            circle1View.backgroundColor = UIColor(named: "whiteGrey")
            circle2View.backgroundColor = UIColor(named: "whiteGrey")
            circle3View.backgroundColor = UIColor(named: "whiteGrey")
            circle4View.backgroundColor = UIColor(named: "cobalt")
            circle5View.backgroundColor = UIColor(named: "whiteGrey")
            circle6View.backgroundColor = UIColor(named: "whiteGrey")
            circle7View.backgroundColor = UIColor(named: "whiteGrey")
            circle8View.backgroundColor = UIColor(named: "whiteGrey")
            circle9View.backgroundColor = UIColor(named: "whiteGrey")
        }
        else if index == 5 {
            circle1View.backgroundColor = UIColor(named: "whiteGrey")
            circle2View.backgroundColor = UIColor(named: "whiteGrey")
            circle3View.backgroundColor = UIColor(named: "whiteGrey")
            circle4View.backgroundColor = UIColor(named: "whiteGrey")
            circle5View.backgroundColor = UIColor(named: "cobalt")
            circle6View.backgroundColor = UIColor(named: "whiteGrey")
            circle7View.backgroundColor = UIColor(named: "whiteGrey")
            circle8View.backgroundColor = UIColor(named: "whiteGrey")
            circle9View.backgroundColor = UIColor(named: "whiteGrey")
        }
        else if index == 6 {
            circle1View.backgroundColor = UIColor(named: "whiteGrey")
            circle2View.backgroundColor = UIColor(named: "whiteGrey")
            circle3View.backgroundColor = UIColor(named: "whiteGrey")
            circle4View.backgroundColor = UIColor(named: "whiteGrey")
            circle5View.backgroundColor = UIColor(named: "whiteGrey")
            circle6View.backgroundColor = UIColor(named: "cobalt")
            circle7View.backgroundColor = UIColor(named: "whiteGrey")
            circle8View.backgroundColor = UIColor(named: "whiteGrey")
            circle9View.backgroundColor = UIColor(named: "whiteGrey")
        }
        else if index == 7 {
            circle1View.backgroundColor = UIColor(named: "whiteGrey")
            circle2View.backgroundColor = UIColor(named: "whiteGrey")
            circle3View.backgroundColor = UIColor(named: "whiteGrey")
            circle4View.backgroundColor = UIColor(named: "whiteGrey")
            circle5View.backgroundColor = UIColor(named: "whiteGrey")
            circle6View.backgroundColor = UIColor(named: "whiteGrey")
            circle7View.backgroundColor = UIColor(named: "cobalt")
            circle8View.backgroundColor = UIColor(named: "whiteGrey")
            circle9View.backgroundColor = UIColor(named: "whiteGrey")
        }
        else if index == 8 {
            circle1View.backgroundColor = UIColor(named: "whiteGrey")
            circle2View.backgroundColor = UIColor(named: "whiteGrey")
            circle3View.backgroundColor = UIColor(named: "whiteGrey")
            circle4View.backgroundColor = UIColor(named: "whiteGrey")
            circle5View.backgroundColor = UIColor(named: "whiteGrey")
            circle6View.backgroundColor = UIColor(named: "whiteGrey")
            circle7View.backgroundColor = UIColor(named: "whiteGrey")
            circle8View.backgroundColor = UIColor(named: "cobalt")
            circle9View.backgroundColor = UIColor(named: "whiteGrey")
        }
        else {
            circle1View.backgroundColor = UIColor(named: "whiteGrey")
            circle2View.backgroundColor = UIColor(named: "whiteGrey")
            circle3View.backgroundColor = UIColor(named: "whiteGrey")
            circle4View.backgroundColor = UIColor(named: "whiteGrey")
            circle5View.backgroundColor = UIColor(named: "whiteGrey")
            circle6View.backgroundColor = UIColor(named: "whiteGrey")
            circle7View.backgroundColor = UIColor(named: "whiteGrey")
            circle8View.backgroundColor = UIColor(named: "whiteGrey")
            circle9View.backgroundColor = UIColor(named: "cobalt")
        }
    }
    
    
    
}

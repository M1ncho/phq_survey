//
//  MemberListCell.swift
//  phqsurvey_ios
//
//  Created by KJW on 2023/06/07.
//

import UIKit

protocol MemberClickDelegate {
    func selectMember(index: Int)
}

class MemberListCell: UITableViewCell {

    @IBOutlet weak var layoutView: UIView!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var patientLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthLabel: UILabel!
    
    @IBOutlet weak var idView: UIView!
    @IBOutlet weak var numView: UIView!
    @IBOutlet weak var patientView: UIView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var birthView: UIView!
    
    var indexPath: IndexPath?
    var delegate: MemberClickDelegate?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
        layoutView.layer.masksToBounds = true
        layoutView.layer.cornerRadius = 10
        
        
        let clickId = UITapGestureRecognizer(target: self, action: #selector(clickCell(recognizer:)))
        idView.addGestureRecognizer(clickId)
        
        let clickNum = UITapGestureRecognizer(target: self, action: #selector(clickCell(recognizer:)))
        numView.addGestureRecognizer(clickNum)
        
        let clickPatient = UITapGestureRecognizer(target: self, action: #selector(clickCell(recognizer:)))
        patientView.addGestureRecognizer(clickPatient)
        
        let clickGender = UITapGestureRecognizer(target: self, action: #selector(clickCell(recognizer:)))
        genderView.addGestureRecognizer(clickGender)
        
        let clickBirth = UITapGestureRecognizer(target: self, action: #selector(clickCell(recognizer:)))
        birthView.addGestureRecognizer(clickBirth)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // 간격 설정
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0))
    }
    
    
    
    // MARK: - DidSet Values
    var memberData: Member? {
        didSet {
            idLabel.text = "\(memberData!.member_id)"
            numLabel.text = "\(memberData!.number)"
            patientLabel.text = "\(memberData!.patient_number)"
            
            if memberData?.gender != nil {
                genderLabel.text = "\(memberData!.gender)"
            }
            
            if memberData?.birth_date != nil {
                birthLabel.text = "\(memberData!.birth_date)"
            }
            
        }
    }
    
    
    
    
    
    
    
    // MARK: - Objc Function
    @objc func clickCell(recognizer: UITapGestureRecognizer) {
        self.delegate?.selectMember(index: indexPath!.row)
    }
    
    
}

//
//  RegisterData.swift
//  phqsurvey_ios
//
//  Created by KJW on 2023/06/09.
//

import Foundation

class RegisterData: Codable {
    var number: String = ""
    var patient_number: String = ""
    
    
    init() {
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        number = try values.decode(String.self, forKey: .number)
        patient_number = try values.decode(String.self, forKey: .patient_number)
    }
    
    private enum CodingKeys: String, CodingKey {
        case number
        case patient_number
    }
    
}

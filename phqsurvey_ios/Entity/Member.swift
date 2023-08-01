//
//  Member.swift
//  phqsurvey_ios
//
//  Created by KJW on 2023/06/08.
//

import Foundation

class Member: Codable {
    
    var member_id: Int = 0
    var number: String = ""
    var patient_number: String = ""
    var gender: String?
    var birth_date: Double?
    var data_count: Int = 0
    
    init() {
    }
    
    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        
        member_id = try value.decode(Int.self, forKey: .member_id)
        number = try value.decode(String.self, forKey: .number)
        patient_number = try value.decode(String.self, forKey: .patient_number)
        gender = (try? value.decode(String.self, forKey: .gender)) ?? nil
        birth_date = (try? value.decode(Double.self, forKey: .birth_date)) ?? nil
        data_count = try value.decode(Int.self, forKey: .data_count)
    }
    
    private enum CodingKeys: String, CodingKey {
        case member_id
        case number
        case patient_number
        case gender
        case birth_date
        case data_count
    }
    
}

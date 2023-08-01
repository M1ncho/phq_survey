//
//  SurveyData.swift
//  phqsurvey_ios
//
//  Created by KJW on 2023/06/09.
//

import Foundation

class SurveyData: Codable {
    
    var member_id: Int = 0
    var score: Int = 0
    var value: String = ""
    
    
    init() {
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        member_id = try values.decode(Int.self, forKey: .member_id)
        score = try values.decode(Int.self, forKey: .score)
        value = try values.decode(String.self, forKey: .value)
    }
    
    private enum CodingKeys: String, CodingKey {
        case member_id
        case score
        case value
    }
    
}

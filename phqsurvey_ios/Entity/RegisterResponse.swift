//
//  RegisterResponse.swift
//  phqsurvey_ios
//
//  Created by KJW on 2023/06/09.
//

import Foundation

class RegisterResponse: Codable {
    
    var result: Bool
    var member_id: Int
    
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        result = try values.decode(Bool.self, forKey: .result)
        member_id = try values.decode(Int.self, forKey: .member_id)
    }
    
    private enum CodingKeys: String, CodingKey {
        case result
        case member_id
    }
    
}

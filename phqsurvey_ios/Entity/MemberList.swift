//
//  MemberList.swift
//  phqsurvey_ios
//
//  Created by KJW on 2023/06/08.
//

import Foundation

class MemberList: Codable {
    var member_list: [Member]?
    
    init() {
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        member_list = (try? values.decode([Member].self, forKey: .member_list)) ?? nil
    }
    
    private enum CodingKeys: String, CodingKey {
        case member_list
    }
    
}

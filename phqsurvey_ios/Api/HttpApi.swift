//
//  HttpApi.swift
//  phqsurvey_ios
//
//  Created by KJW on 2023/06/08.
//

import Foundation
import Alamofire


class HttpApi: NSObject {
    
    static let BASE_URL: String = "http://med.blifeinc.com/"
    
    
    // 회원 목록 가져오기
    static func getMemberList(completion: @escaping(DataResponse<MemberList, AFError>) -> Void) {
        let url = "\(BASE_URL)api/phqmember/list"
        
        AF.request(url, method: .get).responseDecodable(of: MemberList.self) { response in
            completion(response)
        }
    }
    
    
    // 회원 등록
    static func registerMember(data: RegisterData, completion: @escaping(DataResponse<RegisterResponse, AFError>) -> Void) {
        let url = "\(BASE_URL)api/phqmember/add"
        
        let registerData = try! JSONEncoder().encode(data)
        let registerString = String(data: registerData, encoding: .utf8)
        print(registerString!)
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = registerData
        
        AF.request(request).responseDecodable(of: RegisterResponse.self) { response in
            completion(response)
        }
    }
    
    
    // 데이터 업로드
    static func phqSurveyPost(data: SurveyData, completion: @escaping(DataResponse<SendResult, AFError>) -> Void) {
        let url = "\(BASE_URL)api/phq_data/upload"
        
        let surveyData = try! JSONEncoder().encode(data)
        let surveyString = String(data: surveyData, encoding: .utf8)
        print(surveyString!)
        
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = surveyData
        
        AF.request(request).responseDecodable(of: SendResult.self) { response in
            completion(response)
        }
    }
    
    
}

//
//  AFWrapper.swift
//  SimpleMVVMExample
//
//  Created by Shinu Mohan on 26/08/21.
//

import UIKit
import Alamofire

struct Login: Encodable {
    let email: String
    let password: String
}

typealias SuccessCompletionBlock = (_ resoponse: ([AnyObject])) -> Void
typealias FailureBlock = (_ error: AFError?) -> Void

class AFWrapper: NSObject {
    
    func fetchAFData(getUrl: String) {
        let request = AF.request(getUrl)
        request.responseJSON { (data) in
        print(data)
      }
    }
    
    func getAFData(getUrl: String?, success: @escaping SuccessCompletionBlock, failure: @escaping FailureBlock) {
        guard let url = URL(string: getUrl ?? "") else {
            failure(nil)
            return
        }
        
        //need to throw the response and error from here....getting error on this
//        let request = AF.request(url)
//        request.responseJSON { (data) in
//            success(data)
//        }
//        request.error { (error) in
//            failure(error)
//        }
    }
    
    func postAFData(postUrl: String, params : Encodable) {
        //example post request...
        let login = Login(email: "test@test.test", password: "testPassword")
        AF.request(postUrl,
                   method: .post,
                   parameters: login,
                   encoder: JSONParameterEncoder.default).response { response in
        print(response)
      }
    }
    
    func postAFDataWithHeader(postUrl: String, params : Encodable) {
        let headers: HTTPHeaders? = ["Content-Type": "application/x-www-form-urlencoded",
                                         "Access-Token": ""]
        AF.request(postUrl,
                       method: .post,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: headers,
                       interceptor: nil)
          .response(completionHandler: { dataResponse in
                    if dataResponse.response?.statusCode == 201 {
                        // Handle 201 success
                    } else if dataResponse.response?.statusCode == 409 {
                        // Handle 409 error
                    } else {
                        // Handle Unknown error
                    }
        })
    }
    
}

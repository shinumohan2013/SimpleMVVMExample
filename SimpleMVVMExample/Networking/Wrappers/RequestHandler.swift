//
//  RequestHandler.swift
//  SimpleMVVMExample
//
//  Created by Shinu Mohan on 26/08/21.
//

import Alamofire
import UIKit


public typealias RequestHandlerCompletionBlock = (_ resoponse: ([String: Any])) -> Void
public typealias FailureErrorBlock = (_ error: Error?) -> Void

public class RequestHandler {
    
    /// Shared variable
    public static var sharedRequestHandler: RequestHandler = {
        let requestHandler = RequestHandler()
        return requestHandler
    }()
    
    /// Return shared request handler
    public class func shared() -> RequestHandler {
        return sharedRequestHandler
    }
    
    /// API Request
    /// - Parameters:
    ///   - requestModel:APIRequestModel
    ///   - success:response
    public func request(requestModel: APIRequestModel,
                        success: @escaping ( _ response: DataResponse<Any, Error>) -> Void) {
        if let baseURL = requestModel.url {
            AF.request(baseURL)
              .validate()
              .response { (data) in
                    //success(data)
                }
        }
    }
    
    public static func configureRequest(url: URL, success: @escaping RequestHandlerCompletionBlock, failure: @escaping FailureErrorBlock) {
        let requestModel = APIRequestModel(url: url,
                                           httpMethod: .get,
                                           parameters: nil,
                                           encoding: URLEncoding.default,
                                           headers: nil)
        RequestHandler.shared().request(requestModel: requestModel) { response in
            self.handleResponseJSON(response, success: success, failure: failure)
        }
    }
    
    /// Handle JSON response from API
    /// - Parameters:
    ///   - response:The server's response to the URL request.
    ///   - success: SuccessCompletionBlock
    ///   - failure: FailureErrorBlock
    public static func handleResponseJSON(_ response: DataResponse<Any, Error>, success: @escaping RequestHandlerCompletionBlock, failure: @escaping FailureErrorBlock) {
        switch response.result {
        case .success:
            if let json = response.result as? [String: Any] {
                success(json)
            } else {
                extractErrorValues(response: response)
            }
        case .failure(let error):
            guard let code = response.response?.statusCode else {
                _ = CommonErrorsUtility(jsonData: response.data, withOption: .mutableContainers)
                print("Invalid status code")
                failure(nil)
                return
            }
            let errorHandler = CommonErrorsUtility(jsonData: response.data, withOption: .mutableContainers)
            let customError = NSError(domain: "", code: errorHandler.errorCode ?? code, userInfo: [ NSLocalizedDescriptionKey: error.localizedDescription ]) as Error
            _ = ErrorProvider(handler: errorHandler)
            extractErrorValues(response: response)
            failure(customError)
        }
    }
    
    /// Error for each case
    /// - Parameter error: Alamofire Error type
    public static func extractError(_ error: AFError) {
        switch error {
        case .invalidURL(let url):
            print("Invalid URL: \(url) - \(error.localizedDescription)")
        case .parameterEncodingFailed(let reason):
            print("Parameter encoding failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        case .multipartEncodingFailed(let reason):
            print("Multipart encoding failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        case .responseValidationFailed(let reason):
            print("Response validation failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
            
            switch reason {
            case .dataFileNil, .dataFileReadFailed:
                print("Downloaded file could not be read")
            case .missingContentType(let acceptableContentTypes):
                print("Content Type Missing: \(acceptableContentTypes)")
            case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
            case .unacceptableStatusCode(let code):
                print("Response status code was unacceptable: \(code)")
            case .customValidationFailed(error: _):
                print("CustomValidationFailed")
            }
        case .responseSerializationFailed(let reason):
            print("Response serialization failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        case .createUploadableFailed(error: let error):
            print("Failure Reason: \(error.localizedDescription)")
        case .createURLRequestFailed(error: let error):
            print("Failure Reason: \(error.localizedDescription)")
        case .downloadedFileMoveFailed(error: let error, source: _, destination: _):
            print("Failure Reason: \(error.localizedDescription)")
        case .explicitlyCancelled:
            print("Failure Reason: \(error.localizedDescription)")
        case .parameterEncoderFailed(reason: let reason):
            print("Failure Reason: \(reason)")
        case .requestAdaptationFailed(error: let error):
            print("Failure Reason: \(error.localizedDescription)")
        case .requestRetryFailed(retryError: let retryError, originalError: _):
            print("Failure Reason: \(retryError.localizedDescription)")
        case .serverTrustEvaluationFailed(reason: let reason):
            print("Failure Reason: \(reason)")
        case .sessionDeinitialized:
            print("Failure Reason: \(error.localizedDescription)")
        case .sessionInvalidated(error: let error):
            print("Failure Reason: \(error?.localizedDescription ?? "")")
        case .sessionTaskFailed(error: let error):
            print("Failure Reason: \(error.localizedDescription)")
        case .urlRequestValidationFailed(reason: let reason):
            print("Failure Reason: \(reason)")
        }
    }
    
    /// Show error based on response
    /// - Parameter response:The server's response to the URL request.
    public static func extractErrorValues(response: DataResponse<Any, Error>) {
        guard case let .failure(error) = response.result else { return }
        if let error = error as? AFError {
            extractError(error)
            print("Underlying error: \(String(describing: error.underlyingError))")
        } else if let error = error as? URLError {
            print("URLError occurred: \(error)")
        } else {
            print("Unknown error: \(error)")
        }
    }
}

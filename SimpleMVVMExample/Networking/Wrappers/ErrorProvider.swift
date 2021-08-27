//
//  ErrorProvider.swift
//  SimpleMVVMExample
//
//  Created by Shinu Mohan on 26/08/21.
//

/// Error Provider class based on Network Error Code
final public class ErrorProvider: Error {
    
    // MARK: - Properties

    var errorDescription: String?
    var errorCode: Int?
    var errorMessage: String?
    var coreError: CommonError?
    
    enum CommonError {
        case noNetwork
        case noProviderFound
        case baseURLNotFound
    }
    // MARK: - Initilization
    
    /// Init
    /// - Parameter handler: CommonErrorsUtility
    public init(handler: CommonErrorsUtility?) {
        switch handler?.errorCode {
        case GenericError.noProviderFound.code:
            self.coreError = .noProviderFound
        case GenericError.noNetwork.code:
            self.coreError = .noNetwork
        case GenericError.baseURLNotFound.code:
            self.coreError = .baseURLNotFound
        default:
            self.errorDescription = handler?.errorDescription
            self.errorMessage = handler?.message
            self.errorCode = handler?.errorCode
        }
    }
}

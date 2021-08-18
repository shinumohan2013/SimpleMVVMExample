//
//  BreachViewModel.swift
//  SimpleMVVMExample
//
//  Created by Shinu Mohan on 17/08/21.

import Foundation
import Alamofire
import PromiseKit

class BreachViewModel {
    // MARK: - Initialization
    init(model: [BreachModel]? = nil) {
        if let inputModel = model {
            breaches = inputModel
        }
    }
    var breaches: [BreachModel] = [BreachModel(title: "000webhost"),BreachModel(title: "126")]
}

extension BreachViewModel {
    func fetchBreaches(completion: @escaping (Result<[BreachModel]>) -> Void) {
        completion(.fulfilled(breaches))
        completion(.rejected("error" as! Error))
    }
}

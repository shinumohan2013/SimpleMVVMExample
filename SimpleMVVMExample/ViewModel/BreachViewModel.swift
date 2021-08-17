//
//  DisplayViewModel.swift
//  SimpleMVVMExample
//
//  Created by Shinu Mohan on 17/08/21.

import Foundation

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
    func fetchBreaches(completion: @escaping (Result<[BreachModel], Error>) -> Void) {
        completion(.success(breaches))
    }
}

//
//  PhotoViewModel.swift
//  SimpleMVVMExample
//
//  Created by Shinu Mohan on 17/08/21.

import Foundation
import Alamofire
import PromiseKit

class PhotoViewModel {
    
    let photosURL = "https://jsonplaceholder.typicode.com/photos"
    var photos: [UIImage] = []
    
    // MARK: - Initialization
    init(model: [PhotoModel]? = nil) {
        if let inputModel = model {
            photosList = inputModel
        }
    }
    
    var photosList: [PhotoModel] = [PhotoModel(albumId: 0, id: 0, title: "123", url: "www.123.com", thumbnailUrl: "www.photourl.com")]
    
    // MARK :- Photo Error Helpers
    enum PhotoError: Error {
        case ConvertToData
        case PhotoDecoding
        case downloadPhotoUrl
        case downloadPhotoConvertToData
        case downloadPhotoConvertToUIImage
    }
}

// MARK :- Photo Api Calls
extension PhotoViewModel {
    func fetchPhotos(completion: @escaping (Result<[PhotoModel]>) -> Void) {
        completion(.fulfilled(photosList))
        completion(.rejected("error" as! Error))
    }
}

//
//  PhotoModel.swift
//  SimpleMVVMExample
//
//  Created by Shinu Mohan on 17/08/21.

import Foundation

public struct PhotoModel: Codable {
    
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

//
//  Photo.swift
//  DogImageApp
//
//  Created by 鳥山彰仁 on 2022/10/31.
//

import Foundation

struct Photo: Codable{
    let message: String
    let status: String
    
    //イニシャライズ(初期化)
    init(message: String, status: String) {
        self.message = message
        self.status = status
    }
}

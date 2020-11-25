//
//  parseJson.swift
//  BeChef
//
//  Created by abdulrazak on 24/11/20.
//

import Foundation
struct langkah : Decodable {
    
    let jobs: [Jobs]
}

struct Jobs: Decodable {
    var step: Int?
    var gambar: String?
    var instruksi: String?
}

//
//  MyYelloDetailModel.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/13.
//

import UIKit

// MARK: - MyYelloDetailModel
struct MyYelloDetailModel: Codable {
    let status: Int
    let message: String
    let data: MyYelloDetailResponseDTO
}

var MyYelloDetailModelDummy: [MyYelloDetailResponseDTO] = []

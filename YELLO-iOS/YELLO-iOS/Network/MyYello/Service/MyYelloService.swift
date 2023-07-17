//
//  MyYelloService.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/15.
//

import Foundation

protocol MyYelloServiceProtocol {

    func myYello(queryDTO: MyYelloRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<MyYelloResponseDTO>>) -> Void)
}

final class MyYelloService: APIRequestLoader<MyYelloTarget>, MyYelloServiceProtocol {

    func myYello(queryDTO: MyYelloRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<MyYelloResponseDTO>>) -> Void) {
        fetchData(target: .myYello(queryDTO),
                  responseData: BaseResponse<MyYelloResponseDTO>.self, completion: completion)
    }
}

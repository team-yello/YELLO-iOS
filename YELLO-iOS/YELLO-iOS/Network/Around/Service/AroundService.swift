//
//  AroundService.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/14.
//

import Foundation

protocol AroundServiceProtocol {
    func around(queryDTO: AroundRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<AroundResponseDTO>>) -> Void)
}

final class AroundService: APIRequestLoader<AroundTarget>, AroundServiceProtocol {
    func around(queryDTO: AroundRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<AroundResponseDTO>>) -> Void) {
        fetchData(target: .around(queryDTO),
                  responseData: BaseResponse<AroundResponseDTO>.self, completion: completion)
    }
}

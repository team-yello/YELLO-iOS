//
//  MyYelloService.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/15.
//

import Foundation

protocol MyYelloServiceProtocol {

    func myYello(queryDTO: MyYelloRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<MyYelloResponseDTO>>) -> Void)
    
    func myYelloDetail(voteId: Int, completion: @escaping (NetworkResult<BaseResponse<MyYelloDetailResponseDTO>>) -> Void)
    
    func myYelloDetailKeyword(voteId: Int, completion: @escaping (NetworkResult<BaseResponse<MyYelloDetailKeywordResponseDTO>>) -> Void)
}

final class MyYelloService: APIRequestLoader<MyYelloTarget>, MyYelloServiceProtocol {

    func myYello(queryDTO: MyYelloRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<MyYelloResponseDTO>>) -> Void) {
        fetchData(target: .myYello(queryDTO),
                  responseData: BaseResponse<MyYelloResponseDTO>.self, completion: completion)
    }
    
    func myYelloDetail(voteId: Int, completion: @escaping (NetworkResult<BaseResponse<MyYelloDetailResponseDTO>>) -> Void) {
        fetchData(target: .myYelloDetail(voteId: voteId),
                  responseData: BaseResponse<MyYelloDetailResponseDTO>.self, completion: completion)
    }
    
    func myYelloDetailKeyword(voteId: Int, completion: @escaping (NetworkResult<BaseResponse<MyYelloDetailKeywordResponseDTO>>) -> Void) {
        fetchData(target: .myYelloDetailKeyword(voteId: voteId),
                  responseData: BaseResponse<MyYelloDetailKeywordResponseDTO>.self, completion: completion)
    }
}

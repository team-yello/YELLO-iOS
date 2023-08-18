//
//  SearchService.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/14.
//

import Foundation

import Alamofire

protocol SearchServiceProtocol {
    func friendSearch(queryDTO: FriendSearchRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<FriendSearchResponseDTO>>) -> Void)
}

final class SearchService: APIRequestLoader<SearchTarget>, SearchServiceProtocol {
    
    func friendSearch(queryDTO: FriendSearchRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<FriendSearchResponseDTO>>) -> Void) {
        fetchData(target: .friendSearch(queryDTO), responseData: BaseResponse<FriendSearchResponseDTO>.self, completion: completion)
    }
}

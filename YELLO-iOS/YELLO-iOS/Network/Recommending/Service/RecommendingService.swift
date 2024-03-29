//
//  RecommendingService.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/15.
//

import Foundation

protocol RecommendingServiceProtocol {
    func recommendingKakaoFriend(queryDTO: RecommendingRequestQueryDTO, requestDTO: RecommendingFriendRequestDTO, completion: @escaping (NetworkResult<BaseResponse<RecommendingFriendResponseDTO>>) -> Void)
    
    func recommendingSchoolFriend(queryDTO: RecommendingRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<RecommendingFriendResponseDTO>>) -> Void)
    
    func recommendingAddFriend(friendId: Int, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void)
    
    func recommendingDetailFriend(friendId: Int, completion: @escaping (NetworkResult<BaseResponse<ProfileFriendResponseDetail>>) -> Void)
}

final class RecommendingService: APIRequestLoader<RecommendingTarget>, RecommendingServiceProtocol {
    func recommendingKakaoFriend(queryDTO: RecommendingRequestQueryDTO, requestDTO: RecommendingFriendRequestDTO, completion: @escaping (NetworkResult<BaseResponse<RecommendingFriendResponseDTO>>) -> Void) {
        fetchData(target: .recommendingKakaoFriend(queryDTO, requestDTO),
                  responseData: BaseResponse<RecommendingFriendResponseDTO>.self, completion: completion)
    }
    
    func recommendingSchoolFriend(queryDTO: RecommendingRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<RecommendingFriendResponseDTO>>) -> Void) {
        fetchData(target: .recommendingSchoolFriend(queryDTO),
                  responseData: BaseResponse<RecommendingFriendResponseDTO>.self, completion: completion)
    }
    
    func recommendingAddFriend(friendId: Int, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void) {
        fetchData(target: .recommendingAddFriend(friendId),
                  responseData: BaseResponse<String?>.self, completion: completion)
    }
    
    func recommendingDetailFriend(friendId: Int, completion: @escaping (NetworkResult<BaseResponse<ProfileFriendResponseDetail>>) -> Void) {
        fetchData(target: .recommendingDetailFriend(friendId),
                  responseData: BaseResponse<ProfileFriendResponseDetail>.self, completion: completion)
    }
}

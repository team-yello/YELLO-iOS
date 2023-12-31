//
//  ProfileService.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/15.
//

import Foundation

protocol ProfileServiceProtocol {
    func profileUser(completion: @escaping (NetworkResult<BaseResponse<ProfileUserResponseDTO>>) -> Void)
    
    func profileFriend(queryDTO: ProfileFriendRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<ProfileFriendResponseDTO>>) -> Void)
    
    func profileDeleteFriend(id: Int, completion: @escaping (NetworkResult<BaseResponse<Bool>>) -> Void)
    
    func userDelete(completion: @escaping (NetworkResult<BaseResponse<Bool>>) -> Void)
    
    func purchaseInfo(completion: @escaping (NetworkResult<BaseResponse<PurchaseInfoResponseDTO>>) -> Void)
}

final class ProfileService: APIRequestLoader<ProfileTarget>, ProfileServiceProtocol {
    func profileUser(completion: @escaping (NetworkResult<BaseResponse<ProfileUserResponseDTO>>) -> Void) {
        fetchData(target: .profileUser,
                  responseData: BaseResponse<ProfileUserResponseDTO>.self, completion: completion)
    }
    
    func profileFriend(queryDTO: ProfileFriendRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<ProfileFriendResponseDTO>>) -> Void) {
        fetchData(target: .profileFriend(queryDTO),
                  responseData: BaseResponse<ProfileFriendResponseDTO>.self, completion: completion)
    }
    
    func profileDeleteFriend(id: Int, completion: @escaping (NetworkResult<BaseResponse<Bool>>) -> Void) {
        fetchData(target: .profileDeleteFriend(id: id),
                  responseData: BaseResponse<Bool>.self, completion: completion)
    }
    
    func userDelete(completion: @escaping (NetworkResult<BaseResponse<Bool>>) -> Void) {
        fetchData(target: .deleteUser, responseData: BaseResponse<Bool>.self, completion: completion)
    }
    
    func purchaseInfo(completion: @escaping (NetworkResult<BaseResponse<PurchaseInfoResponseDTO>>) -> Void) {
        fetchData(target: .purchaseInfo, responseData: BaseResponse<PurchaseInfoResponseDTO>.self, completion: completion)
    }
}

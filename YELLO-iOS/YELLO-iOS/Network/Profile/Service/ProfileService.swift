//
//  ProfileService.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/15.
//

import Foundation

protocol ProfileServiceProtocol {
    func profileUser(userId: Int, completion: @escaping (NetworkResult<BaseResponse<ProfileUserResponseDTO>>) -> Void)
    
    func profileFriend(queryDTO: ProfileFriendRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<ProfileFriendResponseDTO>>) -> Void)
}

final class ProfileService: APIRequestLoader<ProfileTarget>, ProfileServiceProtocol {
    func profileUser(userId: Int, completion: @escaping (NetworkResult<BaseResponse<ProfileUserResponseDTO>>) -> Void) {
        fetchData(target: .profileUser(userId: userId),
                  responseData: BaseResponse<ProfileUserResponseDTO>.self, completion: completion)
    }
    
    func profileFriend(queryDTO: ProfileFriendRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<ProfileFriendResponseDTO>>) -> Void) {
        fetchData(target: .profileFriend(queryDTO),
                  responseData: BaseResponse<ProfileFriendResponseDTO>.self, completion: completion)
    }
}

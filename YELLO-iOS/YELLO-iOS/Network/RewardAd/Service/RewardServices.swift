//
//  RewardServices.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2/18/24.
//

import Foundation

protocol RewardServiceProtocol {
    func checkRewardPossible(tag: String, completion: @escaping (NetworkResult<BaseResponse<RewardPossibleResponseDTO>>) -> Void)
    func postRewardAd(requestDTO: RewardRequestDTO, completion: @escaping (NetworkResult<BaseResponse<RewardResponseDTO>>) -> Void)
}

final class RewardServices: APIRequestLoader<RewardTarget>, RewardServiceProtocol {
    func checkRewardPossible(tag: String, completion: @escaping (NetworkResult<BaseResponse<RewardPossibleResponseDTO>>) -> Void) {
        fetchData(target: .rewardPossible(tag),
                  responseData: BaseResponse<RewardPossibleResponseDTO>.self,
                  completion: completion)
    }
    
    func postRewardAd(requestDTO: RewardRequestDTO, completion: @escaping (NetworkResult<BaseResponse<RewardResponseDTO>>) -> Void) {
        fetchData(target: .rewardResult(requestDTO),
                  responseData: BaseResponse<RewardResponseDTO>.self, completion: completion)
    }
    
}

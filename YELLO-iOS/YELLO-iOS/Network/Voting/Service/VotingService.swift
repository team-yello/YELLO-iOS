//
//  VotingService.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/15.
//
import Foundation

protocol VotingServiceProtocol {
    func getVotingAvailable(queryDTO: VotingAvailableRequestDTO, completion: @escaping (NetworkResult<BaseResponse<[VotingAvailableResponseDTO]>>) -> Void)
}


final class VotingService: APIRequestLoader<VotingTarget>, VotingServiceProtocol {
    
    func getVotingAvailable(queryDTO: VotingAvailableRequestDTO, completion: @escaping (NetworkResult<BaseResponse<[VotingAvailableResponseDTO]>>) -> Void) {

        fetchData(
            target: .getVotingAvailable(queryDTO),
            responseData: BaseResponse<[VotingAvailableResponseDTO]>.self, completion: completion)
    }
}


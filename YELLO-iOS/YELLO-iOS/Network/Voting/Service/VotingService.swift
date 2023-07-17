//
//  VotingService.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/15.
//
import Foundation

protocol VotingServiceProtocol {
    func getVotingAvailable(completion: @escaping (NetworkResult<BaseResponse<VotingAvailableResponseDTO>>) -> Void)
    func getVotingSuffle(completion: @escaping (NetworkResult<BaseResponse<[VotingSuffleResponseDTO]>>) -> Void)
    func getVotingList(completion: @escaping (NetworkResult<BaseResponse<[VotingListResponseDTO]>>) -> Void)
    func postVotingAnswerList(requestDTO: VotingAnswerListRequestDTO, completion: @escaping (NetworkResult<BaseResponse<VotingAnswerListResponseDTO>>) -> Void)
}

final class VotingService: APIRequestLoader<VotingTarget>, VotingServiceProtocol {
    func getVotingAvailable(completion: @escaping (NetworkResult<BaseResponse<VotingAvailableResponseDTO>>) -> Void) {

        fetchData(
            target: .getVotingAvailable,
            responseData: BaseResponse<VotingAvailableResponseDTO>.self, completion: completion)
    }
    
    func getVotingSuffle(completion: @escaping (NetworkResult<BaseResponse<[VotingSuffleResponseDTO]>>) -> Void) {
        
        fetchData(
            target: .getVotingSuffle,
            responseData: BaseResponse<[VotingSuffleResponseDTO]>.self, completion: completion)
    }
    func getVotingList(completion: @escaping (NetworkResult<BaseResponse<[VotingListResponseDTO]>>) -> Void) {
        
        fetchData(
            target: .getVotingList,
            responseData: BaseResponse<[VotingListResponseDTO]>.self, completion: completion)
    }
    func postVotingAnswerList(requestDTO: VotingAnswerListRequestDTO, completion: @escaping (NetworkResult<BaseResponse<VotingAnswerListResponseDTO>>) -> Void) {
        
        fetchData(target: .postVotingAnswerList(requestDTO),
                  responseData: BaseResponse<VotingAnswerListResponseDTO>.self, completion: completion)
    }
}

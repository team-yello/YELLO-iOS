//
//  EventService.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2/6/24.
//

import Foundation

protocol EventServiceProtocol {
    
    func lunchEventCheck(completion: @escaping (NetworkResult<BaseResponse<[EventResponseDTO]>>) -> Void)
    func lunchEventStart(requestDTO: EventRequestDTO, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void)
    func eventReward(completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void)
}

final class EventService: APIRequestLoader<EventTarget>, EventServiceProtocol {
    
    func lunchEventCheck(completion: @escaping (NetworkResult<BaseResponse<[EventResponseDTO]>>) -> Void) {
        fetchData(target: .lunchEventCheck, responseData: BaseResponse<[EventResponseDTO]>.self, completion: completion)
    }
    
    func lunchEventStart(requestDTO: EventRequestDTO, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void) {
        fetchData(target: .lunchEventStart(requestDTO),
                  responseData: BaseResponse<String?>.self, completion: completion)
    }
    
    func eventReward(completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void) {
        fetchData(target: .eventReward,
                  responseData: BaseResponse<String?>.self, completion: completion)
    }

}

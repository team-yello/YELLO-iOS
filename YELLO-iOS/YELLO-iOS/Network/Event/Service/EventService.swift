//
//  EventService.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2/6/24.
//

import Foundation

protocol EventServiceProtocol {
    
    func lunchEvent(completion: @escaping (NetworkResult<BaseResponse<[EventResponseDTO]>>) -> Void)
    
}

final class EventService: APIRequestLoader<EventTarget>, EventServiceProtocol {
    
    func lunchEvent(completion: @escaping (NetworkResult<BaseResponse<[EventResponseDTO]>>) -> Void) {
        fetchData(target: .lunchEvent, responseData: BaseResponse<[EventResponseDTO]>.self, completion: completion)
    }
}

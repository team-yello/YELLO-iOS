//
//  NotificationService.swift
//  YELLO-iOS
//
//  Created by 변희주 on 1/28/24.
//

import Foundation

protocol NotificationServiceProtocol {
    
    func userNotification(type: String, completion: @escaping (NetworkResult<BaseResponse<NotificationResponseDTO>>) -> Void)
    
}

final class NotificationService: APIRequestLoader<NotificationTarget>, NotificationServiceProtocol {
    
    func userNotification(type: String, completion: @escaping (NetworkResult<BaseResponse<NotificationResponseDTO>>) -> Void) {
        fetchData(target: .userNotification(type: type), responseData: BaseResponse<NotificationResponseDTO>.self, completion: completion)
    }
}

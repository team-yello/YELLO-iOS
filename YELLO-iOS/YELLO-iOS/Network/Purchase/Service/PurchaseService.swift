//
//  PurchaseService.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/08/17.
//

import Foundation

protocol PurchaseServiceProtocol {

    func purchaseSubscibe(requestDTO: PurchaseRequestDTO, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void)
    
    func purchaseTicket(requestDTO: PurchaseRequestDTO, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void)
    
}

final class PurchaseService: APIRequestLoader<PurchaseTarget>, PurchaseServiceProtocol {
    func purchaseSubscibe(requestDTO: PurchaseRequestDTO, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void) {
        
        fetchData(target: .purchaseSubscibe(requestDTO),
                  responseData: BaseResponse<String?>.self, completion: completion)
    }
    
    func purchaseTicket(requestDTO: PurchaseRequestDTO, completion: @escaping (NetworkResult<BaseResponse<String?>>) -> Void) {
        
        fetchData(target: .purchaseTicket(requestDTO),
                  responseData: BaseResponse<String?>.self, completion: completion)
    }
}

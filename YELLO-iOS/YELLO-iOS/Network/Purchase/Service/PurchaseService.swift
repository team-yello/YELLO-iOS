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
    
    func purchaseSubscibeNeed(completion: @escaping (NetworkResult<BaseResponse<PurchaseSubscibeNeedResponseDTO>>) -> Void)
    
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
    
    func purchaseSubscibeNeed(completion: @escaping (NetworkResult<BaseResponse<PurchaseSubscibeNeedResponseDTO>>) -> Void) {
        fetchData(target: .purchaseSubscibeNeed, responseData: BaseResponse<PurchaseSubscibeNeedResponseDTO>.self, completion: completion)
    }
}

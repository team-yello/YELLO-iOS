//
//  OnboardingService.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/17.
//

import Foundation

import Alamofire

protocol OnboardingServiceProtocol {
    func postTokenChange(queryDTO: KakaoLoginRequestDTO, completion: @escaping (NetworkResult<BaseResponse<[KakaoLoginResponseDTO]>>) -> Void)
    func getCheckDuplicate(queryDTO: IdValidRequestQueryDTO, completion: @escaping (NetworkResult<IDValidResponseDTO>) -> Void)
    func postUserInfo(queryDTO: SignInRequestDTO, completion: @escaping (NetworkResult<BaseResponse<[SignInResponseDTO]>>) -> Void)
    func getSchoolList(queryDTO: SchoolSearchRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<SchoolSearchResponseDTO>>) -> Void)
    func getMajorList(queryDTO: MajorSearchRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<MajorSearchResponseDTO>>) -> Void)
}

final class OnboardingService: APIRequestLoader<OnboardingTarget>, OnboardingServiceProtocol {
    
    func postTokenChange(queryDTO: KakaoLoginRequestDTO, completion: @escaping (NetworkResult<BaseResponse<[KakaoLoginResponseDTO]>>) -> Void) {
        fetchData(target: .postTokenChange(queryDTO), responseData: BaseResponse<[KakaoLoginResponseDTO]>.self, completion: completion)
    }
    
    func getCheckDuplicate(queryDTO: IdValidRequestQueryDTO, completion: @escaping (NetworkResult<IDValidResponseDTO>) -> Void) {
        fetchData(target: .getCheckDuplicate(queryDTO), responseData: IDValidResponseDTO.self, completion: completion)
    }
    
    func postUserInfo(queryDTO: SignInRequestDTO, completion: @escaping (NetworkResult<BaseResponse<[SignInResponseDTO]>>) -> Void) {
        fetchData(target: .postUserInfo("", queryDTO), responseData: BaseResponse<[SignInResponseDTO]>.self, completion: completion)
    }
    
    func getSchoolList(queryDTO: SchoolSearchRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<SchoolSearchResponseDTO>>) -> Void) {
        fetchData(target: .getSchoolList(queryDTO), responseData: BaseResponse<SchoolSearchResponseDTO>.self, completion: completion)
    }
    
    func getMajorList(queryDTO: MajorSearchRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<MajorSearchResponseDTO>>) -> Void) {
        fetchData(target: .getMajorList(queryDTO), responseData: BaseResponse<MajorSearchResponseDTO>.self, completion: completion)
    }
    
}

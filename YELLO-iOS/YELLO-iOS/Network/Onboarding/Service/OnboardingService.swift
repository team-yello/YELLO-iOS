//
//  OnboardingService.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/17.
//

import Foundation

import Alamofire

protocol OnboardingServiceProtocol {
    func postTokenChange(queryDTO: KakaoLoginRequestDTO, completion: @escaping (NetworkResult<BaseResponse<KakaoLoginResponseDTO>>) -> Void)
    func getCheckDuplicate(queryDTO: IdValidRequestQueryDTO, completion: @escaping (NetworkResult<IDValidResponseDTO>) -> Void)
    func postUserInfo(requestDTO: SignUpRequestDTO, completion: @escaping (NetworkResult<BaseResponse<SignUpResponseDTO>>) -> Void)
    func getSchoolList(queryDTO: SchoolSearchRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<SchoolSearchResponseDTO>>) -> Void)
    func getMajorList(queryDTO: MajorSearchRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<MajorSearchResponseDTO>>) -> Void)
    func postJoinedFriends(queryDTO: JoinedFriendsRequestQueryDTO, requestDTO: JoinedFriendsRequestDTO, completion: @escaping (NetworkResult<BaseResponse<JoinedFriendsResponseDTO>>) -> Void)
    func postRefreshToken(completion: @escaping (NetworkResult<BaseResponse<TokenRefreshResponseDTO>>)->Void)
}

final class OnboardingService: APIRequestLoader<OnboardingTarget>, OnboardingServiceProtocol {
    
    func postTokenChange(queryDTO: KakaoLoginRequestDTO, completion: @escaping (NetworkResult<BaseResponse<KakaoLoginResponseDTO>>) -> Void) {
        fetchData(target: .postTokenChange(queryDTO), responseData: BaseResponse<KakaoLoginResponseDTO>.self, completion: completion)
    }
    
    func getCheckDuplicate(queryDTO: IdValidRequestQueryDTO, completion: @escaping (NetworkResult<IDValidResponseDTO>) -> Void) {
        fetchData(target: .getCheckDuplicate(queryDTO), responseData: IDValidResponseDTO.self, completion: completion)
    }
    
    func postUserInfo(requestDTO: SignUpRequestDTO, completion: @escaping (NetworkResult<BaseResponse<SignUpResponseDTO>>) -> Void) {
        fetchData(target: .postUserInfo(requestDTO), responseData: BaseResponse<SignUpResponseDTO>.self, completion: completion)
    }
    
    func getSchoolList(queryDTO: SchoolSearchRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<SchoolSearchResponseDTO>>) -> Void) {
        fetchData(target: .getSchoolList(queryDTO), responseData: BaseResponse<SchoolSearchResponseDTO>.self, completion: completion)
    }
    
    func getMajorList(queryDTO: MajorSearchRequestQueryDTO, completion: @escaping (NetworkResult<BaseResponse<MajorSearchResponseDTO>>) -> Void) {
        fetchData(target: .getMajorList(queryDTO), responseData: BaseResponse<MajorSearchResponseDTO>.self, completion: completion)
    }
    
    func postJoinedFriends(queryDTO: JoinedFriendsRequestQueryDTO, requestDTO: JoinedFriendsRequestDTO, completion: @escaping (NetworkResult<BaseResponse<JoinedFriendsResponseDTO>>) -> Void) {
        fetchData(target: .postFirendsList(queryDTO, requestDTO), responseData: BaseResponse<JoinedFriendsResponseDTO>.self, completion: completion)
    }
    
    func postRefreshToken(completion: @escaping (NetworkResult<BaseResponse<TokenRefreshResponseDTO>>) -> Void) {
        fetchData(target: .postRefreshToken, responseData: BaseResponse<TokenRefreshResponseDTO>.self, completion: completion)
    }
    
}

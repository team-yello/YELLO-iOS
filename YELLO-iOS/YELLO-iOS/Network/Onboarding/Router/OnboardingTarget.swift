//
//  OnboardingTarget.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/15.
//

import Foundation
import Alamofire

@frozen
enum OnboardingTarget {
    case postTokenChange(_ dto: KakaoLoginRequestDTO) /// 소셜로그인
    case getSchoolList(_ dto: SchoolSearchRequestQueryDTO) /// 학교 검색
    case getMajorList(_ dto: MajorSearchRequestQueryDTO) /// 학과 검색
    case getCheckDuplicate(_ dto: IdValidRequestQueryDTO) /// 아이디 중복 확인
    case postFirendsList( _ query: JoinedFriendsRequestQueryDTO, _ dto: JoinedFriendsRequestDTO) /// 가입한 친구 목록 불러오기
    case postUserInfo(_ accessToken: String, _ requestDTO: SignInRequestDTO ) /// 회원가입
}

extension OnboardingTarget: TargetType {
    var headerType: HTTPHeaderType {
        switch self {
        case .postTokenChange(let _):
            return .hasAccessToken
        case .getSchoolList(let _):
            return .plain
        case .getMajorList(let _):
            return .plain
        case .getCheckDuplicate(let _):
            return .hasAccessToken
        case .postFirendsList(let _):
            return .plain
        case .postUserInfo(let _, let _2):
            return .hasAccessToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postTokenChange:
            return .post
        case .getSchoolList:
            return .get
        case .getMajorList(_):
            return .get
        case .getCheckDuplicate:
            return .get
        case .postFirendsList(_):
            return .post
        case .postUserInfo:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .postTokenChange(_):
            return "/auth/oauth"
        case .getSchoolList(let dto):
            return "/auth/school/school"
        case .getCheckDuplicate(let id):
            return "/auth/valid"
        case .postUserInfo(_, _):
            return "/auth/signup"
        case .getMajorList(_):
            return "/auth/school/department"
        case .postFirendsList(_):
            return "/auth/friend"
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .postTokenChange(let dto):
            return .requestWithBody(dto)
        case .getSchoolList(let dto):
            return .requestQuery(dto)
        case .getCheckDuplicate(let dto):
            return .requestQuery(dto)
        case .postUserInfo(let acessToken, let dto):
            return .requestQueryWithBody(acessToken, bodyParameter: dto)
        case .getMajorList(let dto):
            return .requestQuery(dto)
        case .postFirendsList(let query, let dto):
            return .requestQueryWithBody(query, bodyParameter: dto)
        }
    }
}

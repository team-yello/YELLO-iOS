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
    case postUserInfo(_ dto: SignUpRequestDTO ) /// 회원가입
}

extension OnboardingTarget: TargetType {
    var headerType: HTTPHeaderType {
        switch self {
        case .postTokenChange:
            return .plain
        case .getSchoolList:
            return .plain
        case .getMajorList:
            return .plain
        case .getCheckDuplicate:
            return .hasAccessToken
        case .postFirendsList:
            return .plain
        case .postUserInfo:
            return .hasAccessToken
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postTokenChange:
            return .post
        case .getSchoolList:
            return .get
        case .getMajorList:
            return .get
        case .getCheckDuplicate:
            return .get
        case .postFirendsList:
            return .post
        case .postUserInfo:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .postTokenChange:
            return "/auth/oauth"
        case .getSchoolList:
            return "/auth/school/school"
        case .getCheckDuplicate:
            return "/auth/valid"
        case .postUserInfo:
            return "/auth/signup"
        case .getMajorList:
            return "/auth/school/department"
        case .postFirendsList:
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
        case .postUserInfo(let dto):
            return .requestWithBody(dto)
        case .getMajorList(let dto):
            return .requestQuery(dto)
        case .postFirendsList(let query, let dto):
            return .requestQueryWithBody(query, bodyParameter: dto)
        }
    }
}

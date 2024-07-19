//
//  NetworkResult.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/06/26.
//

import Foundation

enum NetworkResult<T> {
    case success(T)     // 서버 통신 성공
    case requestErr(statusCode: Int)  // 요청에러 발생
    case pathErr // 경로 에러
    case serverErr(statusCode: Int)  // 서버 내부 에러
    case networkErr // 네트워크 연결 실패
    case failure // 실패
}

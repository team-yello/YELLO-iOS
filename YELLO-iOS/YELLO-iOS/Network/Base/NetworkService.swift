//
//  NetworkService.swift
//  YELLO-iOS
//
//  Created by 변희주 on 2023/07/15.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()

    private init() {}

    let votingService: VotingServiceProtocol = VotingService(apiLogger: APIEventLogger())
    let onboardingService: OnboardingServiceProtocol = OnboardingService(apiLogger: APIEventLogger())
    let aroundService: AroundServiceProtocol = AroundService(apiLogger: APIEventLogger())
    let recommendingService: RecommendingServiceProtocol = RecommendingService(apiLogger: APIEventLogger())
    let searchService: SearchServiceProtocol = SearchService(apiLogger: APIEventLogger())
    let myYelloService: MyYelloServiceProtocol = MyYelloService(apiLogger: APIEventLogger())
    let profileService: ProfileServiceProtocol = ProfileService(apiLogger: APIEventLogger())
    let purchaseService: PurchaseServiceProtocol = PurchaseService(apiLogger: APIEventLogger())
}

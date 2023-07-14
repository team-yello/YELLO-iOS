//
//  MyProfileFriendModel.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/14.
//

import Foundation

struct MyProfileFriendModel {
    let id: Int
    let friendName: String
    let friendProfileImage: String?
    let friendGroup: String
    let yelloId: String
    let yelloCount: Int
    let friendCount: Int
}

var myProfileFriendModelDummy: [MyProfileFriendModel] =
[MyProfileFriendModel(id: 1, friendName: "정채은", friendProfileImage: "https://blogpfthumb-phinf.pstatic.net/MjAyMjEwMjBfOCAg/MDAxNjY2MjU5NDAyNDM5.bKNb_vCeAwZz248m7c2iaHFS2-TV9iqN6tkJeO1CoHEg.VKQtm2rfXLiCcE3QLk43kOY6EmPd-FpqJe65yt1QFZYg.PNG.mymo_od/profileImage.png?type=s1", friendGroup: "이화여자대학교 융합콘텐츠학과 20학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
 MyProfileFriendModel(id: 2, friendName: "이지희", friendProfileImage: nil, friendGroup: "숭실대학교 글로벌미디어학과 19학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
 MyProfileFriendModel(id: 3, friendName: "김효원", friendProfileImage: "https://postfiles.pstatic.net/MjAyMzA3MDNfNjYg/MDAxNjg4Mzc4Njc5OTk0.QMGDXIgUlEgoIiS72eYHFVwyG1uxjvz_V_OJiz_Ng0Yg.RY163oyuPRQw1gqvB6Q6I472_QT-EyLlHGh8MtvZsTEg.JPEG.mymo_od/IMG_4750.jpg?type=w966", friendGroup: "이화여자대학교 융합콘텐츠학과 20학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
 MyProfileFriendModel(id: 4, friendName: "변희주", friendProfileImage: "https://blogpfthumb-phinf.pstatic.net/MjAyMjEwMjBfOCAg/MDAxNjY2MjU5NDAyNDM5.bKNb_vCeAwZz248m7c2iaHFS2-TV9iqN6tkJeO1CoHEg.VKQtm2rfXLiCcE3QLk43kOY6EmPd-FpqJe65yt1QFZYg.PNG.mymo_od/profileImage.png?type=s1", friendGroup: "숭실대학교 글로벌미디어학과 19학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
 MyProfileFriendModel(id: 5, friendName: "이의제", friendProfileImage: nil, friendGroup: "이화여자대학교 융합콘텐츠학과 20학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
 MyProfileFriendModel(id: 6, friendName: "김효원", friendProfileImage: "https://blogpfthumb-phinf.pstatic.net/MjAyMjEwMjBfOCAg/MDAxNjY2MjU5NDAyNDM5.bKNb_vCeAwZz248m7c2iaHFS2-TV9iqN6tkJeO1CoHEg.VKQtm2rfXLiCcE3QLk43kOY6EmPd-FpqJe65yt1QFZYg.PNG.mymo_od/profileImage.png?type=s1", friendGroup: "숭실대학교 글로벌미디어학과 19학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
 MyProfileFriendModel(id: 7, friendName: "김상호", friendProfileImage: "https://blogpfthumb-phinf.pstatic.net/MjAyMjEwMjBfOCAg/MDAxNjY2MjU5NDAyNDM5.bKNb_vCeAwZz248m7c2iaHFS2-TV9iqN6tkJeO1CoHEg.VKQtm2rfXLiCcE3QLk43kOY6EmPd-FpqJe65yt1QFZYg.PNG.mymo_od/profileImage.png?type=s1", friendGroup: "이화여자대학교 융합콘텐츠학과 20학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
 MyProfileFriendModel(id: 8, friendName: "전채연", friendProfileImage: nil, friendGroup: "숭실대학교 글로벌미디어학과 19학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
 MyProfileFriendModel(id: 9, friendName: "박민주", friendProfileImage: "https://postfiles.pstatic.net/MjAyMzA3MDNfNjYg/MDAxNjg4Mzc4Njc5OTk0.QMGDXIgUlEgoIiS72eYHFVwyG1uxjvz_V_OJiz_Ng0Yg.RY163oyuPRQw1gqvB6Q6I472_QT-EyLlHGh8MtvZsTEg.JPEG.mymo_od/IMG_4750.jpg?type=w966", friendGroup: "이화여자대학교 융합콘텐츠학과 20학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
 MyProfileFriendModel(id: 10, friendName: "강국희", friendProfileImage: nil, friendGroup: "숭실대학교 글로벌미디어학과 19학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99),
 MyProfileFriendModel(id: 11, friendName: "김나현", friendProfileImage: "https://postfiles.pstatic.net/MjAyMzA3MDNfNjYg/MDAxNjg4Mzc4Njc5OTk0.QMGDXIgUlEgoIiS72eYHFVwyG1uxjvz_V_OJiz_Ng0Yg.RY163oyuPRQw1gqvB6Q6I472_QT-EyLlHGh8MtvZsTEg.JPEG.mymo_od/IMG_4750.jpg?type=w966", friendGroup: "이화여자대학교 융합콘텐츠학과 20학번", yelloId: "@chaneotopia", yelloCount: 20, friendCount: 99)] {
    didSet {
        FriendCountView().friendCountLabel.text = String(myProfileFriendModelDummy.count) + "명"
    }
}

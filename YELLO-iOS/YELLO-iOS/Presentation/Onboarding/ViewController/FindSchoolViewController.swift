//
//  FindSchoolViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/05.
//

import UIKit

class FindSchoolViewController: SearchBaseViewController {
    
    var allSchool: [String] = ["서울대학교", "서울과학기술대학교", "서울교육대학교", "서울여자대학교", "이화여자대학교", "고려대학교", "연세대학교", "숭실대학교", "홍익대학교"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.customView(titleText: "우리 학교 검색하기", helperText: "우리 학교가 없나요? 학교를 추가해보세요!", allArr: allSchool)
    }
    
}

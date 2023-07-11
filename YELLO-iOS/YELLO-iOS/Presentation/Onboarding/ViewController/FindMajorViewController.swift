//
//  FindMajorViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 2023/07/11.
//

import UIKit

class FindMajorViewController: SearchBaseViewController {
    
    var allMajor: [String] = ["컴퓨터공학과", "컴퓨터학부", "소프트웨어학과", "글로벌미디어학부", "응용소프트웨어학부"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.customView(titleText: "학과 검색하기", helperText: "찾는 과가 없다면 클릭하세요!", allArr: allMajor)
    }
}

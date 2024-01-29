//
//  EditProfileViewController.swift
//  YELLO-iOS
//
//  Created by 지희의 MAC on 1/25/24.
//

import UIKit

class EditProfileViewController: UIViewController {
    
    let editProfileView = EditProfileView()
    
    override func loadView() {
        self.view = editProfileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

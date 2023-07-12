//
//  MyYelloNameTableViewCell.swift
//  YELLO-iOS
//
//  Created by 정채은 on 2023/07/12.
//

import UIKit

class MyYelloNameTableViewCell: UITableViewCell {

    static let identifier = "MyYelloNameTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setStyle()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setStyle() {
        
    }
    
    private func setLayout() {
        
    }
}

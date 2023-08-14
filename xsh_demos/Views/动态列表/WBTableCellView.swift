//
//  WBTableCellView.swift
//  xsh_demos
//
//  Created by xushihao on 2023/8/13.
//

import Foundation
import UIKit
import Masonry

class WBTableCellView: UITableViewCell {
    
    
    var avatarView: UIImageView
    var authorLabel: UILabel //标题
    var timeLabel: UILabel
    var detailLabel: UILabel
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        avatarView = UIImageView()
        authorLabel = UILabel()
        timeLabel = UILabel()
        detailLabel = UILabel()
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        contentView.mas_makeConstraints { make in
            make?.width.equalTo()(UIScreen.main.bounds.width - 80)
        }
        contentView.addSubview(avatarView)
        //圆形头像
        avatarView.layer.cornerRadius = 25
        avatarView.clipsToBounds = true
        avatarView.mas_makeConstraints { make in
            make?.width.equalTo()(50)
            make?.height.equalTo()(50)
            make?.left.equalTo()(contentView)?.offset()(5)
        }
        contentView.addSubview(authorLabel)
        authorLabel.mas_makeConstraints { make in
            make?.width.equalTo()(contentView)
            make?.height.equalTo()(20)
            make?.left.equalTo()(avatarView.mas_right)?.offset()(5)
        }
        contentView.addSubview(timeLabel)
        timeLabel.mas_makeConstraints { make in
            make?.width.equalTo()(contentView)
            make?.height.equalTo()(20)
            make?.top.equalTo()(authorLabel.mas_bottom)?.offset()(5)
            make?.left.equalTo()(avatarView.mas_right)?.offset()(5)
        }
        contentView.addSubview(detailLabel)
        detailLabel.mas_makeConstraints { make in
            make?.width.equalTo()(contentView)
            make?.height.lessThanOrEqualTo()(200)
            make?.top.equalTo()(timeLabel.mas_bottom)?.offset()(10)
            make?.left.equalTo()(avatarView.mas_right)?.offset()(5)
        }
        // 设置自动换行
        detailLabel.lineBreakMode = .byWordWrapping
        detailLabel.numberOfLines = 0
    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

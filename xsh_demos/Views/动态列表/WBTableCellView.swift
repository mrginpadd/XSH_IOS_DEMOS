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
    
    
    lazy var avatarView: UIImageView = {
        let view = UIImageView.init()
        return view
    }()
    lazy var authorLabel: UILabel = { //标题
        let view = UILabel()
        return view
    }()
    lazy var timeLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    lazy var detailLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    

    var model: WBMsgModel {
        didSet {
            authorLabel.text = model.nickname
            timeLabel.text = model.timestamp
            
            //超过300字显示查看全文按钮
            let originalText: String = model.content
            let showMoreText: String = "查看全文"
            let maxLen = 100
            if originalText.count > maxLen {
                let showText: String = String(originalText.prefix(maxLen))
                let attributedText = NSMutableAttributedString(string: showText)
                attributedText.append(NSAttributedString(string: "...", attributes: nil))
                attributedText.append(NSAttributedString(string: showMoreText, attributes: [.foregroundColor: UIColor.blue]))
                attributedText.addAttribute(.link, value: "showFullText", range: NSRange(location: "\(showText)...".count, length: showMoreText.count))
                
                detailLabel.numberOfLines = 0
                detailLabel.attributedText = attributedText
                detailLabel.isUserInteractionEnabled = true
    //            cell?.detailLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showAllText(_:))))
            } else {
                detailLabel.numberOfLines = 0
                detailLabel.text  = originalText
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        //TODO: 该行代码待优化
        self.model = WBMsgModel(dictionary: [:])
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

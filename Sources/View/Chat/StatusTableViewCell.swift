//
//  StatusTableViewCell.swift
//  GetStreamChat
//
//  Created by Alexey Bukhtin on 12/04/2019.
//  Copyright © 2019 Stream.io Inc. All rights reserved.
//

import UIKit
import SnapKit

final class StatusTableViewCell: UITableViewCell, Reusable {
    
    private let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .chatBoldXSmall
        label.textColor = .chatGray
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = .chatXXSmall
        label.textColor = .chatGray
        titleLabel.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
        
        return label
    }()
    
    override func prepareForReuse() {
        reset()
        super.prepareForReuse()
    }
    
    public func reset() {
        titleLabel.text = nil
        subtitleLabel.text = nil
    }
    
    func setup() {
        let line1 = createLineView()
        let line2 = createLineView()
        
        let stackView = UIStackView(arrangedSubviews: [line1, titleLabel, line2])
        stackView.axis = .horizontal
        stackView.spacing = .messageStatusSpacing
        stackView.alignment = .center
        
        addSubview(stackView)
        line1.snp.makeConstraints { $0.width.equalTo(line2) }

        stackView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(CGFloat.messageStatusSpacing)
            make.top.equalToSuperview().offset(2 * CGFloat.messageEdgePadding)
            make.right.equalToSuperview().offset(-CGFloat.messageStatusSpacing)
            make.bottom.equalToSuperview().offset(-3 * CGFloat.messageEdgePadding)
        }
    }
    
    private func createLineView() -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = (backgroundColor?.isDark ?? false) ? .chatDarkGray : .chatSuperLightGray
        view.snp.makeConstraints { $0.height.equalTo(CGFloat.messageStatusLineWidth).priority(999) }
        return view
    }
    
    public func update(title: String, subtitle: String? = nil) {
        if titleLabel.superview == nil {
            setup()
        }
        
        titleLabel.text = title.uppercased()
        
        if let subtitle = subtitle {
            subtitleLabel.text = subtitle.uppercased()
        }
    }
}
//
//  ToastMessageView.swift
//  SignUp
//
//  Created by 안준경 on 4/20/25.
//

import UIKit
import SnapKit

final class ToastMessageView: UIView {
    
    // MARK: UI 컴포넌트
    let toastLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.sizeToFit()
        return label
    }()
    
    // MARK: initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI 제약조건
    private func setup() {
        backgroundColor = .gray
        layer.cornerRadius = 16
        isHidden = true
                
        addSubview(toastLabel)
        
        self.snp.makeConstraints {
            $0.width.equalTo(toastLabel.snp.width).multipliedBy(1.15)
            $0.height.equalTo(toastLabel.snp.height).multipliedBy(2)
        }
        
        toastLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}

extension ToastMessageView {
    // 토스트 메세지 띄우기
    func showToastMessage(_ message: String) {
        UIView.animate(withDuration: 1.0, delay: 1.5, options: .curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 0.0
            self.toastLabel.text = message
        }) { _ in
            self.isHidden = true
            self.alpha = 1
        }
    }
}

//
//  MainView.swift
//  SignUp
//
//  Created by 안준경 on 4/19/25.
//

import UIKit
import SnapKit

final class MainView: UIView {
    
    // MARK: UI 컴포넌트
    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시작하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: initializer
    init() {
        super.init(frame: .zero)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI 제약조건
    private func setUp() {
        backgroundColor = .white
        
        addSubview(startButton)
        
        startButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(60)
        }
    }
}

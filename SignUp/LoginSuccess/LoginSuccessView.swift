//
//  LoginSuccessView.swift
//  SignUp
//
//  Created by 안준경 on 4/18/25.
//

import UIKit
import SnapKit

final class LoginSuccessView: UIView {
    
    // MARK: UI 컴포넌트
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.tintColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("로그아웃", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    let withdrawButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원탈퇴", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: initializer
    init(nickname: String) {
        super.init(frame: .zero)
        setUpTitle(nickname: nickname)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI 제약조건
    private func setUp() {
        backgroundColor = .white
        
        [titleLabel,
         logoutButton,
         withdrawButton
        ].forEach {
            addSubview($0)
        }
        
        // titleLabel
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(70)
            $0.width.equalToSuperview()
        }
        
        // logoutButton
        logoutButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(150)
            $0.trailing.equalTo(self.snp.centerX).offset(-20)
            $0.width.equalTo(140)
            $0.height.equalTo(40)
        }

        // resignButton
        withdrawButton.snp.makeConstraints {
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(150)
            $0.leading.equalTo(self.snp.centerX).offset(20)
            $0.width.equalTo(140)
            $0.height.equalTo(40)
        }
    }
    
    private func setUpTitle(nickname: String) {
        titleLabel.text = "\(nickname)님 환영합니다."
    }
    
}

//
//  SignUpView.swift
//  SignUp
//
//  Created by 안준경 on 4/18/25.
//

import UIKit
import SnapKit

final class SignUpView: UIView {
    
    // MARK: UI 컴포넌트
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "회원가입"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.text = "아이디"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let id: UITextField = {
        let textField = UITextField()
        textField.placeholder = "아이디를 입력하세요"
        textField.font = .systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let password: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호를 입력하세요"
        textField.font = .systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = "비밀번호 확인"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let confirmPassword: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호 확인"
        textField.font = .systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private let nickname: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력하세요"
        textField.font = .systemFont(ofSize: 14)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("회원가입", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    
    // MARK: initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI 제약조건
    private func setUp(){
        backgroundColor = .white
        
        [idLabel, id,
         passwordLabel, password,
         confirmPasswordLabel, confirmPassword,
         nicknameLabel, nickname
        ].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
        [titleLabel,
         verticalStackView,
         signUpButton
        ].forEach {
            addSubview($0)
        }
        
        // titleLabel
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.height.equalTo(50)
            $0.width.equalTo(100)
        }
        
        // stackView
        verticalStackView.snp.makeConstraints {
            $0.centerX.equalTo(safeAreaLayoutGuide)
            $0.width.equalTo(safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.height.equalTo(300)
        }
        
        // id
        idLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
        
        id.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        // password
        passwordLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
        
        password.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
        
        // confirmPassword
        confirmPasswordLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
        
        confirmPassword.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
        
        // nickname
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
        
        nickname.snp.makeConstraints {
            $0.leading.equalToSuperview()
        }
        
        // signUpButton
        signUpButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(150)
            $0.width.equalTo(140)
            $0.height.equalTo(40)
        }
    }
    
}

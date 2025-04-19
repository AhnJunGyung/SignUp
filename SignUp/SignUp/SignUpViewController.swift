//
//  SignUpViewController.swift
//  SignUp
//
//  Created by 안준경 on 4/18/25.
//

import UIKit
import SnapKit
import RxSwift

final class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()
    private let disposeBag = DisposeBag()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = signUpView
        tapSignUpButton()
    }
    
    // MARK: 회원가입
    private func signUp() {
        let loginSuccessVC = LoginSuccessViewController(name: "회원")
        navigationController?.setViewControllers([loginSuccessVC], animated: false)
    }
    
    // MARK: 회원가입 버튼 탭
    private func tapSignUpButton() {
        signUpView.signUpButton.rx.tap
            .subscribe(onNext: { [weak self] _ in
//                self?.signUp()
                
                self?.isValidId()
            }).disposed(by: disposeBag)
    }
    
    // MARK: 아이디 검증
    private func isValidId() -> Bool{
        
        guard let email = signUpView.id.text else {
            return false
        }
        
        // 이메일 형식 검증
        guard email.contains("@"), let atIndex = email.firstIndex(of: "@") else {
            return false
        }
        
        let id = email[..<atIndex]
        
        // 아이디 6자~20자
        guard id.count >= 6 && id.count <= 20 else {
            return false
        }
        
        // 정규표현식 : 영어 소문자 시작, 숫자 포함 6~20자
        let regexOfId = "^[a-z][a-z0-9]{5,19}$"
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regexOfId)
        
        guard predicate.evaluate(with: String(id)) else {
            return false
        }
        
        return true
    }
    
    // MARK: 비밀번호 검증
    private func isValidPassword() -> Bool {
        return true
    }

    
    
}

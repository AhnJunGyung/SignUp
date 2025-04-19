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
        
        guard let email = signUpView.email.text else { return }
        guard let password = signUpView.password.text else { return }
        guard let nickname = signUpView.nickname.text else { return }
        
        let userData = UserData(email: email,
                                password: password,
                                nickname: nickname)
        
        let signUpDataService = SignUpDataService()
        signUpDataService.saveUser(userData: userData)
        
        loginSuccess(userdata: userData)
    }
    
    // MARK: 로그인 성공화면 이동
    private func loginSuccess(userdata: UserData) {
        let loginSuccessVC = LoginSuccessViewController(userData: userdata)
        navigationController?.setViewControllers([loginSuccessVC], animated: false)
    }
    
    // MARK: 회원가입 버튼 탭
    private func tapSignUpButton() {
        signUpView.signUpButton.rx.tap
            .subscribe(onNext: { [weak self] _ in

                if let validCheck = self?.isValidSignUp(), validCheck == true {
                    self?.signUp()
                }
                
            }).disposed(by: disposeBag)
    }
    
    // MARK: 회원가입 검증
    private func isValidSignUp() -> Bool {
        if !isValidId() { return false }
        if !isValidPassword() { return false }
        if !isValidNickname() { return false }
        
        return true
    }
    
    // MARK: 아이디 검증
    private func isValidId() -> Bool{
        // 이메일 입력 체크
        guard let email = signUpView.email.text else {
            print("이메일 비었음")
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
        // 비밀번호 입력 체크
        guard let password = signUpView.password.text else {
            print("비밀번호 비었음")
            return false
        }
        
        // 비밀번호 검증 : 8자 이상
        guard password.count >= 8 else {
            return false
        }
        
        // 비밀번호 확인 입력 체크
        guard let confirmPassword = signUpView.confirmPassword.text else {
            print("비밀번호 확인 비었음")
            return false
        }
        
        // 비밀번호 & 비밀번호 확인 비교
        guard password == confirmPassword else {
            return false
        }
        
        return true
    }

    // MARK: 닉네임 검증
    private func isValidNickname() -> Bool {
        if signUpView.nickname.text == ""  {
            return false
        }
        
        return true
    }
    
}

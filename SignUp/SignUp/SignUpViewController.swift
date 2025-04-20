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
        updateSignUpButtonState()
    }
}

// MARK: 메서드
extension SignUpViewController {
    
    // MARK: 회원가입 버튼 상태 업데이트
    private func updateSignUpButtonState() {
        let allFieldsFilled = Observable
            .combineLatest(
                signUpView.email.rx.text.orEmpty,
                signUpView.password.rx.text.orEmpty,
                signUpView.confirmPassword.rx.text.orEmpty,
                signUpView.nickname.rx.text.orEmpty
            )
            .map { email, password, confirmPassword, nickname in
                return !email.isEmpty &&
                       !password.isEmpty &&
                       !confirmPassword.isEmpty &&
                       !nickname.isEmpty
            }
            .distinctUntilChanged()
        
        // 버튼 활성/비활성 상태 바인딩
        allFieldsFilled
            .bind(to: signUpView.signUpButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        // 버튼 비활성화시 흐리게
        allFieldsFilled
            .map { $0 ? 1.0 : 0.5 }
            .bind(to: signUpView.signUpButton.rx.alpha)
            .disposed(by: disposeBag)
    }

    
    // MARK: 회원가입
    private func signUp() {
        
        guard let email = signUpView.email.text else { return }
        guard let password = signUpView.password.text else { return }
        guard let nickname = signUpView.nickname.text else { return }
        
        let userData = UserData(email: email,
                                password: password,
                                nickname: nickname)
        
        // CoreData 저장
        let userDataService = UserDataService()
        userDataService.saveUser(userData: userData)
        
        // UserDefaults 저장
        let loginUserDefaultsService = LoginUserDefaultsService()
        loginUserDefaultsService.saveUserData(userData: userData)
        
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
            .throttle(.seconds(3), scheduler: MainScheduler.asyncInstance)
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
        return true
    }
    
    // MARK: 아이디 검증
    private func isValidId() -> Bool{
        
        guard let email = signUpView.email.text else {
            return false
        }
        
        // 이메일 형식 검증
        guard email.contains("@"), let atIndex = email.firstIndex(of: "@") else {
            signUpView.toastMessageView.showToastMessage("이메일 형식인지 확인하세요.")
            return false
        }
        
        let id = email[..<atIndex]
        
        // 아이디 6자~20자
        guard id.count >= 6 && id.count <= 20 else {
            signUpView.toastMessageView.showToastMessage("아이디 글자수를 확인하세요.")
            return false
        }
        
        // 정규표현식 : 영문 소문자 시작, 숫자 포함 6~20자
        let regexOfId = "^[a-z][a-z0-9]{5,19}$"
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regexOfId)
        
        guard predicate.evaluate(with: String(id)) else {
            signUpView.toastMessageView.showToastMessage("아이디 생성 규칙을 확인하세요.")
            return false
        }
        
        // 아이디 중복 체크
        let userDataService = UserDataService()
        print(userDataService.isExisitingUser(email: email))
        if userDataService.isExisitingUser(email: email) {
            signUpView.toastMessageView.showToastMessage("존재하는 아이디가 있습니다.")
            return false
        }
        
        return true
    }
    
    // MARK: 비밀번호 검증
    private func isValidPassword() -> Bool {
        
        guard let password = signUpView.password.text else {
            return false
        }
        
        // 비밀번호 검증 : 8자 이상
        guard password.count >= 8 else {
            signUpView.toastMessageView.showToastMessage("비밀번호를 8자 이상 입력하세요.")
            return false
        }
        
        guard let confirmPassword = signUpView.confirmPassword.text else {
            return false
        }
        
        // 비밀번호 & 비밀번호 확인 비교
        guard password == confirmPassword else {
            signUpView.toastMessageView.showToastMessage("비밀번호가 일치하지 않습니다.")
            return false
        }
        
        return true
    }
}

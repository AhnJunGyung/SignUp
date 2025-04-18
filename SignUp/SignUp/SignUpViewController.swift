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
                self?.signUp()
            }).disposed(by: disposeBag)
    }
}

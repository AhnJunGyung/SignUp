//
//  LoginSuccessViewController.swift
//  SignUp
//
//  Created by 안준경 on 4/18/25.
//

import UIKit
import SnapKit
import RxSwift

final class LoginSuccessViewController: UIViewController {
    
    private let loginSuccessView: LoginSuccessView?
    private let loginUser: UserData?
    private let loginUserDefaultsService = LoginUserDefaultsService()
    private let disposeBag = DisposeBag()
    
    // MARK: initializer
    init(userData: UserData) {
        self.loginUser = userData
        loginSuccessView = LoginSuccessView(nickname: userData.nickname)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginSuccessView
        tapLogoutButton()
        withdrawButton()
    }
    
    // MARK: 로그아웃 버튼 탭
    private func tapLogoutButton() {
        loginSuccessView?.logoutButton.rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.navigateToMain()
            }).disposed(by: disposeBag)
    }
    
    // MARK: 회원탈퇴 버튼 탭
    private func withdrawButton() {
        loginSuccessView?.withdrawButton.rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.withdrawUser()
                self?.navigateToMain()
            }).disposed(by: disposeBag)
    }
    
    // MARK: 회원탈퇴
    private func withdrawUser() {
        let userDataService = UserDataService()
        
        guard let email = loginUser?.email else {
            return
        }
        
        // CoreDate 삭제
        userDataService.deleteUser(email: email)
        
        // UserDefaults 삭제
        loginUserDefaultsService.deleteUser()
    }
    
    // MARK:
    private func navigateToMain() {
        let mainVC = MainViewController()
        navigationController?.setViewControllers([mainVC], animated: false)
    }
    
}

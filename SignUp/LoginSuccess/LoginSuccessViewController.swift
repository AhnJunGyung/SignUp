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
    private let disposeBag = DisposeBag()
    
    // MARK: initializer
    init(userData: UserData) {
        loginSuccessView = LoginSuccessView(nickname: userData.nickname)
        super.init(nibName: nil, bundle: nil)
        
        //fetch 테스트
        let dataService = SignUpDataService()
        let user = dataService.fetchUser(email: userData.email)
        print(user!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginSuccessView
        tapLogoutButton()
    }
    
    // MARK: 로그아웃 버튼 탭
    private func tapLogoutButton() {
        loginSuccessView?.logoutButton.rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.logout()
            }).disposed(by: disposeBag)
    }
    
    // MARK: 로그아웃
    private func logout() {
        let mainVC = MainViewController()
        navigationController?.setViewControllers([mainVC], animated: false)
    }
    
}

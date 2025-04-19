//
//  MainViewController.swift
//  SignUp
//
//  Created by 안준경 on 4/18/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
    
    private let mainView = MainView()
    private let disposeBag = DisposeBag()
        
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        tapButton()
        
        //회원정보 조회 테스트
        let coreDataService = UserDataService()
        let allUsers = coreDataService.fetchAllUsers()

        for user in allUsers {
            print("📧 Email: \(user.email), 🧑‍💼 Nickname: \(user.nickname)")
        }
    }
    
    // MARK: 버튼 탭 동작
    private func tapButton() {
        mainView.startButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                self?.isAuthenticated()
            }).disposed(by: disposeBag)
    }
    
    // TODO: 회원/비회원 판단 -> 로그인정보 UserDefaults
    private func isAuthenticated() {
        if true { // 비회원
            let signUpVC = SignUpViewController()
            navigationController?.setViewControllers([signUpVC], animated: false)
        } else { // 회원
//            let loginSuccessVC = LoginSuccessViewController(userData: )
//            navigationController?.setViewControllers([loginSuccessVC], animated: false)
        }
    }
    
}


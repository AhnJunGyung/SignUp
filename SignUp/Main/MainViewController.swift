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

enum Status {
    case guest
    case member(userData: UserData)
}

final class MainViewController: UIViewController {
    
    private let mainView = MainView()
    private let disposeBag = DisposeBag()
    private var isMember: Status = .guest
        
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        isAuthenticated()
        tapButton()
    }
    
    // MARK: 버튼 탭 동작
    private func tapButton() {
        mainView.startButton.rx
            .tap
            .subscribe(onNext: { [weak self] _ in
                switch self?.isMember {
                case .guest:
                    let signUpVC = SignUpViewController()
                    self?.navigationController?.setViewControllers([signUpVC], animated: false)
                case .member(let userData):
                    let loginSuccessVC = LoginSuccessViewController(userData: userData)
                    self?.navigationController?.setViewControllers([loginSuccessVC], animated: false)
                case .none: break
                }
            }).disposed(by: disposeBag)
    }
    
    // MARK: 회원/비회원 판별
    private func isAuthenticated() {
        let userDefaults = LoginUserDefaultsService()
        
        if let userData = userDefaults.loadUserData() {
            self.isMember = Status.member(userData: userData)
        }
    }    
}


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
    
    private let disposeBag = DisposeBag()
    
    // MARK: UI 컴포넌트
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시작하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        tapButton()
    }
    
    // MARK: UI 제약조건
    private func setUp() {
        view.backgroundColor = .white
        
        view.addSubview(startButton)
        
        startButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(150)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(140)
            $0.height.equalTo(40)
        }
    }
    
    // MARK: 버튼 탭 동작
    private func tapButton() {
        startButton.rx.tap
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


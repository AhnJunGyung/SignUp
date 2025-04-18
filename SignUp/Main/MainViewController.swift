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
    
    //MARK: UI 컴포넌트
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시작하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        tapButton()
    }
    
    //MARK: UI 제약조건

    private func setUp() {
        view.backgroundColor = .white
        
        view.addSubview(startButton)
        
        startButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(150)
            $0.height.equalTo(50)
        }
    }
    
    //MARK: 버튼 탭 동작
    
    private func tapButton() {
        startButton.rx.tap
            .subscribe(onNext: {
                print("test")
            }).disposed(by: disposeBag)
    }
    
}


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
    
    init(name: String) {
        loginSuccessView = LoginSuccessView(name: name)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginSuccessView
        setUp()
    }
    
    // MARK: UI 제약조건
    private func setUp(){
        view.backgroundColor = .white
    }
    
}

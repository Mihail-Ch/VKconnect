//
//  LoginViewController.swift
//  VK
//
//  Created by Михаил Чертов on 07.08.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
   
    //MARK: - Outlet
    
    @IBOutlet var loginInput: UITextField!
    @IBOutlet var passwordInput: UITextField!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet weak var loadIndicator: LoadIndicator!
    @IBOutlet var helloLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            self.loginButton.layer.cornerRadius = 7
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureEmptyForKeyboard()
        //нужно отключить интерактивность пользователя, чтоб кнопки не нажимались под анимацией
        self.view.isUserInteractionEnabled = false
        loadIndicator.configure()
        loadIndicator.startAnimation()
        UIView.animate(withDuration: 1, delay: 3) {
            self.loadIndicator.alpha = 0
        } completion: { _ in
            self.loadIndicator.stopAnimation()
        }
        helloLabel.alpha = 0
        UIView.animate(withDuration: 2, delay: 4) {
            self.helloLabel.alpha = 1
        } completion: { _ in
            self.helloLabel.alpha = 0
        }
        scrollView.alpha = 0
        UIView.animate(withDuration: 2, delay: 6) {
            self.scrollView.alpha = 1
        } completion: { _ in
            self.view.isUserInteractionEnabled = true
        }



        
    }
    
    //MARK: - Method
    
    private func checkUserData() -> Bool {
        guard let login = loginInput.text,
              let password = passwordInput.text else { return false }
        if login == "" && password == "" {
            return true
        }
        return false
    }
    
    
    private func showLoginError() {
        let alert = UIAlertController(title: "Ошибка",
                                      message: "Введены не верные данные",
                                      preferredStyle: .alert)
        let alertAcion = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
        alert.addAction(alertAcion)
        self.present(alert, animated: true, completion: nil)
        
    }

    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let checkResult = checkUserData()
        if !checkResult {
            showLoginError()
        }
            return checkResult
    }
    
    //MARK: - Action
    
    @IBAction func loginButton(_ sender: UIButton) { }
    
}

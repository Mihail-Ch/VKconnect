//
//  ExtensionKeyboard.swift
//  VK
//
//  Created by Михаил Чертов on 07.08.2021.
//

import UIKit

extension LoginViewController {
    
    
    //Когда клавиатура появлятся
    @objc func keyboardWasShown(notification: Notification) {
        //Получаем размер клавиатуры
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsents = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        //Добавлем отступ внизу UIScrollView, равный размеру клавиатуры
        self.scrollView?.contentInset = contentInsents
        scrollView?.scrollIndicatorInsets = contentInsents
    }
    
    //Когда клаиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) {
        //Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsents = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsents
    }
    
    //Подписываеся на уведомления которые рассылает клавиатура
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 1. приходит при пояявлений клавиатуры
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWasShown(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        // 2. Когда пропадает
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillBeHidden(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    //Добавляем методы отписки
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillShowNotification,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillHideNotification,
                                                  object: nil)
    }
    
    // Свернуть клавиатуру при клике по экрану
    @objc func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    // Жест нажатия на клавиатуру
    func gestureEmptyForKeyboard() {
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        //Присваиваем его UIScrollView
        scrollView?.addGestureRecognizer(hideKeyboardGesture)
       
    }
}

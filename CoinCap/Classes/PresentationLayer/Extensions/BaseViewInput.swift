//
//  BaseViewInput.swift
//  CoinCap
//
//  Created by Nazar Prysiazhnyi on 26.01.2023.
//

import Foundation
import UIKit

protocol BaseViewInput: AnyObject {
    func showError(message: String)
}

extension BaseViewInput where Self: UIViewController {
    func showError(message: String) {
        let viewController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        viewController.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default))
        self.present(viewController, animated: true)
    }
}

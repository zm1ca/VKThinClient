//
//  UIViewController+Ext.swift
//  VKThinClient
//
//  Created by Źmicier Fiedčanka on 29.06.21.
//

import UIKit

extension UIViewController {

    func presentAlertOnMainThread(withTitle title: String, andMessage message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        present(alertController, animated: true, completion: nil)
    }
}

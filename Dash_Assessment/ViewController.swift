//
//  ViewController.swift
//  Dash_Assessment
//
//  Created by ADMIN on 1/18/23.
//

import UIKit

extension UIViewController {
    
    func onError(_ message: String, refresh: @escaping () -> Void) {
        
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let retry = UIAlertAction(title: "Re-Try", style: .default, handler: {_ in refresh() })
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {_ in })
        
        alert.addAction(cancel)
        alert.addAction(retry)
        self.present(alert, animated: true, completion: nil)
    }
    
    func onError(_ message: String) {
        
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel, handler: {_ in })
        
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}

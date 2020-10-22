//
//  URLOpener.swift
//  PIE
//
//  Created by Karina on 9/6/20.
//  Copyright © 2020 Karina. All rights reserved.
//

import UIKit

protocol URLOpenerProtocol {
    
    func open(_ url: URL, options: [UIApplication.OpenExternalURLOptionsKey : Any], completionHandler completion: ((Bool) -> Void)?)
}

struct URLOpener {
    
    var application: URLOpenerProtocol
    
    
    init(application: URLOpenerProtocol) {
        self.application = application
    }
    
    
    init() {
        self.init(application: UIApplication.shared)
    }
    
    
    func openURL(url: String) {
        guard let url = URL(string: url) else { return }
        application.open(url, options: [:], completionHandler: nil)
    }
}


extension UIApplication: URLOpenerProtocol { }


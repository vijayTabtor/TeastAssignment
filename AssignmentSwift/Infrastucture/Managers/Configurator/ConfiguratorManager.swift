//
// Created by Carmelo Gallo on 4/23/17.
// Copyright (c) 2017 Carmelo Gallo. All rights reserved.
//

import Foundation

class ConfiguratorManager: ManagerProtocol {

    // MARK: - Constant properties
    let baseURL = "https://www.googleapis.com/books/v1"
    let defaultString = ""

    // MARK: - Protocol methods
    func startup(completion: ((ManagerProtocol?, ErrorAPI?) -> Void)?) {
        completion?(self, nil)
    }
}

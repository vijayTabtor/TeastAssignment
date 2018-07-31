//
//  LoggerManager.swift
//
//  Created by Carmelo Gallo on 3/4/17.
//  Copyright © 2017 Carmelo Gallo. All rights reserved.
//

import UIKit
import XCGLogger

class LoggerManager: ManagerProtocol {

    // MARK: - Protocol methods
    func startup(completion: ((ManagerProtocol?, ErrorAPI?) -> Void)?) {
        completion?(self, nil)
    }

    init() {
        XCGLogger.default.setup(level: .debug,
                                showLogIdentifier: false,
                                showFunctionName: true,
                                showThreadName: true,
                                showLevel: true,
                                showFileNames: true,
                                showLineNumbers: true,
                                showDate: true,
                                writeToFile: nil,
                                fileLevel: nil)
    }

    func verbose(_ message: String) {
        XCGLogger.default.verbose(message)
    }

    func debug(_ message: String) {
        XCGLogger.default.debug(message)
    }

    func info(_ message: String) {
        XCGLogger.default.info(message)
    }

    func warning(_ message: String) {
        XCGLogger.default.warning(message)
    }

    func error(_ message: String) {
        XCGLogger.default.error(message)
    }
}

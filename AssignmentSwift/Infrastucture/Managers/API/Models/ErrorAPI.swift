//
// Created by Carmelo Gallo on 4/22/17.
// Copyright (c) 2017 Carmelo Gallo. All rights reserved.
//

import Foundation

// ErrorType
enum ErrorAPI: Error {
    case noNetwork(error: Error?)
    case timeout(error: Error?)
    case networkConnectionLost(error: Error?)
    case general(error: Error?)
    case server_500(error: Error?)
}

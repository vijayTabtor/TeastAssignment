//
// Created by Carmelo Gallo on 4/22/17.
// Copyright (c) 2017 Carmelo Gallo. All rights reserved.
//

import Foundation

protocol APIService {
    var baseURL: String { get set }
    init(baseURL: String)
}

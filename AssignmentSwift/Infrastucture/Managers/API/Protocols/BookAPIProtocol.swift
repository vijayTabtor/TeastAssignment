//
// Created by Carmelo Gallo on 9/18/17.
// Copyright (c) 2017 Carmelo Gallo. All rights reserved.
//

import Foundation

protocol BookAPIProtocol: APIService {
    func get(bookQuery: BookQuery, completion: ((Result<[BookModel]>) -> Void)?)
}

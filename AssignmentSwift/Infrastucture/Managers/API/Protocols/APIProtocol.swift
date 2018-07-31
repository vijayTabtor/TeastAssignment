//
// Created by Carmelo Gallo on 4/22/17.
// Copyright (c) 2017 Carmelo Gallo. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol APIProtocol: ManagerProtocol {

    var book: BookAPIProtocol { get }

    func call(withAPIModel apiModel: APIModel,
              completion: ((Result<JSON>) -> Void)?)
}

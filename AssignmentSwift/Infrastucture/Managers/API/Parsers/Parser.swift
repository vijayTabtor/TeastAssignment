//
// Created by Carmelo Gallo on 4/22/17.
// Copyright (c) 2017 Carmelo Gallo. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Parser {
    associatedtype T
    func parse(fromJSON json: JSON) -> T
}

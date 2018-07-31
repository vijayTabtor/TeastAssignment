//
//  Created by Carmelo Gallo on 4/23/17.
//  Copyright © 2017 Carmelo Gallo. All rights reserved.
//

enum AlertError: Error {

    struct AlertInfo {

        var title: String?
        var message: String?
        var defaultButtonTitle: String
        var dismissButtonTitle: String

        init(title: String? = nil,
             message: String? = nil,
             defaultButtonTitle: String = NoAlertButtonTitle,
             dismissButtonTitle: String = NoAlertButtonTitle) {
            if title == nil && message == nil {
                assertionFailure("one of between title and message must not be nil!")
            }
            self.title = title
            self.message = message
            self.defaultButtonTitle = defaultButtonTitle
            self.dismissButtonTitle = dismissButtonTitle
        }
    }

    case alertInfo(AlertInfo)
}
let NoAlertButtonTitle = Manager.configurator.defaultString

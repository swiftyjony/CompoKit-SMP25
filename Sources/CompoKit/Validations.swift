//
//  File.swift
//  CompoKit
//
//  Created by Jon Gonzalez on 18/4/25.
//

import Foundation

public enum ValidationType {
    case isNotEmpty
    case isEmail
    case isValidUsername
}

extension ValidationType {
    public func validate(_ value: String) -> LocalizedStringResource? {
        switch self {
        case .isNotEmpty:
            !value.isEmpty ? nil : " cannot be empty."
        case .isEmail:
            isValidEmail(value) ? nil : " format is invalid."
        case .isValidUsername:
            validStringLength(value, min: 8, max: 32) ? nil : " length must be between 8 and 32 characters."
        }
    }

    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = /^(?:[A-Z0-9a-z._%+-]+)@(?:[A-Za-z0-9-]+\.)+[A-Za-z]{2,63}$/
        return email.wholeMatch(of: emailRegex) != nil
    }

    func validStringLength(_ value: String, min: Int, max: Int) -> Bool {
        (min...max).contains(value.count)
    }
}

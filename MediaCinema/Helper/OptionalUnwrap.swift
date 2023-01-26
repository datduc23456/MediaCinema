//
//  OptionalUnwrap.swift
//  MediaCinema
//
//  Created by MacBook Pro on 26/01/2023.
//

import Foundation

@propertyWrapper
struct OptionalUnwrap<Value> {
    private let defaultValue: Value
    private let optionalValue: Value?
    
    var wrappedValue: Value {
        if let optionalValue {
            return optionalValue
        }
        return defaultValue
    }
    
    init(defaultValue: Value, _ optionalValue: Value?) {
        self.defaultValue = defaultValue
        self.optionalValue = optionalValue
    }
}

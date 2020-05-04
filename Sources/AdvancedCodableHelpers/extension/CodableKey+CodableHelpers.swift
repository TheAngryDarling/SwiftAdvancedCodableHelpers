//
//  CodableKey+CodableHelpers.swift
//  AdvancedCodableHelpersPackageDescription
//
//  Created by Tyler Anger on 2020-05-04.
//

import Foundation
import BasicCodableHelpers

internal extension CodableKey {
    static var `super`: CodingKey {
        return CodableKey(stringValue: "super")
    }
}

//
//  SimpleExtensions.swift
//  CodableHelpersTests
//
//  Created by Tyler Anger on 2019-06-13.
//

import Foundation
import Nillable

extension Bool: AnyEquatableFromEquatable {}

extension Int8: AnyEquatableFromEquatable {}
extension Int16: AnyEquatableFromEquatable {}
extension Int32: AnyEquatableFromEquatable {}
extension Int64: AnyEquatableFromEquatable {}
extension Int: AnyEquatableFromEquatable {}

extension UInt8: AnyEquatableFromEquatable {}
extension UInt16: AnyEquatableFromEquatable {}
extension UInt32: AnyEquatableFromEquatable {}
extension UInt64: AnyEquatableFromEquatable {}
extension UInt: AnyEquatableFromEquatable {}

extension Double: AnyEquatableFromEquatable {}
extension Float: AnyEquatableFromEquatable {}

extension Character: AnyEquatableFromEquatable {}
extension String: AnyEquatableFromEquatable {}


private func valNil<V>(_ value: V, treatNSNullAsNil: Bool = true) -> Bool {
    // If value is NSNull and not treatNSNullAsNil then we shouuld return false
    guard !(!treatNSNullAsNil && value is NSNull) else { return false }
    guard let v = value as? Nillable else { return false }
    return v.isNil
}

extension Optional: AnyEquatable {
    public func equals(_ value: Any) -> Bool {
        let isValNil = valNil(value)
        if self.isNil && isValNil { return true }
        guard !self.isNil && !isValNil else { return false }
        if let v = value as? Wrapped, let aE = v as? AnyEquatable {
            return aE.equals(self.unsafelyUnwrapped)
        } else {
            return false
        }
        
    }
}

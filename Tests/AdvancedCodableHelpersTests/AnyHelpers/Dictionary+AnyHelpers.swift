//
//  Dictionary+AnyHelpers.swift
//  CodableHelpersTests
//
//  Created by Tyler Anger on 2019-06-13.
//

import Foundation

extension Dictionary: AnyEquatable/* where Value == Any*/ {
    public func equals(_ value: Any) -> Bool {
        guard let dict = value as? Dictionary<Key, Value> else { return false }
        guard self.count == dict.count else { return false }
        guard self.count > 0 else { return true }
        
        for (k, lhs) in self {
            guard let rhs = dict[k] else {
                return false
            }
            guard let lhsEq = lhs as? AnyEquatable else {
                return false
            }
            if !lhsEq.equals(rhs) {
                return false
            }
        }
        
        return true
    }
}

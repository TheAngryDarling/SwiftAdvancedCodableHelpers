//
//  Array+AnyHelpers.swift
//  CodableHelpersTests
//
//  Created by Tyler Anger on 2019-06-13.
//

import Foundation

extension Array: AnyEquatable/* where Element == Any*/ {
    public func equals(_ value: Any) -> Bool {
        guard let ary = value as? Array<Element> else { return false }
        guard self.count == ary.count else { return false }
        guard self.count > 0 else { return true }
        for i in 0..<self.count {
            let selfIdx = self.index(self.startIndex, offsetBy: i)
            let aryIdx = ary.index(ary.startIndex, offsetBy: i)
            
            let lhs = self[selfIdx]
            let rhs = ary[aryIdx]
            
            guard let lhsEq = lhs as? AnyEquatable else { return false }
            if !lhsEq.equals(rhs) { return false }
        }
        return true
    }
}

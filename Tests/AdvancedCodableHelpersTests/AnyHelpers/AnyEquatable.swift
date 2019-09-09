//
//  AnyEquatable.swift
//  CodableHelpersTests
//
//  Created by Tyler Anger on 2019-06-13.
//

import Foundation

/// Simple protocol to provide method for comparing objects of any type
public protocol AnyEquatable {
    /// Test to see if the current object equals the given object
    ///
    /// - Parameter value: The object to compare to
    /// - Returns: Returns true of both objects equal, otherwise false
    func equals(_ value: Any) -> Bool
}

/// AnyEquatable protocol stubed for any Equatable type.
/// This protocol provies the required method by casting
/// the value checking against to the Object Type in question
/// Then calling the Equatable == method on it
public protocol AnyEquatableFromEquatable: AnyEquatable, Equatable { }

public extension AnyEquatableFromEquatable {
    func equals(_ value: Any) -> Bool {
        guard let eV = value as? Self else { return false }
        return (self == eV)
    }
}

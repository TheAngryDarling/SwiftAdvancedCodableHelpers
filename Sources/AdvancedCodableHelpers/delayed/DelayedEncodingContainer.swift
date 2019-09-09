//
//  DelayedEncodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-06.
//

import Foundation

/// Base class for delayed encoding container
public class DelayedEncodingContainer {
    
    /// The path of coding keys taken to get to this point in encoding.
    public private(set) var codingPath: [CodingKey]
    /// Indicator of wether the real container was set yet
    public private(set) var wasContainerSet: Bool = false
    
    /// Initialize a new instance of DelayedEncodingContainer with the  given coding path
    ///
    /// This is a base class and should never be initilize directly
    ///
    /// - Parameter codingPath: The path of coding keys taken to get to this point in encoding.
    public init(codingPath: [CodingKey]) {
        self.codingPath = codingPath
    }
    
    /// Initialize using an UnkeyedEncodingContainer.
    /// Once called, any pending encoding actions will be called upon the real container
    ///
    /// Note: initializeContainer should only be called once on any instance
    ///
    /// - Parameter realContainer: Initialize using an UnkeyedEncodingContainer parent
    internal func initializeContainer(from realContainer: inout UnkeyedEncodingContainer) throws {
        self.wasContainerSet = true
    }
    
    /// Initialize using an KeyedEncodingContainer
    /// Once called, any pending encoding actions will be called upon the real container
    ///
    /// Note: initializeContainer should only be called once on any instance
    ///
    /// - Parameters:
    ///   - parent: Initialize using an KeyedEncodingContainer parent
    ///   - key: Key to initialize with
    internal func initializeContainer<ParentKey>(fromParent parent: inout KeyedEncodingContainer<ParentKey>,
                                                 forKey key: ParentKey) throws /* where ParentKey : CodingKey */ {
        self.wasContainerSet = true
        self.codingPath.append(key)
    }
    
    internal func initializeContainer() {
        self.wasContainerSet = true
    }
}

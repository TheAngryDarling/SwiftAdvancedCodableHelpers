//
//  FilteredDelayedUnkeyedEncodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-06.
//

import Foundation

/// An Unkeyed encoding container that allows for fitering and delayed processing
public class FilteredDelayedUnkeyedEncodingContainer: FilteredUnkeyedEncodingContainer {
    /// Delayed container to call encodings on
    private var delayedContainer: DelayedUnkeyedEncodingContainer
    
    /// Creates a new instance of FilteredDelayedUnkeyedEncodingContainer
    ///
    /// - Parameters:
    ///   - container: The delayed container to work on
    ///   - rootContainer: Reference to a root filetered container if there is one
    ///   - filter: The filter method used to filter out specific encoding calls
    public init(_ container: DelayedUnkeyedEncodingContainer,
                rootContainer: FilteredEncodingContainer? = nil,
                filter: @escaping FilterEncoding) {
        self.delayedContainer = container
        super.init(container.codableObject(), rootContainer: rootContainer, filter: filter)
    }
    /// Creates a new instance of FilteredDelayedUnkeyedEncodingContainer
    ///
    ///
    /// - Parameters:
    ///   - codingPath: The current coding path
    ///   - rootContainer: Reference to a root filetered container if there is one
    ///   - filter: The filter method used to filter out specific encoding calls
    public convenience init(codingPath: [CodingKey],
                            rootContainer: FilteredEncodingContainer? = nil,
                            filter: @escaping FilterEncoding) {
        self.init(DelayedUnkeyedEncodingContainer(codingPath: codingPath), rootContainer: rootContainer, filter: filter)
    }
    
    /// Initialize using an UnkeyedEncodingContainer.
    /// Once called, any pending encoding actions will be called upon the real container
    ///
    /// Note: initializeContainer should only be called once on any instance
    ///
    /// - Parameter realContainer: Initialize using an UnkeyedEncodingContainer parent
    public func initializeContainer(from realContainer: inout UnkeyedEncodingContainer) throws  {
        try self.delayedContainer.initializeContainer(from: &realContainer)
    }
    
    /// Initialize using an KeyedEncodingContainer
    /// Once called, any pending encoding actions will be called upon the real container
    ///
    /// Note: initializeContainer should only be called once on any instance
    ///
    /// - Parameters:
    ///   - parent: Initialize using an KeyedEncodingContainer parent
    ///   - key: Key to initialize with
    public func initializeContainer<ParentKey>(fromParent parent: inout KeyedEncodingContainer<ParentKey>,
                                               forKey key: ParentKey) throws /* where ParentKey : CodingKey */ {
        try self.delayedContainer.initializeContainer(fromParent: &parent,
                                                      forKey: key)
    }
    
    
    
    public override func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> /* where NestedKey : CodingKey */ {
        let n = self.delayedContainer.nestedDelayedContainer(keyedBy: keyType)
        let rtn = FilteredDelayedKeyedEncodingContainer<NestedKey>(n,
                                                                   rootContainer: self.rootContainer ?? self,
                                                                   filter: self.filterEncoding)
        return KeyedEncodingContainer<NestedKey>(rtn)
        
    }
    
    public override func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        
        let rtn = FilteredDelayedUnkeyedEncodingContainer(self.delayedContainer.nestedDelayedUnkeyedContainer(),
                                                          rootContainer: self.rootContainer ?? self,
                                                          filter: self.filterEncoding)
        return rtn.codableObject()
    }
    
}

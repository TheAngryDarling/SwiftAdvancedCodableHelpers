//
//  FilteredDelayedKeyedEncodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-06.
//

import Foundation

/// A Keyed encoding container that allows for fitering and delayed processing
public class FilteredDelayedKeyedEncodingContainer<K>: FilteredKeyedEncodingContainer<K> where K: CodingKey {
    /// Delayed container to call encodings on
    private var delayedContainer: DelayedKeyedEncodingContainer<K>
    /// Indicator of wether the real container was set yet
    public var wasContainerSet: Bool { return self.delayedContainer.wasContainerSet }
    
    /// Creates a new instance of FilteredDelayedKeyedEncodingContainer
    ///
    /// - Parameters:
    ///   - container: The delayed container to work on
    ///   - rootContainer: Reference to a root filetered container if there is one
    ///   - filter: The filter method used to filter out specific encoding calls
    public init(_ container: DelayedKeyedEncodingContainer<K>,
                rootContainer: FilteredEncodingContainer? = nil,
                filter: @escaping FilterEncoding) {
        self.delayedContainer = container
        super.init(KeyedEncodingContainer<K>(container), rootContainer: rootContainer, filter: filter)
    }
    /// Creates a new instance of FilteredDelayedKeyedEncodingContainer
    ///
    /// - Parameters:
    ///   - codingPath: The current coding path
    ///   - rootContainer: Reference to a root filetered container if there is one
    ///   - filter: The filter method used to filter out specific encoding calls
    public convenience init(codingPath: [CodingKey],
                            rootContainer: FilteredEncodingContainer? = nil,
                            filter: @escaping FilterEncoding) {
        self.init(DelayedKeyedEncodingContainer<K>(codingPath: codingPath), rootContainer: rootContainer, filter: filter)
    }
    
    /// Initialize using an UnkeyedEncodingContainer.
    /// Once called, any pending encoding actions will be called upon the real container
    ///
    /// Note: initializeContainer should only be called once on any instance
    ///
    /// - Parameter parent: Initialize using an UnkeyedEncodingContainer parent
    public func initializeContainer(fromParent parent: inout UnkeyedEncodingContainer) throws  {
        try self.delayedContainer.initializeContainer(fromParent: &parent)
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
        try self.delayedContainer.initializeContainer(fromParent: &parent, forKey: key)
    }
    
    public override func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type,
                                                    forKey key: K) -> KeyedEncodingContainer<NestedKey> /* where NestedKey : CodingKey */ {
        let n = self.delayedContainer.nestedDelayedContainer(keyedBy: keyType, forKey: key)
        let rtn = FilteredDelayedKeyedEncodingContainer<NestedKey>(n,
                                                                   rootContainer: self.rootContainer ?? self,
                                                                   filter: self.filterEncoding)
        return KeyedEncodingContainer<NestedKey>(rtn)
        
    }
    
    public override func nestedUnkeyedContainer(forKey key: K) -> UnkeyedEncodingContainer {
        let rtn = FilteredDelayedUnkeyedEncodingContainer(self.delayedContainer.nestedDelayedUnkeyedContainer(forKey: key),
                                                          rootContainer: self.rootContainer ?? self,
                                                          filter: self.filterEncoding)
        return rtn.codableObject()
        /*
        let n = self.delayedContainer.nestedUnkeyedContainer(forKey: key)
        if let nB = n as? BoxedClassUnkeyedEncodingContainer {
            let rtn = FilteredDelayedUnkeyedEncodingContainer(nB.box as! DelayedUnkeyedEncodingContainer, rootContainer: self.rootContainer ?? self, filter: self.filterEncoding)
            return rtn.codableObject()
        } else {
            let rtn = FilteredDelayedUnkeyedEncodingContainer(n as! DelayedUnkeyedEncodingContainer, rootContainer: self.rootContainer ?? self, filter: self.filterEncoding)
            return rtn.codableObject()
        }*/
    }
    
}

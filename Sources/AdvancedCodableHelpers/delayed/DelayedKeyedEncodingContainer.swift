//
//  DelayedKeyedEncodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-06.
//

import Foundation

/// Delayed keyed encoding container used to encode elements in memory until initializeContainer is called
public class DelayedKeyedEncodingContainer<K>: DelayedEncodingContainer, KeyedEncodingContainerProtocol where K: CodingKey {
    
    public typealias Key = K
    private typealias CacheCall = (_ container: inout KeyedEncodingContainer<Key>) throws -> Void
    
    /// Real container used for encoding
    private var container: KeyedEncodingContainer<Key>? = nil
    
    /// Stores any encoding actions pending before initializeContainer has been called
    private var cache: [CacheCall] = []
    
    /// Helpful method of creating a KeyedEncodingContainer out of the current container
    ///
    /// - Returns: Returns a KeyedEncodingContainer wrapped around this instance
    public func toKeyedContainer() -> KeyedEncodingContainer<Key> {
        return KeyedEncodingContainer<Key>(self)
    }
    
    /// Executes all pending encoding calls on real container
    fileprivate func processCache() throws {
        while self.cache.count > 0 {
            let c = self.cache.remove(at: 0)
            try c(&self.container!)
        }
    }
    /// Initialize using an UnkeyedEncodingContainer.
    /// Once called, any pending encoding actions will be called upon the real container
    ///
    /// Note: initializeContainer should only be called once on any instance
    ///
    /// - Parameter parent: Initialize using an UnkeyedEncodingContainer parent
    internal func initializeContainer(fromParent parent: inout UnkeyedEncodingContainer) throws  {
        guard container == nil else { return }
        try super.initializeContainer(from: &parent)
        self.container = parent.nestedContainer(keyedBy: Key.self)
        self.container = WrappedKeyedEncodingContainer<Key>(parent.nestedContainer(keyedBy: Key.self),
                                                            customCodingPath: self.codingPath).toKeyedContainer()
        try self.processCache()
    }
    
    /// Initialize using an KeyedEncodingContainer
    /// Once called, any pending encoding actions will be called upon the real container
    ///
    /// Note: initializeContainer should only be called once on any instance
    ///
    /// - Parameters:
    ///   - parent: Initialize using an KeyedEncodingContainer parent
    ///   - key: Key to initialize with
    internal override func initializeContainer<ParentKey>(fromParent parent: inout KeyedEncodingContainer<ParentKey>,
                                                          forKey key: ParentKey) throws /* where ParentKey : CodingKey */ {
        guard container == nil else { return }
        try super.initializeContainer(fromParent: &parent, forKey: key)
        //self.container = parent.nestedContainer(keyedBy: Key.self, forKey: key)
        self.container = WrappedKeyedEncodingContainer(parent.nestedContainer(keyedBy: Key.self, forKey: key),
                                                       customCodingPath: self.codingPath).toKeyedContainer()
        try self.processCache()
    }
    /// Initialize using an KeyedEncodingContainer
    /// Once called, any pending encoding actions will be called upon the real container
    ///
    /// Note: initializeContainer should only be called once on any instance
    ///
    /// - Parameters:
    ///   - realContainer: Initialize using an KeyedEncodingContainer
    internal func initializeContainer(from realContainer: inout KeyedEncodingContainer<Key>) throws /* where ParentKey : CodingKey */ {
        guard container == nil else { return }
        super.initializeContainer()
        //self.container = parent.nestedContainer(keyedBy: Key.self, forKey: key)
        self.container = realContainer
        try self.processCache()
    }
    
    public func encodeNil(forKey key: K) throws {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encodeNil(forKey: key)
            })
            return
        }
        try c.encodeNil(forKey: key)
    }
    
    public func encode(_ value: Bool, forKey key: K) throws {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encode(value, forKey: key)
            })
            return
        }
        try c.encode(value, forKey: key)
    }
    
    public func encode(_ value: String, forKey key: K) throws {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encode(value, forKey: key)
            })
            return
        }
        try c.encode(value, forKey: key)
    }
    
    public func encode(_ value: Double, forKey key: K) throws {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encode(value, forKey: key)
            })
            return
        }
        try c.encode(value, forKey: key)
    }
    
    public func encode(_ value: Float, forKey key: K) throws {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encode(value, forKey: key)
            })
            return
        }
        try c.encode(value, forKey: key)
    }
    
    public func encode(_ value: Int, forKey key: K) throws {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encode(value, forKey: key)
            })
            return
        }
        try c.encode(value, forKey: key)
    }
    
    public func encode(_ value: Int8, forKey key: K) throws {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encode(value, forKey: key)
            })
            return
        }
        try c.encode(value, forKey: key)
    }
    
    public func encode(_ value: Int16, forKey key: K) throws {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encode(value, forKey: key)
            })
            return
        }
        try c.encode(value, forKey: key)
    }
    
    public func encode(_ value: Int32, forKey key: K) throws {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encode(value, forKey: key)
            })
            return
        }
        try c.encode(value, forKey: key)
    }
    
    public func encode(_ value: Int64, forKey key: K) throws {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encode(value, forKey: key)
            })
            return
        }
        try c.encode(value, forKey: key)
    }
    
    public func encode(_ value: UInt, forKey key: K) throws {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encode(value, forKey: key)
            })
            return
        }
        try c.encode(value, forKey: key)
    }
    
    public func encode(_ value: UInt8, forKey key: K) throws {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encode(value, forKey: key)
            })
            return
        }
        try c.encode(value, forKey: key)
    }
    
    public func encode(_ value: UInt16, forKey key: K) throws {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encode(value, forKey: key)
            })
            return
        }
        try c.encode(value, forKey: key)
    }
    
    public func encode(_ value: UInt32, forKey key: K) throws {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encode(value, forKey: key)
            })
            return
        }
        try c.encode(value, forKey: key)
    }
    
    public func encode(_ value: UInt64, forKey key: K) throws {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encode(value, forKey: key)
            })
            return
        }
        try c.encode(value, forKey: key)
    }
    
    public func encode<T>(_ value: T, forKey key: K) throws where T : Encodable {
        guard var c = self.container else  {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try container.encode(value, forKey: key)
            })
            return
        }
        try c.encode(value, forKey: key)
    }
    
    public func nestedDelayedContainer<NestedKey>(keyedBy keyType: NestedKey.Type,
                                                    forKey key: K) -> DelayedKeyedEncodingContainer<NestedKey> /* where NestedKey : CodingKey */ {
        var subPath: [CodingKey] = []
        subPath.append(contentsOf: self.codingPath)
        subPath.append(key)
         let rtn = DelayedKeyedEncodingContainer<NestedKey>(codingPath: subPath)
        if var c = self.container  {
           try! rtn.initializeContainer(fromParent: &c, forKey: key)
        } else {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try rtn.initializeContainer(fromParent: &container, forKey: key)
            })
        }
        return rtn
    }
    
    public func nestedDelayedUnkeyedContainer(forKey key: K) -> DelayedUnkeyedEncodingContainer {
        var subPath: [CodingKey] = []
        subPath.append(contentsOf: self.codingPath)
        let rtn = DelayedUnkeyedEncodingContainer(codingPath: subPath)
        if var c = self.container { try! rtn.initializeContainer(fromParent: &c, forKey: key) }
        else {
            cache.append({ ( container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try rtn.initializeContainer(fromParent: &container, forKey: key)
            })
        }
        return rtn
    }
    
    
    
    public func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type,
                                           forKey key: K) -> KeyedEncodingContainer<NestedKey> /* where NestedKey : CodingKey */ {
        guard var c = self.container else  {
            return self.nestedDelayedContainer(keyedBy: keyType, forKey: key).toKeyedContainer()
        }
        return c.nestedContainer(keyedBy: keyType, forKey: key)
        
    }
    
    public func nestedUnkeyedContainer(forKey key: K) -> UnkeyedEncodingContainer {
        guard var c = self.container else  {
            return self.nestedDelayedUnkeyedContainer(forKey: key).codableObject()
        }
        return c.nestedUnkeyedContainer(forKey: key)
    }
    
    public func superEncoder() -> Encoder {
        guard var c = self.container else {
            let rtn = DelayedEncoder(codingPath: self.codingPath)
            cache.append({ (container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try rtn.initializeEncoder(from: container.superEncoder())
            })
            return rtn
        }
        return c.superEncoder()
    }
    
    public func superEncoder(forKey key: K) -> Encoder {
        guard var c = self.container else {
            let rtn = DelayedEncoder(codingPath: self.codingPath)
            cache.append({ (container: inout KeyedEncodingContainer<Key>) throws -> Void in
                try rtn.initializeEncoder(from: container.superEncoder(forKey: key))
            })
            return rtn
        }
        return c.superEncoder()
    }
    
}

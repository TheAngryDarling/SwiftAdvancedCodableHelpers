//
//  DelayedUnkeyedEncodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-06.
//

import Foundation

/// Delayed unkeyed encoding container used to encode elements in memory until initializeContainer is called
public class DelayedUnkeyedEncodingContainer: DelayedEncodingContainer {
    
    private typealias CacheCall = (_ container: inout UnkeyedEncodingContainer) throws -> Void
    
    /// Real container used for encoding
    private var container: UnkeyedEncodingContainer? = nil
    
    /// Stores any encoding actions pending before initializeContainer has been called
    private var cache: [CacheCall] = []
    /// The number of elements encoded into the container.
    public var count: Int {
        if let c = self.container { return c.count }
        else { return self.cache.count }
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
    /// - Parameter realContainer: Initialize using an UnkeyedEncodingContainer
    public override func initializeContainer(from realContainer: inout UnkeyedEncodingContainer) throws {
        guard container == nil else { return }
        try super.initializeContainer(from: &realContainer)
        self.container = realContainer//parent.nestedUnkeyedContainer()
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
    public override func initializeContainer<ParentKey>(fromParent parent: inout KeyedEncodingContainer<ParentKey>,
                                                        forKey key: ParentKey) throws /* where ParentKey : CodingKey */ {
        guard container == nil else { return }
        try super.initializeContainer(fromParent: &parent, forKey: key)
        self.container = parent.nestedUnkeyedContainer(forKey: key)
        try self.processCache()
    }
    
    public func encodeNil() throws {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encodeNil()
            })
            return
        }
        try c.encodeNil()
    }
    
    public func encode(_ value: Bool) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: String) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: Double) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: Float) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: Int) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: Int8) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: Int16) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: Int32) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: Int64) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: UInt) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: UInt8) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: UInt16) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: UInt32) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: UInt64) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode<T>(_ value: T) throws where T : Encodable {
        guard var c = self.container else  {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    /// Encodes a nested delayed container keyed by the given type and returns it.
    ///
    /// - Parameter keyType: The key type to use for the container.
    /// - Returns: A new delayed keyed encoding container.
    public func nestedDelayedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> DelayedKeyedEncodingContainer<NestedKey> /* where NestedKey : CodingKey */ {
        var subPath: [CodingKey] = []
        subPath.append(contentsOf: self.codingPath)
        let rtn = DelayedKeyedEncodingContainer<NestedKey>(codingPath: subPath)
        if var c = self.container  {
             try! rtn.initializeContainer(fromParent: &c)
        } else {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try rtn.initializeContainer(fromParent: &container)
            })
        }
        return rtn
        
    }
    
    public func nestedDelayedUnkeyedContainer() -> DelayedUnkeyedEncodingContainer {
        var subPath: [CodingKey] = []
        subPath.append(contentsOf: self.codingPath)
        let rtn = DelayedUnkeyedEncodingContainer(codingPath: subPath)
        if var c = self.container { try! rtn.initializeContainer(from: &c) }
        else {
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try rtn.initializeContainer(from: &container)
            })
        }
        return rtn
    }
    
    public func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> /* where NestedKey : CodingKey */ {
        guard var c = self.container else  {
            return self.nestedDelayedContainer(keyedBy: keyType).toKeyedContainer()
        }
        return c.nestedContainer(keyedBy: keyType)
    }
    
    public func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        guard var c = self.container else  {
            return nestedDelayedUnkeyedContainer().codableObject()
        }
        return c.nestedUnkeyedContainer()
    }
    
    public func superEncoder() -> Encoder {
        guard var c = self.container else {
            let rtn = DelayedEncoder(codingPath: self.codingPath)
            cache.append({ (container: inout UnkeyedEncodingContainer) throws -> Void in
                try rtn.initializeEncoder(from: container.superEncoder())
            })
            return rtn
        }
        return c.superEncoder()
    }
}

#if !swift(>=4.0.4) || swift(>=4.2)
extension DelayedUnkeyedEncodingContainer: UnkeyedEncodingContainer { }
#else
extension DelayedUnkeyedEncodingContainer: ClassUnkeyedEncodingContainer { }
#endif

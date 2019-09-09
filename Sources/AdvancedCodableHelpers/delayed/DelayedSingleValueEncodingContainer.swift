//
//  DelayedSingleValueEncodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-06-25.
//

import Foundation

public class DelayedSingleValueEncodingContainer: SingleValueEncodingContainer {
    
    private typealias CacheCall = (_ container: inout SingleValueEncodingContainer) throws -> Void
    
    /// The path of coding keys taken to get to this point in encoding.
    public private(set) var codingPath: [CodingKey]
    /// Indicator of wether the real container was set yet
    public private(set) var wasContainerSet: Bool = false
    
    public var userInfo: [CodingUserInfoKey : Any] = [:]
    
    
    /// Real encoder used for encoding
    private var container: SingleValueEncodingContainer? = nil
    
    /// Stores any encoding actions pending before initializeContainer has been called
    private var cache: [CacheCall] = []
    
    
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
    /// - Parameter container: Initialize using an UnkeyedEncodingContainer
    public func initializeContainer(from container: inout SingleValueEncodingContainer) throws {
        self.wasContainerSet = true
        self.container = container
        while self.cache.count > 0 {
            let c = self.cache.remove(at: 0)
            try c(&self.container!)
        }
    }
    
    public func encodeNil() throws {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encodeNil()
            })
            return
        }
        try c.encodeNil()
    }
    
    public func encode(_ value: Bool) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: String) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: Double) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: Float) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: Int) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: Int8) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: Int16) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: Int32) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: Int64) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: UInt) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: UInt8) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: UInt16) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: UInt32) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode(_ value: UInt64) throws {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
    
    public func encode<T>(_ value: T) throws where T : Encodable {
        guard var c = self.container else  {
            cache.append({ (container: inout SingleValueEncodingContainer) throws -> Void in
                try container.encode(value)
            })
            return
        }
        try c.encode(value)
    }
}

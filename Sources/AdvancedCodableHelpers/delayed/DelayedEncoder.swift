//
//  DelayedEncoder.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-06-25.
//

import Foundation

public class DelayedEncoder: Encoder {
    
    private typealias CacheCall = (_ encoder: inout Encoder) throws -> Void
    
    /// The path of coding keys taken to get to this point in encoding.
    public private(set) var codingPath: [CodingKey]
    /// Indicator of wether the real container was set yet
    public private(set) var wasContainerSet: Bool = false
    
    public var userInfo: [CodingUserInfoKey : Any] = [:]
    
    
    /// Real encoder used for encoding
    private var encoder: Encoder? = nil
    
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
    /// - Parameter parent: Initialize using an UnkeyedEncodingContainer parent
    public func initializeEncoder(from encoder: Encoder) throws {
        self.wasContainerSet = true
        self.encoder = encoder
        while self.cache.count > 0 {
            let c = self.cache.remove(at: 0)
            try c(&self.encoder!)
        }
    }
    
    public func delayedContainer<Key>(keyedBy type: Key.Type) -> DelayedKeyedEncodingContainer<Key> where Key : CodingKey {
        var subPath: [CodingKey] = []
        subPath.append(contentsOf: self.codingPath)
        let rtn = DelayedKeyedEncodingContainer<Key>(codingPath: subPath)
        
        guard let e = self.encoder else {
           
            cache.append({ ( encoder: inout Encoder) throws -> Void in
                var c = encoder.container(keyedBy: type)
                try rtn.initializeContainer(from: &c)
            })
            return rtn
        }
        
        var realC = e.container(keyedBy: type)
        try! rtn.initializeContainer(from: &realC)
        return rtn
        
    }
    
    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        guard let e = self.encoder else {
            var subPath: [CodingKey] = []
            subPath.append(contentsOf: self.codingPath)
            let rtn = DelayedKeyedEncodingContainer<Key>(codingPath: subPath)
            cache.append({ ( encoder: inout Encoder) throws -> Void in
                var c = encoder.container(keyedBy: type)
                try rtn.initializeContainer(from: &c)
            })
            return rtn.toKeyedContainer()
        }
        return e.container(keyedBy: type)
    }
    
    public func delayedUnkeyedContainer() -> DelayedUnkeyedEncodingContainer {
        var subPath: [CodingKey] = []
        subPath.append(contentsOf: self.codingPath)
        let rtn = DelayedUnkeyedEncodingContainer(codingPath: subPath)
        
        guard let e = self.encoder else {
            
            cache.append({ ( encoder: inout Encoder) throws -> Void in
                var c = encoder.unkeyedContainer()
                try rtn.initializeContainer(from: &c)
            })
            return rtn
        }
       
        var realC = e.unkeyedContainer()
        try! rtn.initializeContainer(from: &realC)
        return rtn
        
        
    }
    
    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        guard let e = self.encoder else {
            var subPath: [CodingKey] = []
            subPath.append(contentsOf: self.codingPath)
            let rtn = DelayedUnkeyedEncodingContainer(codingPath: subPath)
            cache.append({ ( encoder: inout Encoder) throws -> Void in
                var c = encoder.unkeyedContainer()
                try rtn.initializeContainer(from: &c)
            })
            return rtn.codableObject()
        }
        return e.unkeyedContainer()
    }
    
    public func delayedSingleValueContainer() -> DelayedSingleValueEncodingContainer {
        var subPath: [CodingKey] = []
        subPath.append(contentsOf: self.codingPath)
        let rtn = DelayedSingleValueEncodingContainer(codingPath: subPath)
        
        guard let e = self.encoder else {
            
            cache.append({ ( encoder: inout Encoder) throws -> Void in
                var c = encoder.singleValueContainer()
                try rtn.initializeContainer(from: &c)
            })
            return rtn
        }
        var realC = e.singleValueContainer()
        try! rtn.initializeContainer(from: &realC)
        return rtn
        
    }
    public func singleValueContainer() -> SingleValueEncodingContainer {
        guard let e = self.encoder else {
            var subPath: [CodingKey] = []
            subPath.append(contentsOf: self.codingPath)
            let rtn = DelayedSingleValueEncodingContainer(codingPath: subPath)
            cache.append({ ( encoder: inout Encoder) throws -> Void in
                var c = encoder.singleValueContainer()
                try rtn.initializeContainer(from: &c)
            })
            return rtn
        }
        return e.singleValueContainer()
    }
}

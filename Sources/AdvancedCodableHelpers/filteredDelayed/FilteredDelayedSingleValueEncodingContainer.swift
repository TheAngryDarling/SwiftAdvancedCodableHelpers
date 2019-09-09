//
//  FilteredDelayedSingleValueEncodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-06-25.
//

import Foundation

/// A single value encoding container that allows for fitering and delayed processing
public class FilteredDelayedSingleValueEncodingContainer: FilteredEncodingContainer, SingleValueEncodingContainer {
    
    private var container: DelayedSingleValueEncodingContainer
    
    
    /// Creates a new instance of FilteredDelayedUnkeyedEncodingContainer
    ///
    /// Note: this should not be called directly, please use one of the inherited classes
    ///
    /// - Parameters:
    ///   - container: The delayed container to work on
    ///   - rootContainer: Reference to a root filetered container if there is one
    ///   - filter: The filter method used to filter out specific encoding calls
    public init(_ container: DelayedSingleValueEncodingContainer,
                rootContainer: FilteredEncodingContainer? = nil,
                filter: @escaping FilterEncoding) {
        self.container = container
        super.init(codingPath: container.codingPath, rootContainer: rootContainer, filter: filter)
    }
    
    /// Creates a new instance of FilteredDelayedSingleValueEncodingContainer
    ///
    ///
    /// - Parameters:
    ///   - codingPath: The current coding path
    ///   - rootContainer: Reference to a root filetered container if there is one
    ///   - filter: The filter method used to filter out specific encoding calls
    public convenience override init(codingPath: [CodingKey],
                            rootContainer: FilteredEncodingContainer? = nil,
                            filter: @escaping FilterEncoding) {
        self.init(DelayedSingleValueEncodingContainer(codingPath: codingPath), rootContainer: rootContainer, filter: filter)
    }
    
    
    public func encodeNil() throws {
        if try self.canEncode(method: #function, value: nil) {
            try self.container.encodeNil()
        }
    }
    
    public func encode(_ value: Bool) throws {
        if try self.canEncode(method: #function, value: value) {
            try self.container.encode(value)
        }
    }
    
    public func encode(_ value: String) throws {
        if try self.canEncode(method: #function, value: value) {
            try self.container.encode(value)
        }
    }
    
    public func encode(_ value: Double) throws {
        if try self.canEncode(method: #function, value: value) {
            try self.container.encode(value)
        }
    }
    
    public func encode(_ value: Float) throws {
        if try self.canEncode(method: #function, value: value) {
            try self.container.encode(value)
        }
    }
    
    public func encode(_ value: Int) throws {
        if try self.canEncode(method: #function, value: value) {
            try self.container.encode(value)
        }
    }
    
    public func encode(_ value: Int8) throws {
        if try self.canEncode(method: #function, value: value) {
            try self.container.encode(value)
        }
    }
    
    public func encode(_ value: Int16) throws {
        if try self.canEncode(method: #function, value: value) {
            try self.container.encode(value)
        }
    }
    
    public func encode(_ value: Int32) throws {
        if try self.canEncode(method: #function, value: value) {
            try self.container.encode(value)
        }
    }
    
    public func encode(_ value: Int64) throws {
        if try self.canEncode(method: #function, value: value) {
            try self.container.encode(value)
        }
    }
    
    public func encode(_ value: UInt) throws {
        if try self.canEncode(method: #function, value: value) {
            try self.container.encode(value)
        }
    }
    
    public func encode(_ value: UInt8) throws {
        if try self.canEncode(method: #function, value: value) {
            try self.container.encode(value)
        }
    }
    
    public func encode(_ value: UInt16) throws {
        if try self.canEncode(method: #function, value: value) {
            try self.container.encode(value)
        }
    }
    
    public func encode(_ value: UInt32) throws {
        if try self.canEncode(method: #function, value: value) {
            try self.container.encode(value)
        }
    }
    
    public func encode(_ value: UInt64) throws {
        if try self.canEncode(method: #function, value: value) {
            try self.container.encode(value)
        }
    }
    
    public func encode<T>(_ value: T) throws where T : Encodable {
        if try self.canEncode(method: #function, value: value) {
            try self.container.encode(value)
        }
    }
    
}

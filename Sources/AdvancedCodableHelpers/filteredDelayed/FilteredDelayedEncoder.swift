//
//  FilteredDelayedEncoder.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-06-25.
//

import Foundation

/// A encoder that allows for fitering and delayed processing
public class FilteredDelayedEncoder: Encoder {
    
    private var delayedEncoder: DelayedEncoder
    private let rootContainer: FilteredEncodingContainer?
    private let filter: FilteredEncodingContainer.FilterEncoding
    
    
    public var codingPath: [CodingKey] { return self.delayedEncoder.codingPath }
    
    public var userInfo: [CodingUserInfoKey : Any] {
        get { return self.delayedEncoder.userInfo }
        set { self.delayedEncoder.userInfo = newValue }
    }
    
    /// Creates a new instance of FilteredDelayedKeyedEncodingContainer
    ///
    /// Note: this should not be called directly, please use one of the inherited classes
    ///
    /// - Parameters:
    ///   - container: The delayed container to work on
    ///   - rootContainer: Reference to a root filetered container if there is one
    ///   - filter: The filter method used to filter out specific encoding calls
    public init(_ encoder: DelayedEncoder,
                rootContainer: FilteredEncodingContainer? = nil,
                filter: @escaping FilteredEncodingContainer.FilterEncoding) {
        self.delayedEncoder = encoder
        self.rootContainer = rootContainer
        self.filter = filter
    }
    
    public func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        let container = self.delayedEncoder.delayedContainer(keyedBy: type)
        return FilteredDelayedKeyedEncodingContainer(container,
                                                     rootContainer: self.rootContainer,
                                                     filter: self.filter).toKeyedContainer()
    }
    
    public func unkeyedContainer() -> UnkeyedEncodingContainer {
        let container = self.delayedEncoder.delayedUnkeyedContainer()
        return FilteredDelayedUnkeyedEncodingContainer(container,
                                                       rootContainer: self.rootContainer,
                                                       filter: self.filter).codableObject()
    }
    
    public func singleValueContainer() -> SingleValueEncodingContainer {
        let container = self.delayedEncoder.delayedSingleValueContainer()
        return FilteredDelayedSingleValueEncodingContainer(container,
                                                           rootContainer: self.rootContainer,
                                                           filter: self.filter)
    }
    
    
}

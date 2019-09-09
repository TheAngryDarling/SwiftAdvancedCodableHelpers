//
//  WrappedEncoder.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-04-26.
//

import Foundation

/// A Wrapped encoder with the ability of overriding the codingPath
///
/// The methods container, unkeyedContainer, singleValueContainer all return wrapped instances of containers
open class WrappedEncoder: Encoder {
    
    /// The real encoder
    private let encoder: Encoder
    public let codingPath: [CodingKey]
    
    open var userInfo: [CodingUserInfoKey : Any] { return self.encoder.userInfo }
    
    
    /// Creates a new instance of WrappedEncoder
    ///
    /// - Parameters:
    ///   - encoder: The encoder to wrap
    ///   - customCodingPath: The optional custom coding path
    public init(_ encoder: Encoder, customCodingPath: [CodingKey]? = nil) {
        self.encoder = encoder
        self.codingPath = customCodingPath ?? encoder.codingPath
    }
    
    
    open func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key : CodingKey {
        let c = WrappedKeyedEncodingContainer<Key>(self.encoder.container(keyedBy: type),
                                                    customCodingPath: self.codingPath)
        return KeyedEncodingContainer(c)
        
    }
    
    open func unkeyedContainer() -> UnkeyedEncodingContainer {
        return WrappedUnkeyedEncodingContainer(self.encoder.unkeyedContainer(),
                                               customCodingPath: self.codingPath).codableObject()
    }
    
    open func singleValueContainer() -> SingleValueEncodingContainer {
        return WrappedSingleValueEncodingContainer(self.encoder.singleValueContainer(),
                                                   customCodingPath: self.codingPath)
    }
    
}

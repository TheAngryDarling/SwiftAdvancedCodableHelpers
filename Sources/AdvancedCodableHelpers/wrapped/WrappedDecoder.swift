//
//  WrappedDecoder.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-04-27.
//

import Foundation

/// A Wrapped decoder with the ability of overriding the codingPath
///
/// The methods container, unkeyedContainer, singleValueContainer all return wrapped instances of containers
open class WrappedDecoder: Decoder {
    
    /// The real decoder
    private let decoder: Decoder
    public let codingPath: [CodingKey]
    /// Indicator to tell the WrappedCodingErrors if it should fix coding paths in the errors
    private let disableRepackagingErrors: Bool
    
    open var userInfo: [CodingUserInfoKey : Any] { return self.decoder.userInfo }
    
    
    /// Creates a new instance of WrappedDecoder
    ///
    /// - Parameters:
    ///   - encoder: The decoder to wrap
    ///   - customCodingPath: The optional custom coding path
    public init(_ decoder: Decoder, customCodingPath: [CodingKey]? = nil) {
        self.decoder = decoder
        self.codingPath = customCodingPath ?? decoder.codingPath
        self.disableRepackagingErrors = (customCodingPath == nil || (customCodingPath!.stringCodingPath == decoder.codingPath.stringCodingPath))
    }
    
    
    open func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> where Key : CodingKey {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            let c = WrappedKeyedDecodingContainer<Key>(try self.decoder.container(keyedBy: type),
                                                       customCodingPath: self.codingPath)
            return KeyedDecodingContainer(c)
        }
    }
    
    open func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            return WrappedUnkeyedDecodingContainer(try self.decoder.unkeyedContainer(),
                                                   customCodingPath: self.codingPath)
        }
    }
    
    open func singleValueContainer() throws -> SingleValueDecodingContainer {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            return WrappedSingleValueDecodingContainer(try self.decoder.singleValueContainer(),
                                                       customCodingPath: self.codingPath)
        } 
    }
}

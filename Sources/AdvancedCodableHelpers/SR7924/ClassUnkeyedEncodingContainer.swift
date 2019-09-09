//
//  ClassUnkeyedEncodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-07-30.
//

import Foundation

/// A protocol with the same definition as UnkeyedEncodingContainer but for use on classes
public protocol ClassUnkeyedEncodingContainer {
    
    /// The path of coding keys taken to get to this point in encoding.
    var codingPath: [CodingKey] { get }
    
    /// The number of elements encoded into the container.
    var count: Int { get }
    
    /// Encodes a null value.
    ///
    /// - throws: `EncodingError.invalidValue` if a null value is invalid in the
    ///   current context for this format.
    func encodeNil() throws
    
    /// Encodes the given value.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encode(_ value: Bool) throws
    
    /// Encodes the given value.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encode(_ value: String) throws
    
    /// Encodes the given value.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encode(_ value: Double) throws
    
    /// Encodes the given value.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encode(_ value: Float) throws
    
    /// Encodes the given value.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encode(_ value: Int) throws
    
    /// Encodes the given value.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encode(_ value: Int8) throws
    
    /// Encodes the given value.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encode(_ value: Int16) throws
    
    /// Encodes the given value.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encode(_ value: Int32) throws
    
    /// Encodes the given value.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encode(_ value: Int64) throws
    
    /// Encodes the given value.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encode(_ value: UInt) throws
    
    /// Encodes the given value.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encode(_ value: UInt8) throws
    
    /// Encodes the given value.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encode(_ value: UInt16) throws
    
    /// Encodes the given value.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encode(_ value: UInt32) throws
    
    /// Encodes the given value.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encode(_ value: UInt64) throws
    
    /// Encodes the given value.
    ///
    /// - parameter value: The value to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encode<T>(_ value: T) throws where T : Encodable
    
    /// Encodes a reference to the given object only if it is encoded
    /// unconditionally elsewhere in the payload (previously, or in the future).
    ///
    /// For encoders which don't support this feature, the default implementation
    /// encodes the given object unconditionally.
    ///
    /// For formats which don't support this feature, the default implementation
    /// encodes the given object unconditionally.
    ///
    /// - parameter object: The object to encode.
    /// - throws: `EncodingError.invalidValue` if the given value is invalid in
    ///   the current context for this format.
    func encodeConditional<T>(_ object: T) throws where T : AnyObject, T : Encodable
    
    /*
     /// Encodes the elements of the given sequence.
     ///
     /// - parameter sequence: The sequences whose contents to encode.
     /// - throws: An error if any of the contained values throws an error.
     func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Bool
     
     /// Encodes the elements of the given sequence.
     ///
     /// - parameter sequence: The sequences whose contents to encode.
     /// - throws: An error if any of the contained values throws an error.
     func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == String
     
     /// Encodes the elements of the given sequence.
     ///
     /// - parameter sequence: The sequences whose contents to encode.
     /// - throws: An error if any of the contained values throws an error.
     func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Double
     
     /// Encodes the elements of the given sequence.
     ///
     /// - parameter sequence: The sequences whose contents to encode.
     /// - throws: An error if any of the contained values throws an error.
     func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Float
     
     /// Encodes the elements of the given sequence.
     ///
     /// - parameter sequence: The sequences whose contents to encode.
     /// - throws: An error if any of the contained values throws an error.
     func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int
     
     /// Encodes the elements of the given sequence.
     ///
     /// - parameter sequence: The sequences whose contents to encode.
     /// - throws: An error if any of the contained values throws an error.
     func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int8
     
     /// Encodes the elements of the given sequence.
     ///
     /// - parameter sequence: The sequences whose contents to encode.
     /// - throws: An error if any of the contained values throws an error.
     func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int16
     
     /// Encodes the elements of the given sequence.
     ///
     /// - parameter sequence: The sequences whose contents to encode.
     /// - throws: An error if any of the contained values throws an error.
     func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int32
     
     /// Encodes the elements of the given sequence.
     ///
     /// - parameter sequence: The sequences whose contents to encode.
     /// - throws: An error if any of the contained values throws an error.
     func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int64
     
     /// Encodes the elements of the given sequence.
     ///
     /// - parameter sequence: The sequences whose contents to encode.
     /// - throws: An error if any of the contained values throws an error.
     func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt
     
     /// Encodes the elements of the given sequence.
     ///
     /// - parameter sequence: The sequences whose contents to encode.
     /// - throws: An error if any of the contained values throws an error.
     func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt8
     
     /// Encodes the elements of the given sequence.
     ///
     /// - parameter sequence: The sequences whose contents to encode.
     /// - throws: An error if any of the contained values throws an error.
     func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt16
     
     /// Encodes the elements of the given sequence.
     ///
     /// - parameter sequence: The sequences whose contents to encode.
     /// - throws: An error if any of the contained values throws an error.
     func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt32
     
     /// Encodes the elements of the given sequence.
     ///
     /// - parameter sequence: The sequences whose contents to encode.
     /// - throws: An error if any of the contained values throws an error.
     func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt64
     
     /// Encodes the elements of the given sequence.
     ///
     /// - parameter sequence: The sequences whose contents to encode.
     /// - throws: An error if any of the contained values throws an error.
     func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element : Encodable
     */
    /// Encodes a nested container keyed by the given type and returns it.
    ///
    /// - parameter keyType: The key type to use for the container.
    /// - returns: A new keyed encoding container.
    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey
    
    /// Encodes an unkeyed encoding container and returns it.
    ///
    /// - returns: A new unkeyed encoding container.
    func nestedUnkeyedContainer() -> UnkeyedEncodingContainer
    
    /// Encodes a nested container and returns an `Encoder` instance for encoding
    /// `super` into that container.
    ///
    /// - returns: A new encoder to pass to `super.encode(to:)`.
    func superEncoder() -> Encoder
}


public extension ClassUnkeyedEncodingContainer {
    func encodeConditional<T>(_ object: T) throws where T : AnyObject, T : Encodable {
        try self.encode(object)
    }
    
    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Bool {
        for element in sequence {
            try self.encode(element)
        }
    }
    
    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == String {
        for element in sequence {
            try self.encode(element)
        }
    }
    
    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Double {
        for element in sequence {
            try self.encode(element)
        }
    }
    
    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Float {
        for element in sequence {
            try self.encode(element)
        }
    }
    
    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int {
        for element in sequence {
            try self.encode(element)
        }
    }
    
    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int8 {
        for element in sequence {
            try self.encode(element)
        }
    }
    
    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int16 {
        for element in sequence {
            try self.encode(element)
        }
    }
    
    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int32 {
        for element in sequence {
            try self.encode(element)
        }
    }
    
    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == Int64 {
        for element in sequence {
            try self.encode(element)
        }
    }
    
    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt {
        for element in sequence {
            try self.encode(element)
        }
    }
    
    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt8 {
        for element in sequence {
            try self.encode(element)
        }
    }
    
    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt16 {
        for element in sequence {
            try self.encode(element)
        }
    }
    
    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt32 {
        for element in sequence {
            try self.encode(element)
        }
    }
    
    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element == UInt64 {
        for element in sequence {
            try self.encode(element)
        }
    }
    
    func encode<T>(contentsOf sequence: T) throws where T : Sequence, T.Element : Encodable {
        for element in sequence {
            try self.encode(element)
        }
    }
}

fileprivate struct BoxedClassUnkeyedEncodingContainer: UnkeyedEncodingContainer {
    private var box: ClassUnkeyedEncodingContainer
    
    /// The path of coding keys taken to get to this point in encoding.
    var codingPath: [CodingKey] { return box.codingPath }
    
    /// The number of elements encoded into the container.
    var count: Int { return box.count }
    
    fileprivate init(_ container: ClassUnkeyedEncodingContainer) {
        self.box = container
    }
    
    func encodeNil() throws {
        try box.encodeNil()
    }
    
    func encode(_ value: Bool) throws {
        try box.encode(value)
    }
    
    func encode(_ value: String) throws {
        try box.encode(value)
    }
    
    func encode(_ value: Double) throws {
        try box.encode(value)
    }
    
    func encode(_ value: Float) throws {
        try box.encode(value)
    }
    
    func encode(_ value: Int) throws {
        try box.encode(value)
    }
    
    func encode(_ value: Int8) throws {
        try box.encode(value)
    }
    
    func encode(_ value: Int16) throws {
        try box.encode(value)
    }
    
    func encode(_ value: Int32) throws {
        try box.encode(value)
    }
    
    func encode(_ value: Int64) throws {
        try box.encode(value)
    }
    
    func encode(_ value: UInt) throws {
        try box.encode(value)
    }
    
    func encode(_ value: UInt8) throws {
        try box.encode(value)
    }
    
    func encode(_ value: UInt16) throws {
        try box.encode(value)
    }
    
    func encode(_ value: UInt32) throws {
        try box.encode(value)
    }
    
    
    func encode(_ value: UInt64) throws {
        try box.encode(value)
    }
    
    func encode<T>(_ value: T) throws where T : Encodable {
        try box.encode(value)
    }
    
    func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey : CodingKey {
        return box.nestedContainer(keyedBy: keyType)
    }
    
    func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
        return box.nestedUnkeyedContainer()
    }
    
    func superEncoder() -> Encoder {
        return box.superEncoder()
    }
}


public extension ClassUnkeyedEncodingContainer {
    /// Returns a codable object from the current object
    ///
    /// - Returns: Returns an object that implements UnkeyedEncodingContainer. When the current object is of ClassUnkeyedEncodingContainer, this will wrap in a structure that implements UnkeyedEncodingContainer, otherwise this will return itself
    func codableObject() -> UnkeyedEncodingContainer {
        if let o = self as? UnkeyedEncodingContainer { return o }
        return BoxedClassUnkeyedEncodingContainer(self)
    }
}

public extension UnkeyedEncodingContainer {
    /// Returns a codable object from the current object
    ///
    /// - Returns: Returns an object that implements UnkeyedEncodingContainer. When the current object is of ClassUnkeyedEncodingContainer, this will wrap in a structure that implements UnkeyedEncodingContainer, otherwise this will return itself
    func codableObject() -> UnkeyedEncodingContainer {
        return self
    }
}

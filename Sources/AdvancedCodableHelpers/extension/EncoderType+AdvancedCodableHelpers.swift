//
//  EncoderType+AdvancedCodableHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2021-02-22.
//

import Foundation
import SwiftClassCollections
import BasicCodableHelpers


/// Private helper object for encoding dynamic keyed arrays
fileprivate struct EncodableObject<Objects>: Encodable where Objects: Sequence, Objects.Element: Encodable {
    private let objects: Objects
    private let elementKey: String
    
    public init(objects: Objects, elementKey: String) {
        self.objects = objects
        self.elementKey = elementKey
    }
    
    public func encode(to encoder: Encoder) throws {
        try encoder.dynamicElementEncoding(self.objects,
                                           usingKey: self.elementKey)
    }
    
}


public extension EncoderType where Self: SupportedDictionaryRootEncoderType {
    /// Encode a dictionary to a container
    ///
    /// - Parameters:
    ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
    ///   - encoder: The encoder to encode the dictionary to
    func encodeAnyDictionary<D>(_ dictionary: D) throws -> EncodedData where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        
        /*let encoderHelper = KeyedEncoderHelper(keyType: CodableKey.self) { container in
            try container._encodeDictionary(dictionary)
        }*/
        let encoderHelper = KeyedEncodingContainerCatcher(keyType: CodableKey.self) { container in
            try container._encodeAnyDictionary(dictionary)
        }
        
        return try self.encode(encoderHelper)
    }
    
    /// Provides an easy way of encoding an array of objects like a dictionary using one of the object properties as the key.
    ///
    /// Note: Array order is not guarenteed.  This is dependant on how the the EncodingType handles Dictionaries
    ///
    ///     struct EncodingElement: Encodable {
    ///         let id: String
    ///         let variableA: Int
    ///         let variableB: Bool
    ///     }
    ///
    ///     let objects: [EncodingElement] = [...]
    ///
    ///     try CodableHelpers.sequences.dynamicElementEncoding(objects, to: encoder, usingKey: "id")
    ///
    ///     // This converts the encoded objects to (in JSON)
    ///     {
    ///         "{id}": { variableA: 3, variableB: false },
    ///         ...
    ///     }
    ///
    /// - Parameters:
    ///   - s: Sequence of Encodable elements to dynamically encode
    ///   - elementKey: The CodingKey within the Element to encode to
    func dynamicElementEncoding<S>(_ s: S,
                                   usingKey elementKey: String) throws -> EncodedData where S: Sequence, S.Element: Encodable {
        
        
        return try self.encode(EncodableObject(objects: s, elementKey: elementKey))
    }
}

public extension EncoderType where Self: SupportedArrayRootEncoderType {
    /// Encodes a Sequence of Any objects if supported from the root
    ///
    /// - Parameters:
    ///   - array: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
    ///   - encoder: The encoder to encode the sequence to
    func encodeAnyArray<S>(_ array: S) throws -> EncodedData where S: Sequence, S.Element == Any {
        /*let encoderHelper = UnkeyedEncoderHelper() { container in
            try container._encodeArray(array)
        }*/
        let encoderHelper = UnkeyedEncodingContainerCatcher() { container in
            try container._encodeAnyArray(array)
        }
        return try self.encode(encoderHelper)
    }
}

public extension StandardEncoderType where Self: SupportedDictionaryRootEncoderType {
    /// Encode a dictionary to a container
    ///
    /// - Parameters:
    ///   - dictionary: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
    ///   - encoder: The encoder to encode the dictionary to
    func stdEncodeAnyDictionary<D>(_ dictionary: D) throws -> Data where D: SDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        
        /*let encoderHelper = KeyedEncoderHelper(keyType: CodableKey.self) { container in
            try container._encodeDictionary(dictionary)
        }*/
        let encoderHelper = KeyedEncodingContainerCatcher(keyType: CodableKey.self) { container in
            try container._encodeAnyDictionary(dictionary)
        }
        
        return try self.encode(encoderHelper)
    }
    
    /// Provides an easy way of encoding an array of objects like a dictionary using one of the object properties as the key.
    ///
    /// Note: Array order is not guarenteed.  This is dependant on how the the EncodingType handles Dictionaries
    ///
    ///     struct EncodingElement: Encodable {
    ///         let id: String
    ///         let variableA: Int
    ///         let variableB: Bool
    ///     }
    ///
    ///     let objects: [EncodingElement] = [...]
    ///
    ///     try CodableHelpers.sequences.dynamicElementEncoding(objects, to: encoder, usingKey: "id")
    ///
    ///     // This converts the encoded objects to (in JSON)
    ///     {
    ///         "{id}": { variableA: 3, variableB: false },
    ///         ...
    ///     }
    ///
    /// - Parameters:
    ///   - s: Sequence of Encodable elements to dynamically encode
    ///   - elementKey: The CodingKey within the Element to encode to
    func stdDynamicElementEncoding<S>(_ s: S,
                                   usingKey elementKey: String) throws -> Data where S: Sequence, S.Element: Encodable {
        
        
        return try self.encode(EncodableObject(objects: s, elementKey: elementKey))
    }
}

public extension StandardEncoderType where Self: SupportedArrayRootEncoderType {
    /// Encodes a Sequence of Any objects if supported from the root
    ///
    /// - Parameters:
    ///   - array: Any dictionary type where the Key is DictionaryKeyCodable and Value is Any where can cast to Encodable
    ///   - encoder: The encoder to encode the sequence to
    func stdEncodeAnyArray<S>(_ array: S) throws -> Data where S: Sequence, S.Element == Any {
        /*let encoderHelper = UnkeyedEncoderHelper() { container in
            try container._encodeArray(array)
        }*/
        let encoderHelper = UnkeyedEncodingContainerCatcher() { container in
            try container._encodeAnyArray(array)
        }
        return try self.encode(encoderHelper)
    }
}

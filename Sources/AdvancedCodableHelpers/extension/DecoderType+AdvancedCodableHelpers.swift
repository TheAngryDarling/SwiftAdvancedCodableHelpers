//
//  DecoderType+AdvancedCodableHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-11-25.
//

import Foundation
import SwiftClassCollections
import BasicCodableHelpers

public extension DecoderType {
    
    /// Dynamically decode the given data in a custom way.
    ///
    /// Note: Same as sdtDecode
    ///
    /// Original intention is for when decoding sub classes when the type is unknown at compile time
    /// - Parameters:
    ///   - data: The data to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    func dtDecode<T>(from data: EncodedData, decodingFunc: (Decoder) throws -> T) throws -> T {
        let wrappedDecoder = try self.decode(DecoderCatcher.self, from: data)
        return try decodingFunc(wrappedDecoder.decoder)
    }
    
    /// Dynamically decode the given data in a custom way.
    ///
    /// Original intention is for when decoding sub classes when the type is unknown at compile time
    /// - Parameters:
    ///   - data: The data to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    @available(*, deprecated, renamed: "dtDecode")
    func decode<T>(from data: EncodedData, decodingFunc: (Decoder) throws -> T) throws -> T {
        //return try dtDecode(from: data, decodingFunc: decodingFunc)
        let wrappedDecoder = try self.decode(DecoderCatcher.self, from: data)
        return try decodingFunc(wrappedDecoder.decoder)
    }
}

public extension StandardDecoderType {
    /// Dynamically decode the given data in a custom way.
    ///
    /// Note: Same as dtDecode
    ///
    /// Original intention is for when decoding sub classes when the type is unknown at compile time
    /// - Parameters:
    ///   - data: The data to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    func sdtDecode<T>(from data: Data, decodingFunc: (Decoder) throws -> T) throws -> T {
        let wrappedDecoder = try self.decode(DecoderCatcher.self, from: data)
        return try decodingFunc(wrappedDecoder.decoder)
    }
    
    /// Dynamically decode the given data in a custom way.
    ///
    /// Original intention is for when decoding sub classes when the type is unknown at compile time
    /// - Parameters:
    ///   - data: The data to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    @available(*, deprecated, renamed: "sdtDecode")
    func decode<T>(from data: Data, decodingFunc: (Decoder) throws -> T) throws -> T {
        return try sdtDecode(from: data, decodingFunc: decodingFunc)
    }
}

public extension DecoderType where Self: SupportedDictionaryRootDecoderType {
    /// Decode a Dictionary type based on return from the given container
    ///
    /// Note: Same as dtDecodeDictionary
    ///
    /// - Parameters:
    ///   - data: The data to decode from
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    ///
    /// - Returns: Return a dictionary type based on return
    func decodeAnyDictionary<D>(from data: EncodedData,
                             excludingKeys: [D.Key] = [],
                             customDecoding: @escaping (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        
        self.userInfo[.customDecoding] = customDecoding
        self.userInfo[.excludingKeys] = excludingKeys
        defer {
            self.userInfo.removeValue(forKey: .customDecoding)
            self.userInfo.removeValue(forKey: .excludingKeys)
        }
        let dc = try self.decode(ContainedCodableDictionary<D>.self, from: data)
        return dc.dictionary
    }
    
    /// Decode a Dictionary type based on return from the given decoder
    ///
    /// Note: Same as dtDecodeDictionary
    ///
    /// - Parameters:
    ///   - type: The dictionary type to decode
    ///   - data: The data to decode from
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    ///
    /// - Returns: Return a dictionary type based on return
    func decodeAnyDictionary<D>(_ type: D.Type,
                                from data: EncodedData,
                                excludingKeys: [D.Key] = [],
                             customDecoding: @escaping (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        let rtn: D = try self.decodeAnyDictionary(from: data,
                                                  excludingKeys: excludingKeys,
                                                  customDecoding: customDecoding)
        return rtn
    }
}

public extension DecoderType where Self: SupportedArrayRootDecoderType {
    /// Decodes an Array<Any> if supported from the root
    ///
    /// Note: Same as stdDecode
    ///
    /// Decoding sequence tries as follows:
    ///    Int, UInt, Float, String, Double, Bool, Date, Data, Complex Object, Array
    ///
    /// - Parameters:
    ///   - data: The data to decode from
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    /// - Returns: Returns an array of decoded objects
    func decodeAnyArray(from data: EncodedData,
                        customDecoding: @escaping (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> [Any] {

        self.userInfo[.customDecoding] = customDecoding
        defer { self.userInfo.removeValue(forKey: .customDecoding) }
        let a = try self.decode(ContainedCodableArray<Array<Any>>.self,
                                   from: data)
        return a.array
    }
    
    /// Provides an easy way of decoding dictionaries of objects like an array using the key as one of the object property values.
    ///
    /// Note: Array order is not guarenteed.  This is dependant on how the the DecodingType handles Dictionaries
    ///
    ///     struct EncodingElement: Decodable {
    ///         let id: String
    ///         let variableA: Int
    ///         let variableB: Bool
    ///     }
    ///
    ///     // JSON data that is in the decoder
    ///     {
    ///         "{id}": { variableA: 3, variableB: false },
    ///         ...
    ///     }
    ///
    ///     let objects = try dynamicElementDecoding(EncodingElement.self,
    ///                                              from: data,
    ///                                              usingKey: "id")
    ///
    /// - Parameters:
    ///   - type: The decodable type to decode to
    ///   - data: The data to decode from
    ///   - elementKey: The coding key
    /// - Returns: Returns an array of decoded objects
    func dynamicElementDecoding<Element>(_ type: Element.Type,
                                         from data: EncodedData,
                                         usingKey elementKey: String) throws -> Array<Element> where Element: Decodable {
        let decoderCatcher = try self.decode(DecoderCatcher.self, from: data)
        return try decoderCatcher.decoder.dynamicElementDecoding(Element.self,
                                                                 usingKey: elementKey)
    }
    
    /// Provides an easy way of decoding dictionaries of objects like an array using the key as one of the object property values.
    ///
    /// Note: Array order is not guarenteed.  This is dependant on how the the DecodingType handles Dictionaries
    ///
    ///     struct EncodingElement: Decodable {
    ///         let id: String
    ///         let variableA: Int
    ///         let variableB: Bool
    ///     }
    ///
    ///     // JSON data that is in the decoder
    ///     {
    ///         "{id}": { variableA: 3, variableB: false },
    ///         ...
    ///     }
    ///
    ///     let objects = try dynamicElementDecoding(EncodingElement.self,
    ///                                              withData: data,
    ///                                              usingKey: "id")
    ///
    /// - Parameters:
    ///   - data: The data to decode from
    ///   - elementKey: The coding key
    ///   - decodingFunc: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    /// - Returns: Returns an array of decoded objects
    func dynamicElementDecoding<Element>(from data: EncodedData,
                                        usingKey elementKey: String,
                                        decodingFunc: (_ decoder: Decoder) throws -> Element) throws -> Array<Element> {
        
        let decoderCatcher = try self.decode(DecoderCatcher.self, from: data)
        return try decoderCatcher.decoder.dynamicElementDecoding(usingKey: elementKey,
                                                                 decodingFunc: decodingFunc)
    }
}

public extension StandardDecoderType where Self: SupportedDictionaryRootDecoderType {
    /// Decode a Dictionary type based on return from the given container
    ///
    /// Note: Same as decodeAnyDictionary
    ///
    /// - Parameters:
    ///   - data: The data to decode from
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    ///
    /// - Returns: Return a dictionary type based on return
    func stdDecodeAnyDictionary<D>(from data: Data,
                             excludingKeys: [D.Key] = [],
                             customDecoding: @escaping (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        
        self.userInfo[.customDecoding] = customDecoding
        self.userInfo[.excludingKeys] = excludingKeys
        defer {
            self.userInfo.removeValue(forKey: .customDecoding)
            self.userInfo.removeValue(forKey: .excludingKeys)
        }
        let dc = try self.decode(ContainedCodableDictionary<D>.self, from: data)
        return dc.dictionary
    }
    
    /// Decode a Dictionary type based on return from the given container
    ///
    /// Note: Same as decodeAnyDictionary
    ///
    /// - Parameters:
    ///   - type: The dictionary type to decode
    ///   - data: The data to decode from
    ///   - excludingKeys: Any keys to exclude from the top level
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    ///
    /// - Returns: Return a dictionary type based on return
    func stdDecodeAnyDictionary<D>(_ type: D.Type,
                                from data: Data,
                                excludingKeys: [D.Key] = [],
                             customDecoding: @escaping (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> D where D: ReEncapsulatableDictionary, D.Key: DictionaryKeyCodable, D.Value == Any {
        let rtn: D = try self.stdDecodeAnyDictionary(from: data,
                                                     excludingKeys: excludingKeys,
                                                     customDecoding: customDecoding)
        return rtn
    }
}

public extension StandardDecoderType where Self: SupportedArrayRootDecoderType {
    /// Decodes an Array<Any> if supported from the root
    ///
    /// Note: Same as decodeAnyArray
    ///
    /// Decoding sequence tries as follows:
    ///    Int, UInt, Float, String, Double, Bool, Date, Data, Complex Object, Array
    ///
    /// - Parameters:
    ///   - data: The data to decode from
    ///   - customDecoding: Function to try and do custom decoding of complex objects or nil if no custom decoded required
    /// - Returns: Returns an array of decoded objects
    func stdDecodeAnyArray(from data: Data,
                           customDecoding: @escaping (_ decoder: Decoder) throws -> Any? = { _ in return nil }) throws -> [Any] {

        self.userInfo[.customDecoding] = customDecoding
        defer { self.userInfo.removeValue(forKey: .customDecoding) }
        let a = try self.decode(ContainedCodableArray<Array<Any>>.self,
                                   from: data)
        return a.array
    }
    
    /// Provides an easy way of decoding dictionaries of objects like an array using the key as one of the object property values.
    ///
    /// Note: Array order is not guarenteed.  This is dependant on how the the DecodingType handles Dictionaries
    ///
    ///     struct EncodingElement: Decodable {
    ///         let id: String
    ///         let variableA: Int
    ///         let variableB: Bool
    ///     }
    ///
    ///     // JSON data that is in the decoder
    ///     {
    ///         "{id}": { variableA: 3, variableB: false },
    ///         ...
    ///     }
    ///
    ///     let objects = try dynamicElementDecoding(decoder: decoder, withData: data, usingKey: "id", ofType: EncodingElement.self)
    ///
    /// - Parameters:
    ///   - type: The decodable type to decode to
    ///   - data: The data to decode from
    ///   - elementKey: The coding key
    /// - Returns: Returns an array of decoded objects
    func stdDynamicElementDecoding<Element>(_ type: Element.Type,
                                            from data: Data,
                                            usingKey elementKey: String) throws -> Array<Element> where Element: Decodable {
           let decoderCatcher = try self.decode(DecoderCatcher.self, from: data)
           return try decoderCatcher.decoder.dynamicElementDecoding(Element.self,
                                                                    usingKey: elementKey)
    }
}

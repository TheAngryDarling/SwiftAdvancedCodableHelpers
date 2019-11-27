//
//  DecoderType+AdvancedCodableHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-11-25.
//

import Foundation
import BasicCodableHelpers

public extension DecoderType {
    /// Dynamically decode the given data in a custom way.
    ///
    /// Original intention is for when decoding sub classes when the type is unknown at compile time
    /// - Parameters:
    ///   - data: The data to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    func decode<T>(from data: EncodedData, decodingFunc: (Decoder) throws -> T) throws -> T {
        let wrappedDecoder = try self.decode(DecoderCatcher.self, from: data)
        return try decodingFunc(wrappedDecoder.decoder)
    }
}

public extension StandardDecoderType {
    /// Dynamically decode the given data in a custom way.
    ///
    /// Original intention is for when decoding sub classes when the type is unknown at compile time
    /// - Parameters:
    ///   - data: The data to decode
    ///   - decodingFunc: The decoding function to call providing the decoder
    func decode<T>(from data: Data, decodingFunc: (Decoder) throws -> T) throws -> T {
        let wrappedDecoder = try self.decode(DecoderCatcher.self, from: data)
        return try decodingFunc(wrappedDecoder.decoder)
    }
}

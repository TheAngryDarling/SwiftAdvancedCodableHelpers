//
//  SingleValueDecodingContainer+AdvancedCodableHelpers.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-11-27.
//

import Foundation

public extension SingleValueDecodingContainer {
    /// Dynamically decode a given type.
    /// - Parameters:
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    func decode<T>(decodingFunc: (_ decoder: Decoder) throws -> T) throws -> T {
        let wrappedDecoder = try self.decode(DecoderCatcher.self)
        return try decodingFunc(wrappedDecoder.decoder)
    }
    /// Dynamically decode a given type if present.
    /// - Parameters:
    ///   - decodingFunc: The decoding function to call providing the decoder
    ///   - decoder: The decoder used within the custom decoding function
    func decodeIfPresent<T>(decodingFunc: (_ decoder: Decoder) throws -> T) throws -> T? {
        guard !self.decodeNil() else { return nil }
        return try decode(decodingFunc: decodingFunc)
    }
}

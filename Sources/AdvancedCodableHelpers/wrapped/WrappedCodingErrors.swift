//
//  WrappedCodingErrors.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-04-27.
//

import Foundation

/// Class that wraps around methods to catch Encoding/Decoding errors and fix any adjusted coding paths
class WrappedCodingErrors {
    
    @discardableResult
    public static func repackage<R>(_ newCodingPath: [CodingKey], _ disableRepackaging: Bool = false, f: () throws -> R) throws -> R {
        do {
            return try f()
        } catch {
            if disableRepackaging { throw error }
            else { throw repackage(error, withNewCodingPath: newCodingPath) }
        }
    }
    private static func repackage(_ error: Error, withNewCodingPath codingPath: [CodingKey]) -> Error {
        if let e = error as? EncodingError { return repackageEncodingError(e, withNewCodingPath: codingPath) }
        else if let e = error as? DecodingError { return repackageDecodingError(e, withNewCodingPath: codingPath) }
        else { return error }
    }
    private static func repackageEncodingError(_ error: EncodingError, withNewCodingPath codingPath: [CodingKey]) -> Error {
        switch error {
            case .invalidValue(let a, let c):
                // If coding paths match, then lets not wrap the error
                guard c.codingPath.stringCodingPath != codingPath.stringCodingPath else { return error }
                return EncodingError.invalidValue(a,
                                                 EncodingError.Context(codingPath: codingPath,
                                                                       debugDescription: c.debugDescription,
                                                                       underlyingError: error))
            
            //default:
            //    return error
        }
    }
    
    private static func repackageDecodingError(_ error: DecodingError, withNewCodingPath codingPath: [CodingKey]) -> Error {
        switch error {
            case .dataCorrupted(let c):
                // If coding paths match, then lets not wrap the error
                guard c.codingPath.stringCodingPath != codingPath.stringCodingPath else { return error }
                return DecodingError.dataCorrupted(DecodingError.Context(codingPath: codingPath,
                                                                        debugDescription: c.debugDescription,
                                                                        underlyingError: error))
            case .keyNotFound(let k, let c):
                // If coding paths match, then lets not wrap the error
                guard c.codingPath.stringCodingPath != codingPath.stringCodingPath else { return error }
                return DecodingError.keyNotFound(k, DecodingError.Context(codingPath: codingPath,
                                                                         debugDescription: c.debugDescription,
                                                                         underlyingError: error))
            case .typeMismatch(let a, let c):
                // If coding paths match, then lets not wrap the error
                guard c.codingPath.stringCodingPath != codingPath.stringCodingPath else { return error }
                return DecodingError.typeMismatch(a, DecodingError.Context(codingPath: codingPath,
                                                                          debugDescription: c.debugDescription,
                                                                          underlyingError: error))
            case .valueNotFound(let a, let c):
                // If coding paths match, then lets not wrap the error
                guard c.codingPath.stringCodingPath != codingPath.stringCodingPath else { return error }
                return DecodingError.valueNotFound(a, DecodingError.Context(codingPath: codingPath,
                                                                           debugDescription: c.debugDescription,
                                                                           underlyingError: error))
            //default:
            //    return error
        }
    }
}

//
//  WrappedSingleValueDecodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-04-27.
//

import Foundation

/// A container that wraps a WrappedSingleValueDecodingContainer allowing to override the coding path
open class WrappedSingleValueDecodingContainer: SingleValueDecodingContainer {
    private var container: SingleValueDecodingContainer
    public let codingPath: [CodingKey]
    
    private let disableRepackagingErrors: Bool
    
    public init(_ container: SingleValueDecodingContainer, customCodingPath: [CodingKey]? = nil) {
        self.container = container
        self.codingPath = customCodingPath ?? container.codingPath
        self.disableRepackagingErrors = (customCodingPath == nil || (customCodingPath!.stringCodingPath == container.codingPath.stringCodingPath))
    }
    
    open func decodeNil() -> Bool {
        return self.container.decodeNil()
    }
    
    open func decode(_ type: Bool.Type) throws -> Bool {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            return try self.container.decode(type)
        }
    }
    
    open func decode(_ type: String.Type) throws -> String {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors)  {
            return try self.container.decode(type)
        }
    }
    
    open func decode(_ type: Double.Type) throws -> Double {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors)  {
            return try self.container.decode(type)
        }
    }
    
    open func decode(_ type: Float.Type) throws -> Float {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors)  {
            return try self.container.decode(type)
        }
    }
    
    open func decode(_ type: Int.Type) throws -> Int {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors)  {
            return try self.container.decode(type)
        }
    }
    
    open func decode(_ type: Int8.Type) throws -> Int8 {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors)  {
            return try self.container.decode(type)
        }
    }
    
    open func decode(_ type: Int16.Type) throws -> Int16 {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors)  {
            return try self.container.decode(type)
        }
    }
    
    open func decode(_ type: Int32.Type) throws -> Int32 {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors)  {
            return try self.container.decode(type)
        }
    }
    
    open func decode(_ type: Int64.Type) throws -> Int64 {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors)  {
            return try self.container.decode(type)
        }
    }
    
    open func decode(_ type: UInt.Type) throws -> UInt {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors)  {
            return try self.container.decode(type)
        }
    }
    
    open func decode(_ type: UInt8.Type) throws -> UInt8 {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors)  {
            return try self.container.decode(type)
        }
    }
    
    open func decode(_ type: UInt16.Type) throws -> UInt16 {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors)  {
            return try self.container.decode(type)
        }
    }
    
    open func decode(_ type: UInt32.Type) throws -> UInt32 {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors)  {
            return try self.container.decode(type)
        }
    }
    
    open func decode(_ type: UInt64.Type) throws -> UInt64 {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors)  {
            return try self.container.decode(type)
        }
    }
    
    open func decode<T>(_ type: T.Type) throws -> T where T : Decodable {
        return try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors)  {
            if let d = self.container as? Decoder {
                let dec: WrappedDecoder!
                if let de = d as? WrappedDecoder { dec = de }
                else { dec = WrappedDecoder(d, customCodingPath: self.codingPath) }
                return try T(from: dec)
            } else {
                // TODO: -  Will need to figure out how to properly wrap
                return try self.container.decode(type)
            }
        }
    }
}

//
//  SingleValueEncodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2019-04-27.
//

import Foundation

/// A container that wraps a WrappedSingleValueEncodingContainer allowing to override the coding path
open class WrappedSingleValueEncodingContainer: SingleValueEncodingContainer {
    private var container: SingleValueEncodingContainer
    public let codingPath: [CodingKey]
    
    private let disableRepackagingErrors: Bool
    
    public init(_ container: SingleValueEncodingContainer, customCodingPath: [CodingKey]? = nil) {
        self.container = container
        self.codingPath = customCodingPath ?? container.codingPath
        self.disableRepackagingErrors = (customCodingPath == nil || (customCodingPath!.stringCodingPath == container.codingPath.stringCodingPath))
    }
    
    
    open func encodeNil() throws {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors)  {
            try self.container.encodeNil()
        }
    }
    
    open func encode(_ value: Bool) throws {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            try self.container.encode(value)
        }
    }
    
    open func encode(_ value: String) throws {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            try self.container.encode(value)
        }
    }
    
    open func encode(_ value: Double) throws {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            try self.container.encode(value)
        }
    }
    
    open func encode(_ value: Float) throws {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            try self.container.encode(value)
        }
    }
    
    open func encode(_ value: Int) throws {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            try self.container.encode(value)
        }
    }
    
    open func encode(_ value: Int8) throws {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            try self.container.encode(value)
        }
    }
    
    open func encode(_ value: Int16) throws {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            try self.container.encode(value)
        }
    }
    
    open func encode(_ value: Int32) throws {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            try self.container.encode(value)
        }
    }
    
    open func encode(_ value: Int64) throws {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            try self.container.encode(value)
        }
    }
    
    open func encode(_ value: UInt) throws {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            try self.container.encode(value)
        }
    }
    
    open func encode(_ value: UInt8) throws {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            try self.container.encode(value)
        }
    }
    
    open func encode(_ value: UInt16) throws {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            try self.container.encode(value)
        }
    }
    
    open func encode(_ value: UInt32) throws {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            try self.container.encode(value)
        }
    }
    
    open func encode(_ value: UInt64) throws {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            try self.container.encode(value)
        }
    }
    
    open func encode<T>(_ value: T) throws where T : Encodable {
        try WrappedCodingErrors.repackage(self.codingPath, disableRepackagingErrors) {
            
            if let e = self.container as? Encoder {
                let enc: WrappedEncoder!
                if let en = e as? WrappedEncoder { enc = en }
                else { enc = WrappedEncoder(e, customCodingPath: self.codingPath) }
                try value.encode(to: enc)
            } else {
                // TODO: -  Will need to figure out how to properly wrap
                try self.container.encode(value)
            }
        }
    }
}

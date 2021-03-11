//
//  FilteredEncodingContainer.swift
//  AdvancedCodableHelpers
//
//  Created by Tyler Anger on 2018-11-06.
//

import Foundation

/// Base class for filtered encoding containers
public class FilteredEncodingContainer {
    public typealias FilteredEncodedCallResults = Bool
    
    /// Method definition used for filtering out specific keyed encoded obejects
    ///
    /// - Parameters:
    ///   - rootFilteredContainer: Root filtered encoding container
    ///   - currentFilteredContainer: Current filtered encoding contianer
    ///   - method: Encoding method name that was called
    ///   - childKey: Encoding Key
    ///   - value: Value being encoding
    /// - Returns: Returns true if the call can actually be encoded, otherwise false
    public typealias FilterEncoding = (_ rootFilteredContainer: FilteredEncodingContainer, _ currentFilteredContainer: FilteredEncodingContainer, _ method: String, _ childKey: CodingKey?, _ value: Any?) throws -> FilteredEncodedCallResults
    
    /// The path of coding keys taken to get to this point in encoding.
    public let codingPath: [CodingKey]
    
    /// The filter method used to determin of any of the encoding calls can be executed on the real container
    internal private(set) var filterEncoding: FilterEncoding
    
    /// The root filterd container if thiere is one.  If this is populated it is passed in the filteredEncoding method
    internal private(set) var rootContainer: FilteredEncodingContainer?
    
    /// Creates a new instance of FilteredEncodingContainer
    ///
    /// Note: this should not be called directly, please use one of the inherited classes
    ///
    /// - Parameters:
    ///   - codingPath: The current coding path
    ///   - rootContainer: Reference to a root filetered container if there is one
    ///   - filter: The filter method used to filter out specific encoding calls
    public init(codingPath: [CodingKey], rootContainer: FilteredEncodingContainer? = nil, filter: @escaping FilterEncoding) {
        self.codingPath = codingPath
        self.rootContainer = rootContainer
        self.filterEncoding = filter
    }
    
    /// Function that determins if the calling encoding method can actually encode
    ///
    /// - Parameters:
    ///   - method: Calling method
    ///   - childKey: Calling coding key
    ///   - value: value to encode
    /// - returns: Returns an indicator if the object was encoded or not   
    internal func canEncode(method: String, childKey: CodingKey? = nil, value: Any?) throws -> FilteredEncodedCallResults {
        let r = self.rootContainer ?? self
        
        let rtn = try self.filterEncoding(r, self, method, childKey, value)
        return rtn
    }
}

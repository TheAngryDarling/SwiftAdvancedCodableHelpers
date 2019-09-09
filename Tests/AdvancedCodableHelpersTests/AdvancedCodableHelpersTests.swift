import XCTest
import Nillable
@testable import AdvancedCodableHelpers

extension String: Error { }

class AdvancedCodableHelpersTests: XCTestCase {
    struct Name {
        let firstName: String
        let lastName: String
    }
    enum Gender: String, Codable {
        case male = "m"
        case female = "f"
        case other = "o"
    }
    struct SubPersonObject: Codable {
        private enum CodingKeys: CodingKey {
            case valA
            case valB
            case valC
        }
        let valA: Bool
        let valB: String?
        let valC: Int
        
        public init(valA: Bool, valB: String?, valC: Int) {
            self.valA = valA
            self.valB = valB
            self.valC = valC
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.valA = try container.decode(Bool.self, forKey: .valA)
            self.valB = try container.decodeIfPresent(String.self, forKey: .valB)
            //self.valB = try container.decode(String.self, forKey: .valB)
            self.valC = try container.decode(Int.self, forKey: .valC)
            //print("SubPersonObject.init(from:) - \(container.codingPath.stringPath)")
            let _ = true
        }
        
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.valA, forKey: .valA)
            try container.encodeIfPresent(self.valB, forKey: .valB)
            try container.encode(self.valC, forKey: .valC)
            //print("SubPersonObject.encode(to:) - \(container.codingPath.stringPath)")
            let _ = true
        }
        
    }
    struct Person: Codable {
        let name: Name
        let age: Int
        let gender: Gender
        let subItems: SubPersonObject
    }
    
    struct CodableSequenceArray: CodableSequenceDynamicKeyHelper {
        static var ElementKey: String = "name"
        
        private var ary: [Person] = []
        
        public init() { }
        
        public mutating func append(_ element: Person) { self.ary.append(element) }
        
        init<S>(_ s: S) where S : Sequence, S.Element == Person {
            self.ary.append(contentsOf: s)
        }
        
        public func makeIterator() -> Array<Person>.Iterator {
            return ary.makeIterator()
        }
        
        public mutating func sort() {
            self.ary.sort()
        }
        
    }
    
    func testCodingCustomSequence() {
        let p1 = Person(name: "Person A", age: 36, gender: .male, subItems: SubPersonObject(valA: true, valB: "Test 1", valC: 1))
        let p2 = Person(name: "Person B", age: 30, gender: .female, subItems: SubPersonObject(valA: false, valB: nil, valC: 2))
        
        var ary: CodableSequenceArray = CodableSequenceArray()
        //var ary: Array<Person> = Array<Person>()
        ary.append(p1)
        ary.append(p2)
        ary.sort()
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let d = try encoder.encode(ary)
            #if verbose
            let s = String(data: d, encoding: .utf8)!
            print(s)
            #endif
            
            let decoder = JSONDecoder()
            var r = try decoder.decode(CodableSequenceArray.self, from: d)
            r.sort()
            #if verbose
            print(r)
            #endif
            
            if !(ary == r) {
                #if verbose
                print("----------------------------")
                print("----------------------------")
                print(ary)
                print("----------------------------")
                print(r)
                #endif
                XCTFail("Arrays do no match")
            }
            
        } catch {
            XCTFail("\(error)")
        }
        
    }
    
    func testCodingArray() {
        let p1 = Person(name: "Person A", age: 36, gender: .male, subItems: SubPersonObject(valA: true, valB: "Test 1", valC: 1))
        let p2 = Person(name: "Person B", age: 30, gender: .female, subItems: SubPersonObject(valA: false, valB: nil, valC: 2))
        
        var ary: [Person] = [p1, p2]
        ary.sort()
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let d = try CodableHelpers.sequences.dynamicElementEncoding(ary,
                                                                        to: encoder,
                                                                        usingKey: "name")
            //let d = try encoder.encode(ary)
            #if verbose
            let s = String(data: d, encoding: .utf8)!
            print(s)
            #endif
            
            let decoder = JSONDecoder()
            
            //var r = try decoder.decode(CodableSequenceArray.self, from: d)
            var r = try CodableHelpers.sequences.dynamicElementDecoding(from: decoder,
                                                                        withData: d,
                                                                        usingKey: "name",
                                                                        ofType: Person.self)
            r.sort()
            #if verbose
            print(r)
            #endif
            
            if !(ary == r) {
                #if verbose
                print("----------------------------")
                print("----------------------------")
                print(ary)
                print("----------------------------")
                print(r)
                #endif
                XCTFail("Arrays do no match")
            }
            
        } catch {
            XCTFail("\(error)")
        }
        
    }
    
    func testSwiftDictionaryCoding() {
        
        func testDictionaryCoding<K>(_ originalDictionary:  Dictionary<K, Any>) throws -> Bool where K: DictionaryKeyCodable {
            #if verbose
            print(originalDictionary)
            #endif
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            
            
            let d = try CodableHelpers.dictionaries.encode(originalDictionary, to: encoder)  //try encoder.encode(origionalStringDictionary)
            
            #if verbose
            let s = String(data: d, encoding: .utf8)!
            print(s)
            #endif
            
            let decoder = JSONDecoder()
            
            let decodedDict: Dictionary<K, Any> = try CodableHelpers.dictionaries.decode(d, from: decoder)
            
            #if verbose
            print(decodedDict)
            #endif
            
            let rtn = originalDictionary.equals(decodedDict)
            
            if !rtn {
                print("originalDictionary: \n\(originalDictionary)")
                print("decodedDict: \n\(decodedDict)")
            }
            
            return rtn
        }
        
        do {
            
            var originalDictionary = Dictionary<String, Any>()
            originalDictionary["Person A"] = "Name A"
            originalDictionary["Person B"] = "Name B"
            originalDictionary["Person C"] = ["First Name", "Last Name"]
            originalDictionary["Person D"] = Optional<Float>(3.2)
            originalDictionary["Person E"] = 1
            
            let eq = try testDictionaryCoding(originalDictionary)
            
            XCTAssert(eq, "\(type(of: originalDictionary)) Dictionaries don't match")
            
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            
            
            let d = try CodableHelpers.dictionaries.encode(originalDictionary, to: encoder)  //try encoder.encode(origionalStringDictionary)
            
            #if verbose
            let s = String(data: d, encoding: .utf8)!
            print(s)
            #endif
            
            let decoder = JSONDecoder()
            
            let decodedDict: Dictionary<String, Any> = try CodableHelpers.dictionaries.decode(d,
                                                                                              from: decoder,
                                                                                              excludingKeys: [originalDictionary.keys.first!])
            XCTAssert(!decodedDict.keys.contains(originalDictionary.keys.first!), "Excluding key '\(originalDictionary.keys.first!)' was found in decoded dictionary")
            
            #if verbose
            print(decodedDict)
            #endif
            
            
            
        } catch {
            XCTFail("\(error)")
        }
        
        
        do {
            
            var originalDictionary = Dictionary<Int, Any>()
            originalDictionary[1] = "Name A"
            originalDictionary[2] = AnyNil
            originalDictionary[3] = "Name B"
            
            let eq = try testDictionaryCoding(originalDictionary)
            
            XCTAssert(eq, "\(type(of: originalDictionary)) Dictionaries don't match")
            
            
        } catch {
            XCTFail("\(error)")
        }
        
        /*do {
         
         var originalDictionary = Dictionary<Bool, Any>()
         originalDictionary[true] = "Name A"
         originalDictionary[false] = AnyNil
         
         let eq = try testDictionaryCoding(originalDictionary)
         
         XCTAssert(eq, "\(type(of: originalDictionary)) Dictionaries don't match")
         
         
         } catch {
         XCTFail("\(error)")
         }*/
        
    }


    static var allTests = [
        ("testCodingCustomSequence", testCodingCustomSequence),
        ("testCodingArray", testCodingArray),
        ("testSwiftDictionaryCoding", testSwiftDictionaryCoding),
    ]
}

extension AdvancedCodableHelpersTests.Name: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        let n = value.split(separator: " ")
        let f = String(n[0])
        var l = ""
        if n.count > 1 { l = String(n[1]) }
        self.init(firstName: f, lastName: l)
    }
}

extension AdvancedCodableHelpersTests.Name: Codable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let s = try container.decode(String.self)
        self.init(stringLiteral: s)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.firstName + " " + self.lastName)
    }
}

extension AdvancedCodableHelpersTests.Name: Comparable {
    public static func == (lhs: AdvancedCodableHelpersTests.Name, rhs: AdvancedCodableHelpersTests.Name) -> Bool {
        return ((lhs.firstName == rhs.firstName) && (lhs.lastName == rhs.lastName))
    }
    public static func < (lhs: AdvancedCodableHelpersTests.Name, rhs: AdvancedCodableHelpersTests.Name) -> Bool {
        return (lhs.firstName + " " + lhs.lastName) < (rhs.firstName + " " + rhs.lastName)
    }
}

extension AdvancedCodableHelpersTests.SubPersonObject: Equatable {
    public static func == (lhs: AdvancedCodableHelpersTests.SubPersonObject, rhs: AdvancedCodableHelpersTests.SubPersonObject) -> Bool {
        return ((lhs.valA == rhs.valA) && (lhs.valB == rhs.valB) && (lhs.valC == rhs.valC))
    }
}

extension AdvancedCodableHelpersTests.Person: Comparable {
    public static func == (lhs: AdvancedCodableHelpersTests.Person, rhs: AdvancedCodableHelpersTests.Person) -> Bool {
        return ((lhs.age == rhs.age) && (lhs.gender == rhs.gender) && (lhs.name == rhs.name) && (lhs.subItems == rhs.subItems))
    }
    public static func < (lhs: AdvancedCodableHelpersTests.Person, rhs: AdvancedCodableHelpersTests.Person) -> Bool {
        return (lhs.name < rhs.name)
    }
}

extension AdvancedCodableHelpersTests.CodableSequenceArray: Equatable {
    public static func == (lhs: AdvancedCodableHelpersTests.CodableSequenceArray, rhs: AdvancedCodableHelpersTests.CodableSequenceArray) -> Bool {
        return lhs.ary == rhs.ary
    }
}


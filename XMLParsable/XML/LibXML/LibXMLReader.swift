//
//  LibXMLReader.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 26/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core
import libxml2

public let LibXMLReaderErrorDomain = InMyDomain("libxml.reader")

internal typealias ReaderSequence = SequenceOf<(xmlTextReaderPtr, LibXMLReaderMode)>
internal typealias ReaderGenerator = GeneratorOf<(xmlTextReaderPtr, LibXMLReaderMode)>

internal final class LibXMLReader {
  internal struct Context {
    let reader: xmlTextReaderPtr
    let sequence: ReaderSequence
    var hasFreed: Bool
    
    init (reader: xmlTextReaderPtr, sequence: ReaderSequence) {
      self.reader = reader
      self.sequence = sequence
      self.hasFreed = false
    }
    
    func dispose() {
      if !self.hasFreed {
        xmlFreeTextReader(self.reader)
      }
    }
  }
  
  internal class func error(message: String) -> NSError {
    return NSError(domain: LibXMLReaderErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: message])
  }
  
  internal class func printReader(reader: xmlTextReaderPtr) {
    let type = LibXMLReaderType.forceMake(xmlTextReaderNodeType(reader))
    let typeString = LibXMLReaderGetElementTypeString(type)
    
    switch type {
    case .ELEMENT: println("\(typeString) \(LibXMLReaderGetName(reader))")
    case .END_ELEMENT: println("\(typeString) \(LibXMLReaderGetName(reader))")
    default: println("\(typeString)")
    }
  }

  internal class func printGenerator(generator: ReaderSequence) {
    for (reader, mode) in generator {
      LibXMLReader.printReader(reader)
    }
  }

  internal class func createReader(url: NSURL) -> Result<LibXMLReader.Context> {
    let reader = createReaderFrom(url)
    return {LibXMLReader.Context(reader: reader, sequence: $0) } <^> wrapInSequence(reader)
  }
  
  internal class func createReader(data: NSData) -> Result<LibXMLReader.Context> {
    let reader = createReaderFrom(data)
    return {LibXMLReader.Context(reader: reader, sequence: $0) } <^> wrapInSequence(reader)
  }
  
  private class func wrapInSequence(reader: xmlTextReaderPtr) -> Result<ReaderSequence> {
    if (reader == nil) {
      return Result.Error(self.error("Could Not Parse Document, no root node"))
    }
    
    var generator = LibXMLReader.makeRecursiveGenerator(reader)
    if generator.next() == nil {
      xmlFreeTextReader(reader)
      return Result.Error(self.error("Could Not Parse Document, no first node"))
    }

    return Result.value(SequenceOf(generator))
  }

  private class func makeRecursiveGenerator(reader: xmlTextReaderPtr) -> ReaderGenerator {
    return GeneratorOf {
      if reader == nil {
        return nil
      }

      let result = LibXMLReaderMode.forceMake(xmlTextReaderRead(reader))
      switch result {
      case .CLOSED: return nil
      case .EOF: return nil
      case .ERROR: return nil
      case .INITIAL: return nil
      default: return (reader, result)
      }
    }
  }

  private class func makeSiblingGenerator(reader: xmlTextReaderPtr) -> ReaderGenerator {
    return GeneratorOf {
      if reader == nil {
        return nil
      }

      let result = LibXMLReaderMode.forceMake(xmlTextReaderNext(reader))
      switch result {
      case .CLOSED: return nil
      case .EOF: return nil
      case .ERROR: return nil
      case .INITIAL: return nil
      default: return (reader, result)
      }
    }
  }

  private class func createReaderFrom(url: NSURL) -> xmlTextReaderPtr {
    let urlString = url.path
    let cString = urlString?.cStringUsingEncoding(NSUTF8StringEncoding)
    return xmlNewTextReaderFilename(cString!)
  }
  
  private class func createReaderFrom(data: NSData) -> xmlTextReaderPtr {
    let string = NSString(data: data, encoding: NSUTF8StringEncoding)
    let cString = string.UTF8String
    let length = strlen(cString)
    return xmlReaderForMemory(cString, Int32(length), "foo.bar", nil, 0)
  }
}

extension LibXMLReaderType {
  static func forceMake(reader: xmlTextReaderPtr) -> LibXMLReaderType {
    return self.forceMake(xmlTextReaderNodeType(reader))
  }
  
  static func forceMake(value: Int32) -> LibXMLReaderType {
    return LibXMLReaderType.fromRaw(Int(value))!
  }
}

extension LibXMLReaderMode {
  static func forceMake(value: Int32) -> LibXMLReaderMode {
    return LibXMLReaderMode.fromRaw(Int(value))!
  }
}

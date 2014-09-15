//
//  LibXMLNodeParserReader.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 21/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core

public class LibXMLNodeParserReader: XMLParsableFactoryType {
  public class func createWithData(data: NSData) -> Result<XMLNode> {
    return self.processContext(LibXMLReader.createReader(data))
  }
  
  public class func createWithURL(url: NSURL) -> Result<XMLNode> {
    return self.processContext(LibXMLReader.createReader(url))
  }
    
  private class func processContext(result: Result<LibXMLReader.Context>) -> Result<XMLNode> {
    switch result {
    case .Value(let box):
      let result = self.parseRecursive(box.value.reader, box.value.sequence)
      box.value.dispose()
      return result
    case .Error(let error):
      return Result.error(error)
    }
  }
  
  private class func parseRecursive(reader: xmlTextReaderPtr, _ sequence: ReaderSequence) -> Result<XMLNode> {
    if LibXMLReaderType.forceMake(reader) != .ELEMENT {
      let realType = LibXMLReaderGetElementTypeString(LibXMLReaderType.forceMake(reader))
      return Result.Error(LibXMLReader.error("Recursive Node Parse Requires an ELEMENT, got \(realType)"))
    }
    
    var name = LibXMLReaderGetName(reader)
    var text: String?
    var children: [XMLNode] = []
    
    if LibXMLReaderIsEmpty(reader) {
      return Result.value(XMLNode(name: name, text: text, children: children))
    }
    
    for (reader, mode) in sequence {
      let type = LibXMLReaderType.forceMake(xmlTextReaderNodeType(reader))
      let typeString = LibXMLReaderGetElementTypeString(type)
      let modeString = LibXMLReaderGetReaderMode(mode)
      
      switch type {
        case .TEXT:
          text = LibXMLReaderGetText(reader);
        case .ELEMENT:
          let childResult = self.parseRecursive(reader, sequence)
          switch childResult {
          case .Error(let error): return childResult
          case .Value(let box): children.append(childResult.toOptional()!)
          }
        case .END_ELEMENT:
          assert(name == LibXMLReaderGetName(reader), "BEGIN AND END NOT MATCHED")
          return Result.value(XMLNode(name: name, text: text, children: children))
        default:
          break
      }
    }
    
    return Result.Error(LibXMLReader.error("I don't know how this became exhausted, unbalanced begin and end of document"))
  }
}

//
//  LibXMLDOM.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 26/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import swiftz_core

public let LibXMLDOMErrorDomain = InMyDomain("libxml.dom")
typealias LibXMLDOMNodeSequence = SequenceOf<xmlNodePtr>

internal final class LibXMLDOM {
  struct Context {
    let document: xmlDocPtr
    let rootNode: xmlNodePtr
    
    init (document: xmlDocPtr, rootNode: xmlNodePtr){
      self.document = document
      self.rootNode = rootNode
    }
    
    func dispose() {
      if self.rootNode != nil {
        xmlFreeDoc(self.document)
      }
    }
  }

  internal class func error(message: String) -> NSError {
    return NSError(domain: LibXMLDOMErrorDomain, code: 0, userInfo: [NSLocalizedDescriptionKey: message])
  }
  
  internal class func createWithURL(url: NSURL) -> Result<LibXMLDOM.Context> {
    let document = self.documentPointer(url)
    return { LibXMLDOM.Context(document: document, rootNode: $0) } <^> self.rootNode(document)
  }
  
  internal class func createWithData(data: NSData) -> Result<LibXMLDOM.Context> {
    let document = self.documentPointer(data)
    return { LibXMLDOM.Context(document: document, rootNode: $0) } <^> self.rootNode(document)
  }
  
  internal class func childrenOfNode(node: xmlNodePtr) -> LibXMLDOMNodeSequence {
    var nextNode = LibXMLDOMGetChildren(node)
    let generator: GeneratorOf<xmlNodePtr> = GeneratorOf {
      if (nextNode == nil) {
        return nil
      }
      
      let currentNode = nextNode
      nextNode = LibXMLDOMGetSibling(nextNode)
      
      return currentNode
    }
    
    return SequenceOf(generator)
  }
  
  private class func rootNode(document: xmlDocPtr) -> Result<xmlNodePtr> {
    if document == nil {
      return Result.error(self.error("Could Not Parse Document"))
    }
    
    let rootNode = xmlDocGetRootElement(document)
    if rootNode == nil {
      xmlFreeDoc(document)
      return Result.error(self.error("Could Not Get Root element"))
    }
    
    return Result.value(rootNode)
  }
  
  private class func documentPointer(url: NSURL) -> xmlDocPtr {
    let urlString = url.path
    let cString = urlString?.cStringUsingEncoding(NSUTF8StringEncoding)
    return xmlParseFile(cString!)
  }
  
  private class func documentPointer(data: NSData) -> xmlDocPtr {
    let string = NSString(data: data, encoding: NSUTF8StringEncoding)
    let cString = string.UTF8String
    let length = strlen(cString)
    return xmlParseMemory(cString, Int32(length))
  }  
}

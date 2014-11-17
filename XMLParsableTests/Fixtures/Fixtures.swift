//
//  Fixtures.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 11/09/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation

private func dataFromURL(url: NSURL) -> NSData {
  return NSData(contentsOfURL: url, options: NSDataReadingOptions(), error: nil)!
}

private func resourceWithName(name: String, fileExtension: String) -> NSURL {
  return NSBundle(forClass: Fixtures.self).URLForResource(name, withExtension: fileExtension)!
}

final class Fixtures {
  final class Simple {
    class func url() -> NSURL {
      return resourceWithName("simple", "xml")
    }
    
    class func data() -> NSData {
      return dataFromURL(url())
    }
    
    final class Error {
      class func url() -> NSURL {
        return resourceWithName("simple_error", "xml")
      }
      
      class func data() -> NSData {
        return dataFromURL(url())
      }
    }
  }
  
  final class Zoo {
    class func url() -> NSURL {
      return resourceWithName("zoo", "xml")
    }
    
    class func data() -> NSData {
      return dataFromURL(url())
    }
    
    final class HighRedundancy {
      class func url() -> NSURL {
        return resourceWithName("zoo_highredundancy", "xml")
      }
      
      class func data() -> NSData {
        return dataFromURL(url())
      }
    }
  }
}
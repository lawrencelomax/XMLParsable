//
//  XMLParserSpec.m
//  XMLParsable
//
//  Created by Lawrence Lomax on 14/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import XMLParsable
import Quick
import Nimble

class XMLNodeParserSpec: QuickSpec {
  override func spec() {
    context("LibXML2 - DOM") {
      it("should parse a simple xml") {
        let result = LibXMLNodeParserDOM.createWithURL(Fixtures.Simple.url())
        expect(result).to(beAValue())
      }
      
      it("should return an error with dodgy xml") {
        let result = LibXMLNodeParserDOM.createWithURL(Fixtures.Simple.Error.url())
        expect(result).to(beAnError())
      }
    }
    
    context("LibXML2 - Reader") {
      it("should parse a simple xml") {
        let result = LibXMLNodeParserReader.createWithURL(Fixtures.Simple.url())
        expect(result).to(beAValue())
      }
      
      it("should return an error with dodgy xml") {
        let result = LibXMLNodeParserDOM.createWithURL(Fixtures.Simple.Error.url())
        expect(result).to(beAnError())
      }
    }
  }
}

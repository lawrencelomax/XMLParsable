//
//  LibXMLNavigatingParserSpec.swift
//  XMLParsable
//
//  Created by Lawrence Lomax on 27/08/2014.
//  Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import Quick
import XMLParsable
import Nimble
import swiftz_core

class XMLNavigatingParserSpec: QuickSpec {
  override func spec() {
    context("LibXML2 - DOM") {
      context("valid xml") {
        it("should parse successfully") {
          let result = LibXMLNavigatingParserDOM.createWithURL(Fixtures.Simple.url())
          expect(result).to(beAValue())
        }
        
        it("should provide parsable elements") {
          let result = LibXMLNavigatingParserDOM.createWithURL(Fixtures.Simple.url())
          
          let ding = XMLParser.parseChildRecusiveText(["foo", "bar", "ding"])(xml: root)
          expect(dingText).to(equal("SOME DING"))
        }
      }
      
      context("invalid xml") {
        it("should fail") {
          let result = LibXMLNavigatingParserDOM.createWithURL(Fixtures.Simple.Error.url())
          expect(result).to(beAnError())
        }
      }
    }
  }
}

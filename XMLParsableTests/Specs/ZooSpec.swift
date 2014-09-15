//
//	ZooSpec.swift
//	XMLParsable
//
//	Created by Lawrence Lomax on 05/09/2014.
//	Copyright (c) 2014 Lawrence Lomax. All rights reserved.
//

import Foundation
import XMLParsable
import Quick
import Nimble
import swiftz_core

class ZooSpec: QuickSpec {
	override func spec() {
		describe("navigating dom parser - file"){
			it("should decode with success") {
				let result = LibXMLNavigatingParserDOM.createWithURL(Fixtures.Zoo.url()) >>- Zoo.decode
				expect(result).to(beAValue())
			}
			
			it("should decode properties") {
				let zoo: Zoo! = LibXMLNavigatingParserDOM.createWithURL(Fixtures.Zoo.url()) >>- Zoo.decode |> resultToOptional
				
				expect(zoo.toiletCount).to(equal(42))
				expect(zoo.disabledParking).to(equal(true))
				expect(zoo.drainage).to(equal("Good"))
				expect(zoo.animals.count).to(equal(3))
				expect(zoo.animals[0].name).to(equal("grumpy"))
				expect(zoo.animals[0].kind).to(equal("cat"))
				expect(zoo.animals[0].url).to(equal(NSURL.URLWithString("http://en.wikipedia.org/wiki/Grumpy_Cat")))
				expect(zoo.animals[1].name).to(equal("long"))
				expect(zoo.animals[1].kind).to(equal("cat"))
				expect(zoo.animals[1].url).to(equal(NSURL.URLWithString("http://knowyourmeme.com/memes/longcat")))
				expect(zoo.animals[2].name).to(equal("i have no idea what i'm doing"))
				expect(zoo.animals[2].kind).to(equal("dog"))
				expect(zoo.animals[2].url).to(equal(NSURL.URLWithString("http://knowyourmeme.com/memes/i-have-no-idea-what-im-doing")))
			}
		}
		
		describe("navigating dom parser - data"){
			it("should decode with success") {
				let result = LibXMLNavigatingParserDOM.createWithData(Fixtures.Zoo.data()) >>- Zoo.decode
				expect(result).to(beAValue())
			}
			
			it("should decode properties") {
				let zoo: Zoo! = LibXMLNavigatingParserDOM.createWithData(Fixtures.Zoo.data()) >>- Zoo.decode |> resultToOptional
				
				expect(zoo.toiletCount).to(equal(42))
				expect(zoo.disabledParking).to(equal(true))
				expect(zoo.drainage).to(equal("Good"))
				expect(zoo.animals.count).to(equal(3))
				expect(zoo.animals[0].name).to(equal("grumpy"))
				expect(zoo.animals[0].kind).to(equal("cat"))
				expect(zoo.animals[0].url).to(equal(NSURL.URLWithString("http://en.wikipedia.org/wiki/Grumpy_Cat")))
				expect(zoo.animals[1].name).to(equal("long"))
				expect(zoo.animals[1].kind).to(equal("cat"))
				expect(zoo.animals[1].url).to(equal(NSURL.URLWithString("http://knowyourmeme.com/memes/longcat")))
				expect(zoo.animals[2].name).to(equal("i have no idea what i'm doing"))
				expect(zoo.animals[2].kind).to(equal("dog"))
				expect(zoo.animals[2].url).to(equal(NSURL.URLWithString("http://knowyourmeme.com/memes/i-have-no-idea-what-im-doing")))
			}
		}
		
		describe("node parser dom - file"){
			it("should decode with success") {
				let result = LibXMLNodeParserDOM.createWithURL(Fixtures.Zoo.url()) >>- Zoo.decode
				expect(result).to(beAValue())
			}
			
			it("should decode properties") {
				let zoo: Zoo! = LibXMLNodeParserDOM.createWithURL(Fixtures.Zoo.url()) >>- Zoo.decode |> resultToOptional
				
				expect(zoo.toiletCount).to(equal(42))
				expect(zoo.disabledParking).to(equal(true))
				expect(zoo.drainage).to(equal("Good"))
				expect(zoo.animals.count).to(equal(3))
				expect(zoo.animals[0].name).to(equal("grumpy"))
				expect(zoo.animals[0].kind).to(equal("cat"))
				expect(zoo.animals[0].url).to(equal(NSURL.URLWithString("http://en.wikipedia.org/wiki/Grumpy_Cat")))
				expect(zoo.animals[1].name).to(equal("long"))
				expect(zoo.animals[1].kind).to(equal("cat"))
				expect(zoo.animals[1].url).to(equal(NSURL.URLWithString("http://knowyourmeme.com/memes/longcat")))
				expect(zoo.animals[2].name).to(equal("i have no idea what i'm doing"))
				expect(zoo.animals[2].kind).to(equal("dog"))
				expect(zoo.animals[2].url).to(equal(NSURL.URLWithString("http://knowyourmeme.com/memes/i-have-no-idea-what-im-doing")))
			}
		}
		
		describe("node parser dom - data"){
			it("should decode with success") {
				let result = LibXMLNodeParserDOM.createWithData(Fixtures.Zoo.data()) >>- Zoo.decode
				expect(result).to(beAValue())
			}
			
			it("should decode properties") {
				let zoo: Zoo! = LibXMLNodeParserDOM.createWithData(Fixtures.Zoo.data()) >>- Zoo.decode |> resultToOptional
				
				expect(zoo.toiletCount).to(equal(42))
				expect(zoo.disabledParking).to(equal(true))
				expect(zoo.drainage).to(equal("Good"))
				expect(zoo.animals.count).to(equal(3))
				expect(zoo.animals[0].name).to(equal("grumpy"))
				expect(zoo.animals[0].kind).to(equal("cat"))
				expect(zoo.animals[0].url).to(equal(NSURL.URLWithString("http://en.wikipedia.org/wiki/Grumpy_Cat")))
				expect(zoo.animals[1].name).to(equal("long"))
				expect(zoo.animals[1].kind).to(equal("cat"))
				expect(zoo.animals[1].url).to(equal(NSURL.URLWithString("http://knowyourmeme.com/memes/longcat")))
				expect(zoo.animals[2].name).to(equal("i have no idea what i'm doing"))
				expect(zoo.animals[2].kind).to(equal("dog"))
				expect(zoo.animals[2].url).to(equal(NSURL.URLWithString("http://knowyourmeme.com/memes/i-have-no-idea-what-im-doing")))
			}
		}
		
		describe("node parser reader - file"){
			it("should decode with success") {
				let result = LibXMLNodeParserReader.createWithURL(Fixtures.Zoo.url()) >>- Zoo.decode
				expect(result).to(beAValue())
			}
			
			it("should decode properties") {
				let zoo: Zoo! = LibXMLNodeParserReader.createWithURL(Fixtures.Zoo.url()) >>- Zoo.decode |> resultToOptional
				
				expect(zoo.toiletCount).to(equal(42))
				expect(zoo.disabledParking).to(equal(true))
				expect(zoo.drainage).to(equal("Good"))
				expect(zoo.animals.count).to(equal(3))
				expect(zoo.animals[0].name).to(equal("grumpy"))
				expect(zoo.animals[0].kind).to(equal("cat"))
				expect(zoo.animals[0].url).to(equal(NSURL.URLWithString("http://en.wikipedia.org/wiki/Grumpy_Cat")))
				expect(zoo.animals[1].name).to(equal("long"))
				expect(zoo.animals[1].kind).to(equal("cat"))
				expect(zoo.animals[1].url).to(equal(NSURL.URLWithString("http://knowyourmeme.com/memes/longcat")))
				expect(zoo.animals[2].name).to(equal("i have no idea what i'm doing"))
				expect(zoo.animals[2].kind).to(equal("dog"))
				expect(zoo.animals[2].url).to(equal(NSURL.URLWithString("http://knowyourmeme.com/memes/i-have-no-idea-what-im-doing")))
			}
		}
		
		describe("node parser reader - data"){
			it("should decode with success") {
				let result = LibXMLNodeParserReader.createWithData(Fixtures.Zoo.data()) >>- Zoo.decode
				expect(result).to(beAValue())
			}
			
			it("should decode properties") {
				let zoo: Zoo! = LibXMLNodeParserReader.createWithData(Fixtures.Zoo.data()) >>- Zoo.decode |> resultToOptional
				
				expect(zoo.toiletCount).to(equal(42))
				expect(zoo.disabledParking).to(equal(true))
				expect(zoo.drainage).to(equal("Good"))
				expect(zoo.animals.count).to(equal(3))
				expect(zoo.animals[0].name).to(equal("grumpy"))
				expect(zoo.animals[0].kind).to(equal("cat"))
				expect(zoo.animals[0].url).to(equal(NSURL.URLWithString("http://en.wikipedia.org/wiki/Grumpy_Cat")))
				expect(zoo.animals[1].name).to(equal("long"))
				expect(zoo.animals[1].kind).to(equal("cat"))
				expect(zoo.animals[1].url).to(equal(NSURL.URLWithString("http://knowyourmeme.com/memes/longcat")))
				expect(zoo.animals[2].name).to(equal("i have no idea what i'm doing"))
				expect(zoo.animals[2].kind).to(equal("dog"))
				expect(zoo.animals[2].url).to(equal(NSURL.URLWithString("http://knowyourmeme.com/memes/i-have-no-idea-what-im-doing")))
			}
		}
	}
}

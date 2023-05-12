//
//  XCTestCase+MemoryLeakTracking.swift.swift
//  EssentialAppTests
//
//  Created by Pawel Klapuch on 5/9/23.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}

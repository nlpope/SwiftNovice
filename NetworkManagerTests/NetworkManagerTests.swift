//
//  NetworkManagerTests.swift
//  NetworkManagerTests
//
//  Created by Noah Pope on 7/20/24.
//

import XCTest
@testable import SwiftNovice

final class NetworkManagerTests: XCTestCase {
    // ARRANGE
    var prerequisites = [Prerequisite]()

    func testSuccessfulPrerequisiteFetch() {
        // ACT
        NetworkManager.shared.getPrerequisites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let prerequisites):
                self.prerequisites.append(contentsOf: prerequisites)
                print("prerequisitesArray = \(self.prerequisites)")

            case .failure(let error):
                print(error)
            }
            // ASSERT
            XCTAssertTrue(!self.prerequisites.isEmpty)
        }
        
    }

}

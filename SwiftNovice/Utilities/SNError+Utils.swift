//
//  SNError+Utils.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/18/24.
//

import Foundation

enum SNError: String, Error {
    
    case invalidURL             = "There was an issue retrieving the courses from the server. Please try again."
    case invalidResponse        = "The response received from the server was invalid. Please try again."
    case invalidData            = "The data retrieved was invalid."
    
    case failedToSaveProgress   = "We failed to save your progress. Please try toggling the completion slider again."
    case failedToLoadProgress   = "We failed to retrieve your progress. Please try signing out and signing in again."
}

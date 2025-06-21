//  File: Constants+Utils.swift
//  Project: SwiftNovice
//  Created by: Noah Pope on 7/15/24.

import UIKit

/** for diffable datasource **/
enum Section { case main }

enum SFSymbols
{
    static let account = UIImage(systemName: "person.circle")
    static let courses = UIImage(systemName: "books.vertical")
    static let bookmarks = UIImage(systemName: "bookmark")
}

enum Images
{
    static let snLogo = UIImage(named: "sn-logo")
    static let emptyStateLogo = UIImage(named: "empty-state-logo")
    static let placeholder = UIImage(named: "avatar-placeholder")
}

enum MessageKeys
{
    static let courseTutorial1 = "Here you will find courses that were instrumental in getting me to where I am on my Swift development journey."
    static let courseTutorial2 = "Click on a course to reveal its projects. You may go in any order you'd like."
    
    static let projectstutorial1 = "Welcome to this course's 'projects' page. It is highly recommended you complete them in the order they appear."
    static let projectstutorial2 = "You may tap the 'edit' button above to add or remove projects to your bookmarks or simply toggle a checkmark stating the project is complete or incomplete."
    static let projectstutorial3 = "Once every project is marked 'complete' you will receive a checkmark for the overall course in the previous screen. Enjoy and good luck."
    
    static let bookmarkSuccessfulTitle = "Added to favorites 🥳"
    static let bookmarkSuccessfulMessage = "Successfully added to your bookmarks. It is now searchable via your iPhone's Spotlight feature - enter this project's title and you will be taken directly to the project's web page."
}

enum AccountKeys
{
    static let accountHolders = "accountHolders"
    static let isLoggedIn = "isLoggedIn"
    static let completedCourses = "completedCourses"
    static let completedProjects = "completedProjects"
    
    static let isFirstVisitPostDismissalStatus = "isFirstVisitPostDismissalStatus"
    static var isVeryFirstVisitStatus = "isVeryFirstVisitStatus"
}

enum VideoKeys
{
    static let launchScreen = "launchscreen"
    static let playerLayerName = "PlayerLayerName"
}

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
    static let challenges = UIImage(systemName: "figure.badminton")
}

enum Images
{
    static let snLogo = UIImage(named: "sn-logo")
    static let emptyStateLogo = UIImage(named: "empty-state-logo")
    static let placeholder = UIImage(named: "avatar-placeholder")
}

enum MessageKeys
{
    static let courseTutorial1 = "Here you will find courses that were instrumental in getting me to where I am today on my Swift development journey."
    static let courseTutorial2 = "Click on a course to reveal its projects. You may go in any order you'd like. Every course is searchable via your iPhone's 'Spotlight' feature - enter this project's title and you will be taken directly to a course's 'projects' page."
    
    static let projectstutorial1 = "Welcome to this course's 'projects' page. It is highly recommended you complete them in the order they appear."
    static let projectstutorial2 = "You may tap the 'edit' button above to mark any project as complete or incomplete. Once every project is marked 'complete' you will receive a checkmark for the overall course in the previous screen. Enjoy and good luck."
    
    static let projectCompleteTitle = "Project complete! 🥳"
    static let projectCompleteMessage = "Congratulations on completing this project. Keep going!"
}

enum AccountKeys
{
    static let accountHolders = "accountHolders"
    static let isLoggedIn = "isLoggedIn"
    static let courseProgress = "courseProgress"
    
    static let isFirstVisitPostDismissalStatus = "isFirstVisitPostDismissalStatus"
    static var isVeryFirstVisitStatus = "isVeryFirstVisitStatus"
}

enum VideoKeys
{
    static let launchScreen = "launchscreen"
    static let playerLayerName = "PlayerLayerName"
}

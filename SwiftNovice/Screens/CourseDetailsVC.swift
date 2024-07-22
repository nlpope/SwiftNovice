//
//  CourseDetailsVC.swift
//  SwiftNovice
//
//  Created by Noah Pope on 7/21/24.
//

import UIKit

protocol CourseDetailsVCDelegate {
    func followCourseLink()
    func toggleCourseCompletion(onCourse course: Prerequisite, toggleType: Bool)
}

class CourseDetailsVC: SNDataLoadingVC {

    var courseName: String!
    var delegate: CourseDetailsVCDelegate!
    
    
    init(courseName: String!, delegate: CourseDetailsVCDelegate!) {
        super.init(nibName: nil, bundle: nil)
        self.courseName = courseName
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

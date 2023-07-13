//
//  RealmManager.swift
//  RealmLocalCRUD
//
//  Created by Office on 27/06/23.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    
    private(set) var localRealm: Realm?
    
    @Published var courses: [Course] = []
    
    init() {
        openRealm()
        addCourse()
        getCourses()
    }
    
    func openRealm() {
        do {
            let config = Realm.Configuration(schemaVersion: 1, migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion > 1 {
                    // Do something, usually updating the schema's variables here
                }
            })

            Realm.Configuration.defaultConfiguration = config

            localRealm = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }
    
    
    func addCourse() {
        if let localRealm = localRealm {
            do {
                try localRealm.write {
                    let newCourse = Course()
                    newCourse.id = Int.random(in: 0...100)
                    newCourse.title = "Advanced Development in SwiftUI"
                    newCourse.subtitle = "Advance your SwiftUI skills by developing an app using Core Data, CloudKit, In App Purchases, Sign In With Apple, and Firebase Authentication"
                    newCourse.numberOfSections = 20

                    localRealm.add(newCourse)
                    print("Added new course to Realm!")
                }
            } catch {
                print("Error adding course to Realm", error)
            }
        }
    }
    
    func getCourses() {
        if let localRealm = localRealm {
            let allCourses = localRealm.objects(Course.self)
            allCourses.forEach { course in
                courses.append(course)
            }
        }
    }
    
    func deleteCourse(id: Int) {
        if let localRealm = localRealm {
            let allCourses = localRealm.objects(Course.self)
            let course = allCourses.filter("id == \(id)")
            guard !course.isEmpty else { return }

            do {
                try localRealm.write {
                    localRealm.delete(course)
                    courses = []
                    getCourses()
                    print("Course deleted from Realm")
                }
            } catch {
                print("Error deleting course", error)
            }

        }
    }
    

}

//
//  Course.swift
//  RealmLocalCRUD
//
//  Created by AruniOS on 27/06/23.
//

import Foundation
import RealmSwift

class Course: Object {
    @objc dynamic var id = 1
    @objc dynamic var title = ""
    @objc dynamic var subtitle: String?
    @objc dynamic var numberOfSections = 10
}

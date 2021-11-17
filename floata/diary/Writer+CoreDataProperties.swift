//
//  Writer+CoreDataProperties.swift
//  floata
//
//  Created by 홍태희 on 2021/11/16.
//
//

import Foundation
import CoreData


extension Writer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Writer> {
        return NSFetchRequest<Writer>(entityName: "Writer")
    }

    @NSManaged public var pages: String?
    @NSManaged public var time: Date?

}

extension Writer : Identifiable {

}

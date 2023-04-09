//
//  CompanyData+CoreDataProperties.swift
//  UsingStoryBoard
//
//  Created by Sowri on 4/8/23.
//
//

import Foundation
import CoreData


extension CompanyData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CompanyData> {
        return NSFetchRequest<CompanyData>(entityName: "CompanyData")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var zip: Int64
    @NSManaged public var country: String?
    @NSManaged public var company_type: String?
    @NSManaged public var address: String?
    @NSManaged public var logo: Data?

}

extension CompanyData : Identifiable {

}

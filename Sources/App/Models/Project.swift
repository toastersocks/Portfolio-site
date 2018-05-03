//
//  Project.swift
//  App
//
//  Created by James Pamplona on 5/2/18.
//

import Foundation
import Vapor
import FluentSQLite

struct Project: Content {
    var id: Int?
    let name: String
    let description: String
    let image: Data?
    let url: URL?
}

extension Project: SQLiteModel {}
extension Project: Migration {}

struct ProjectsSection: Content {
    let title: String
    let projects: [Project]
}

struct AboutSection: Content {
    let title: String
    let content: String
}

struct ContactSection: Content {
    let title: String
    let content: String
}

struct SkillsSection: Content {
    
    let title: String
    let skills: [String]
}

struct MainSite: Content {
    let about: AboutSection
    let projects: ProjectsSection
    let skills: SkillsSection
}

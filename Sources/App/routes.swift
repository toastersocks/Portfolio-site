import Routing
import Vapor
import Foundation
import Leaf

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    router.post(InfoData.self, at: "info") { req, data -> InfoResponse in
        return InfoResponse(name: data.name)
    }
    
    router.get("date") { req in
        return "\(Date())"
    }
    router.get("counter", Int.parameter) { (req) -> CountJSON in
        let count = try req.parameters.next(Int.self)
        return CountJSON(count: count)
    }
    
    router.post(UserInfoData.self, at: "user-info") { req, user -> String in
        return "Hello \(user.name), you are \(user.age) years old!"
    }

    router.get() { (req) -> Future<View> in
        let leaf = try req.make(LeafRenderer.self)
        return try leaf.render("index", MainSite(about: AboutSection(title: "About", content: <#T##String#>), projects: <#T##ProjectsSection#>, skills: <#T##SkillsSection#>))
    }
    
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

struct InfoData: Content {
    let name: String
}

struct InfoResponse: Content {
    let name: String
}

struct CountJSON: Content {
    let count: Int
}

struct UserInfoData: Content {
    let name: String
    let age: Int
}

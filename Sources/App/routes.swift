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
        return leaf.render("index", MainSite(about: AboutSection(title: "About", content: """
            I am passionate about serving and enabling people. Everyone has a story to tell and a unique perspective that can be learned from.
            I also enjoy software development and design for mobile platforms in my spare time. I'm interested in issues of accessibility/color blindness and dyslexia and how they affect and inform human-computer interaction. I'm also interested in culture and language/translation issues as pertaining to products and software.
            I enjoy thinking about ways in which computers can enhance our lives, rather than distract us.
            
""")
            , projects: ProjectsSection(title: "Projects", projects: [
                Project(id: nil, name: "Be - Digital Fasting Mindfulness", description: """
Be is a mindfulness app that helps you to disconnect from the distraction of screens and to just be with yourself by practicing what's known as "digital fasting."

- Track your progress from within the app

- Achieve your mindfulness goals by scheduling one-time or repeating reminders to help you stay on track

- Integrate with HealthKit so you can see your mindfulness minutes alongside your other health data
""", image: nil, url: nil),
                Project(id: nil, name: "Ratios - iOS", description: "An app for iPhone that helps users calculate THC/CBD ratios for pain/anxiety relief.", image: nil, url: nil),
                Project(id: nil, name: "Ratios - Android", description: "An app for Android that helps users calculate THC/CBD ratios for pain/anxiety relief.", image: nil, url: nil)]),
              skills: SkillsSection(title: "Skills", skills: ["Collaborating with others on projects in person and online.",
                                                              "Solo and collaborative work on software via Git version control system",
                                                              "Application and framework development.",
                                                              "Problem solving",
                                                              "Weighing various cost/benefit trade-offs of different solutions/approaches to problems.",
                                                              "In-depth knowledge of CocoaTouch frameworks.",
               " Dependency management solutions including Cocoapods, Carthage, Swift Package Manager and manual dependency management",
                "Testing and test-driven development using XCTest, Quick/Nimble, and SwiftCheck property-based testing.",
                "Accessibility and Localization best practices.",
                "Profiling program performance memory usage/leaks.",
])))
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

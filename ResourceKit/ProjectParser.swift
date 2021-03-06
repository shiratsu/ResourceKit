//
//  ProjectParser.swift
//  ResourceKit
//
//  Created by kingkong999yhirose on 2016/05/03.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation


struct ProjectResourceParser {
    private var projectFile: XCProjectFile
    var paths: [NSURL] = []
    var localizablePaths: [NSURL] = []
    
    init() {
        self.init(xcodeURL: Environment.PROJECT_FILE_PATH.path, target: Environment.TARGET_NAME.element)
    }
    
    init(xcodeURL: NSURL, target: String) {
        guard let projectFile = try? XCProjectFile(xcodeprojURL: xcodeURL) else {
            fatalError("xcodeURL: \(xcodeURL) ")
        }
        let allTarget = projectFile.project.targets
        guard let target = allTarget.filter({ $0.name == target }).first else {
            fatalError("allTargetName: \(allTarget.flatMap { $0.name }.joinWithSeparator(", "))")
        }
        
        self.projectFile = projectFile
        self.paths = generateFileRefPaths(target).flatMap(Environment.pathFrom)
        self.localizablePaths = generateLocalizablePaths(target).flatMap(Environment.pathFrom)
        
        setupSuffixViewControllers()
    }
    
    private func generateLocalizablePaths(target: PBXNativeTarget) -> [Path] {
        let resourcesFileRefs = target.buildPhases
            .flatMap { $0 as? PBXResourcesBuildPhase }
            .flatMap { $0.files }
            .map { $0.fileRef }
        
        let localizablePaths = resourcesFileRefs
            .flatMap { $0 as? PBXVariantGroup }
            .flatMap { $0.fileRefs }
            .map { $0.fullPath }
        
        return localizablePaths
    }
    
    private func generateFileRefPaths(target: PBXNativeTarget) -> [Path] {
        return target.buildPhases
            .flatMap { $0.files }
            .flatMap { $0.fileRef }
            .flatMap { $0 as? PBXFileReference }
            .flatMap { $0.fullPath }
    }
    
    private mutating func setupSuffixViewControllers() {
        func append(viewControllers: [ViewController]) {
            ProjectResource
                .sharedInstance
                .viewControllers
                .appendContentsOf(
                    viewControllers
            )
        }
        if config.viewController.instantiateStoryboardForSwift {
            append(
                viewControllerInfoWith(
                    filterPaths(withExtension: "swift", suffixs: "ViewController"),
                    suffix: "ViewController",
                    pattern: ".*class\\s+.*ViewController\\s*:\\s*.*ViewController"
                )
            )
        }
        if config.viewController.instantiateStoryboardForObjC {
            append(
                viewControllerInfoWith(
                    filterPaths(withExtension: "h", suffixs: "ViewController"),
                    suffix: "ViewController",
                    pattern: "\\s*@interface\\s+.*ViewController\\s*:\\s*.*ViewController"
                )
            )
            
        }
        if config.viewController.instantiateStoryboardAny {
            append(
                ViewControllerResource.standards().flatMap { ViewController(className: $0.rawValue) }
            )
        }
        
    }
    
    private func viewControllerInfoWith(path: NSURL, suffix: String, pattern: String) -> ViewController? {
        let content = try! String(contentsOfURL: path)
        let regex = try! NSRegularExpression(pattern: pattern, options: .UseUnixLineSeparators)
        let results = regex.matchesInString(content, options: [], range: NSMakeRange(0, content.characters.count))
        
        return results.flatMap { (result) -> ViewController? in
            if result.range.location != NSNotFound {
                let matchingString = (content as NSString).substringWithRange(result.range) as String
                let classes = matchingString
                    .stringByReplacingOccurrencesOfString("\\s*@interface", withString: "", options: .RegularExpressionSearch, range: nil)
                    .stringByReplacingOccurrencesOfString(".*class", withString: "", options: .RegularExpressionSearch, range: nil)
                    .stringByReplacingOccurrencesOfString("{", withString: "")
                    .stringByReplacingOccurrencesOfString("}", withString: "")
                    .stringByReplacingOccurrencesOfString(" ", withString: "")
                    .stringByReplacingOccurrencesOfString(":", withString: " ")
                    .componentsSeparatedByString(" ")
                    .filter { $0.hasSuffix(suffix) }
                
                
                return ViewController (className: classes[0], superClassName: classes[1])
            }
            return nil }.first
    }
    
    private func viewControllerInfoWith(paths: [NSURL], suffix: String, pattern: String) -> [ViewController] {
        return paths.flatMap {
            viewControllerInfoWith($0, suffix: suffix, pattern: pattern)
        }
    }
    
    private func filterPaths(withExtension ex: String, suffixs: String...) -> [NSURL] {
        return paths.filter { url in
            guard let pathExtension = url.pathExtension
                where pathExtension == ex
                else {
                    return false
            }
            guard let fileName = url.URLByDeletingPathExtension?.lastPathComponent
                where suffixs.contains({fileName.hasSuffix($0)})  else {
                    return false
            }
            return true
        }
    }
}

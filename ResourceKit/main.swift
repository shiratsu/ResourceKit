//
//  main.swift
//  ResourceKit
//
//  Created by Hirose.Yudai on 2016/01/27.
//  Copyright © 2016年 Hirose.Yudai. All rights reserved.
//

import Foundation
private let RESOURCE_FILENAME = "Resource.generated.swift"
private let outputPath = NSProcessInfo.processInfo().environment["SRCROOT"]!
private let outputUrl = NSURL(fileURLWithPath: outputPath)

private var resourceValue: AnyObject?
try! outputUrl.getResourceValue(&resourceValue, forKey: NSURLIsDirectoryKey)

private let writeUrl: NSURL
writeUrl = outputUrl.URLByAppendingPathComponent(RESOURCE_FILENAME, isDirectory: false)

func imports() -> [String] {
    guard let content = try? String(contentsOfURL: writeUrl) else {
        return ["import UIKit"]
    }
    let pattern = "\\s*import\\s+.+"
    let regex = try! NSRegularExpression(pattern: pattern, options: .UseUnixLineSeparators)
    let results = regex.matchesInString(content, options: [], range: NSMakeRange(0, content.characters.count))
    
    if results.isEmpty {
        return ["import UIKit"]
    }
    
    return results.flatMap { (result) -> String? in
        if result.range.location != NSNotFound {
            let matchingString = (content as NSString).substringWithRange(result.range) as String
            return matchingString
        }
        return nil
    }
}

let parser = ProjectResourceParser()

parser.paths
    .filter { $0.pathExtension != nil }
    .filter { $0.pathExtension! == "storyboard" }
    .forEach { let _ = StoryboardParser(url: $0) }

parser.paths
    .filter { $0.pathExtension != nil }
    .filter { $0.pathExtension! == "xib" }
    .forEach { let _ = XibPerser(url: $0) }

let importsContent = imports().joinWithSeparator(newLine)

let xibProtocolContent = Protocol(
    name: "XibProtocol",
    getters: [
        Var(name: "name", type: "String")
    ],
    functions: [
        FunctionForProtocol(
            head: "",
            name: "nib",
            arguments: [],
            returnType: "UINib"
        )
    ]
).declaration + newLine

let tableViewExtensionContent = Extension(
    type: "UITableView",
    functions: [
        Function(
            name: "registerNib",
            arguments: [
                Argument(name: "nib", type: "XibProtocol")
            ],
            returnType: "Void",
            body: Body("registerNib(nib.nib(), forCellReuseIdentifier: nib.name)")
        )
     ,
        Function(
            name: "registerNibs",
            arguments: [
                Argument(name: "nibs", type: "[XibProtocol]")
            ],
            returnType: "Void",
            body: Body("nibs.forEach(registerNib)")
        )
    ]
).declaration + newLine

let collectionViewExtensionContent = Extension(
    type: "UICollectionView",
    functions: [
        Function(
            name: "registerNib",
            arguments: [
                Argument(name: "nib", type: "XibProtocol")
            ],
            returnType: "Void",
            body: Body("registerNib(nib.nib(), forCellWithReuseIdentifier: nib.name)")
        )
      ,
        Function(
            name: "registerNibs",
            arguments: [
                Argument(name: "nibs", type: "[XibProtocol]")
            ],
            returnType: "Void",
            body: Body("nibs.forEach(registerNib)")
        )
    ]
).declaration + newLine



let viewControllerContent = ProjectResource.sharedInstance.viewControllers
    .flatMap { $0.generateExtensionIfNeeded() }
    .flatMap { $0.declaration }
    .joinWithSeparator(newLine)

let tableViewCellContent = ProjectResource.sharedInstance.tableViewCells
    .flatMap { $0.generateExtension() }
    .flatMap { $0.declaration }
    .joinWithSeparator(newLine)

let collectionViewCellContent = ProjectResource.sharedInstance.collectionViewCells
    .flatMap { $0.generateExtension() }
    .flatMap { $0.declaration }
    .joinWithSeparator(newLine)

let xibContent = ProjectResource.sharedInstance.xibs
    .flatMap { $0.generateExtension() }
    .flatMap { $0.declaration }
    .joinWithSeparator(newLine)

let content = (
    Header + newLine + newLine
        + importsContent + newLine
        + xibProtocolContent
        + tableViewExtensionContent
        + collectionViewExtensionContent
        + viewControllerContent
        + tableViewCellContent
        + collectionViewCellContent
        + xibContent
)

func write(code: String, fileURL: NSURL) {
    do {
        try code.writeToURL(fileURL, atomically: true, encoding: NSUTF8StringEncoding)
    } catch let error as NSError {
        fatalError(error.localizedDescription)
    }
}

write(content, fileURL: writeUrl)

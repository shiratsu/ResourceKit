//
//  ConfigParser.swift
//  ResourceKit
//
//  Created by kingkong999yhirose on 2016/05/05.
//  Copyright © 2016年 kingkong999yhirose. All rights reserved.
//

import Foundation

struct Config {
    var segue: ConfigParser.Segue = ConfigParser.Segue()
    var image: ConfigParser.Image = ConfigParser.Image()
    var string: ConfigParser.String = ConfigParser.String()
    var viewController: ConfigParser.ViewController = ConfigParser.ViewController()
    var nib: ConfigParser.Nib = ConfigParser.Nib()
    var reusable: ConfigParser.Reusable = ConfigParser.Reusable()
    
    var needGenerateSegue: Bool {
        return segue.addition || segue.standard
    }
    
    init() {
        if let dictionary = NSDictionary(contentsOfFile: Environment.SRCROOT.element + "/ResourceKitConfig.plist") as? [String: AnyObject] {
            dictionary.forEach { (key: String , value: AnyObject) in
                switch ConfigParser.Item(rawValue: key)! {
                case .Segue:
                    segue = ConfigParser.Segue(value as? [String: Bool] ?? [:])
                case .Image:
                    image = ConfigParser.Image(value as? [String: Bool] ?? [:])
                case .String:
                    string = ConfigParser.String(value as? [String: Bool] ?? [:])
                case .ViewController:
                    viewController = ConfigParser.ViewController(value as? [String: Bool] ?? [:])
                case .Nib:
                    nib = ConfigParser.Nib(value as? [String: Bool] ?? [:])
                case .Reusable:
                    reusable = ConfigParser.Reusable(value as? [String: Bool] ?? [:])
                }
            }
        }
    }
}

struct ConfigParser {
    enum Item: Swift.String {
        case Segue
        case Image
        case String
        case ViewController
        case Nib
        case Reusable
    }
    
    struct Segue {
        let standard: Bool
        let addition: Bool
        
        init() {
            standard = true
            addition = false
        }
        init(_ dictionary: [Swift.String: Bool]) {
            standard = dictionary["Standard"] ?? false
            addition = dictionary["Addition"] ?? false
        }
    }
    
    struct Image {
        let assetCatalog: Bool
        let projectResource: Bool
        
        init() {
            assetCatalog = true
            projectResource = true
        }
        init(_ dictionary: [Swift.String: Bool]) {
            assetCatalog = dictionary["AssetCatalog"] ?? false
            projectResource = dictionary["ProjectResource"] ?? false
        }
    }
    
    struct String {
        let localized: Bool
        
        init() {
            localized = true
        }
        init(_ dictionary: [Swift.String: Bool]) {
            localized = dictionary["Localized"] ?? false
        }
    }
    
    struct ViewController {
        let instantiateStoryboardForSwift: Bool
        let instantiateStoryboardForObjC: Bool
        
        var instantiateStoryboardAny: Bool {
            return instantiateStoryboardForSwift || instantiateStoryboardForObjC
        }
        
        init() {
            instantiateStoryboardForSwift = true
            instantiateStoryboardForObjC = true
        }
        init(_ dictionary: [Swift.String: Bool]) {
            instantiateStoryboardForSwift = dictionary["InstantiateStoryboardForSwift"] ?? false
            instantiateStoryboardForObjC = dictionary["InstantiateStoryboardForObjC"] ?? false
        }
    }
    
    struct Nib {
        let xib: Bool
        
        init() {
            xib = true
        }
        init(_ dictionary: [Swift.String: Bool]) {
            xib = dictionary["Xib"] ?? false
        }
    }
    
    struct Reusable {
        let identifier: Bool
        
        init() {
            identifier = true
        }
        init(_ dictionary: [Swift.String: Bool]) {
            identifier = dictionary["Identifier"] ?? false
        }
    }
}


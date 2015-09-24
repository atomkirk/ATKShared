//
//  Files.swift
//  Spoken
//
//  Created by Adam Kirk on 5/18/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import Foundation

public class FilePath: NSObject {

    public let string: String

    public var fileURL: NSURL {
        return NSURL(fileURLWithPath: self.string)
    }

    public init(string: String) {
        self.string = string
    }


    // MARK: - Directories

    public class func documentRoot() -> FilePath {
        let urls = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask) 
        let path = urls.last!.relativePath!
        return FilePath(string: path)
    }



    // MARK: - Utils

    public func exists() -> Bool {
        return NSFileManager.defaultManager().fileExistsAtPath(self.string)
    }

    public func contents() -> NSData? {
        return NSFileManager.defaultManager().contentsAtPath(self.string)
    }

    public func directoryContents(ext: String?) -> [FilePath] {
        let items = (try! NSFileManager.defaultManager().contentsOfDirectoryAtPath(self.string)) 
        var paths = [FilePath]()
        for filename in items {
            if ext == nil || (filename as NSString).pathExtension == ext {
                let filePath = FilePath(string: (self.string as NSString).stringByAppendingPathComponent(filename))
                paths.append(filePath)
            }
        }
        return paths
    }

    public func basename() -> String {
        return ((self.string as NSString).lastPathComponent as NSString).stringByDeletingPathExtension
    }

    public func pathByAppendingComponent(component: String) -> FilePath {
        return FilePath(string: (self.string as NSString).stringByAppendingPathComponent(component))
    }

    public func write(content: NSData) -> Bool {
        return content.writeToFile(self.string, atomically: true)
    }

    public func remove() -> Bool {
        if self.exists() {
            let success: Bool
            do {
                try NSFileManager.defaultManager().removeItemAtPath(self.string)
                success = true
            } catch let error as NSError {
                PassInError().ref = error
                success = false
            }
            return success
        }
        return true
    }

}
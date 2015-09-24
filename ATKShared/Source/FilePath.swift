//
//  Files.swift
//  Spoken
//
//  Created by Adam Kirk on 5/18/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import Foundation


enum FilePathDirectory: String {
    case Downloaded = "Downloaded"
    case Busy       = "Busy"
    case Uploading  = "Uploading"
}


class FilePath: NSObject {

    let string: String

    var fileURL: NSURL {
        return NSURL(fileURLWithPath: self.string)
    }

    init(string: String) {
        self.string = string
    }


    // MARK: - Directories

    class func documentRoot() -> FilePath {
        let urls = NSFileManager.defaultManager().URLsForDirectory(NSSearchPathDirectory.DocumentDirectory, inDomains: NSSearchPathDomainMask.UserDomainMask) 
        let path = urls.last!.relativePath!
        return FilePath(string: path)
    }

    class func pathOfDirectory(directory: FilePathDirectory) -> FilePath {
        let path = FilePath(string: (self.documentRoot().string as NSString).stringByAppendingPathComponent(directory.rawValue))
        if !path.exists() {
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(path.string, withIntermediateDirectories: true, attributes: nil)
            } catch let error as NSError {
                PassInError().ref = error
            }
        }
        return path
    }


    // MARK: - Utils

    func exists() -> Bool {
        return NSFileManager.defaultManager().fileExistsAtPath(self.string)
    }

    func contents() -> NSData? {
        return NSFileManager.defaultManager().contentsAtPath(self.string)
    }

    func directoryContents(ext: String?) -> [FilePath] {
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

    func basename() -> String {
        return ((self.string as NSString).lastPathComponent as NSString).stringByDeletingPathExtension
    }

    func pathByAppendingComponent(component: String) -> FilePath {
        return FilePath(string: (self.string as NSString).stringByAppendingPathComponent(component))
    }

    func write(content: NSData) -> Bool {
        return content.writeToFile(self.string, atomically: true)
    }

    func remove() -> Bool {
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
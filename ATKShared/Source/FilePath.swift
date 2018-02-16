//
//  Files.swift
//  Spoken
//
//  Created by Adam Kirk on 5/18/15.
//  Copyright (c) 2015 Spoken. All rights reserved.
//

import Foundation

open class FilePath: NSObject {

    open let string: String

    open var fileURL: URL {
        return URL(fileURLWithPath: self.string)
    }

    public init(string: String) {
        self.string = string
    }


    // MARK: - Directories

    open class func documentRoot() -> FilePath {
        let urls = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask) 
        let path = urls.last!.relativePath
        return FilePath(string: path)
    }



    // MARK: - Utils

    open func exists() -> Bool {
        return FileManager.default.fileExists(atPath: self.string)
    }

    open func contents() -> Data? {
        return FileManager.default.contents(atPath: self.string)
    }

    open func directoryContents(_ ext: String?) -> [FilePath] {
        let items = (try! FileManager.default.contentsOfDirectory(atPath: self.string)) 
        var paths = [FilePath]()
        for filename in items {
            if ext == nil || (filename as NSString).pathExtension == ext {
                let filePath = FilePath(string: (self.string as NSString).appendingPathComponent(filename))
                paths.append(filePath)
            }
        }
        return paths
    }

    open func basename() -> String {
        return ((self.string as NSString).lastPathComponent as NSString).deletingPathExtension
    }

    open func pathByAppendingComponent(_ component: String) -> FilePath {
        return FilePath(string: (self.string as NSString).appendingPathComponent(component))
    }

    open func write(_ content: Data) -> Bool {
        return ((try? content.write(to: URL(fileURLWithPath: self.string), options: [.atomic])) != nil)
    }

    open func remove() -> Bool {
        if self.exists() {
            let success: Bool
            do {
                try FileManager.default.removeItem(atPath: self.string)
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

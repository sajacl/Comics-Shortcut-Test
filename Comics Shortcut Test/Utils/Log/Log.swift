//
//  Log.swift
//  Comics Shortcut Test
//
//  Created by Sajad Vishkai on 4/7/22.
//

import Foundation

#if os(OSX)
    import Cocoa
#elseif os(iOS) || os(tvOS)
    import UIKit
#endif

private enum LogPriority: Int {
    case debug
    case information
    case warning
    case error
}

///  Debug error level
private let LogDebug : String = "Debug";

///  Info error level
private let LogInfo : String = "Info";

///  Warning error level
private let LogWarning : String = "Warning";

///  Error error level
private let LogError : String = "Error";

public struct Log {

    /// While enabled QorumOnlineLogs does not work
    public static var enabled = false

    /// 1 to 4
    public static var minimumLogLevelShown = 1

    /// Change the array element with another UIColor. 0 is info gray, 5 is purple, rest are log levels
    public static var colorsForLogLevels: [QLColor] = [
        QLColor(r: 120, g: 120, b: 120),//0
        QLColor(r: 0, g: 180, b: 180),  //1
        QLColor(r: 0, g: 150, b: 0),    //2
        QLColor(r: 255, g: 190, b: 0),  //3
        QLColor(r: 255, g: 0, b: 0),    //4
        QLColor(r: 160, g: 32, b: 240)] //5
    /// Change the array element with another ansi color. 0 is info gray, 5 is purple, rest are log levels
    public static var ansiColorsForLogLevels: [String] = [
        "37m", // 0 (gray)
        "34m", // 1 (blue)
        "32m", // 2 (green)
        "33m", // 3 (yellow)
        "31m", // 4 (red)
        "35m"] // 5 (magenta)
    /// Change the array element with another Emoji or String. 0 replaces gray color, 5 replaces purple, rest replace log levels
    public static var emojisForLogLevels: [String] = [
        "", //0
        "/D/", //1
        "/I/", //2
        "/W/", //3
        "/E/", //4
        "💜"] //5
    
    /// Uses emojis instead of colors when this is false
    public static var useColors = false

    /// Uses ANSI colors instead of colors or emojis when this is true
    public static var useAnsiColors = false
    
    //TODO: Show example in documentation
    /// Set your function that will get called whenever something new is logged
    public static var trackLogFunction: ((String)->())? = nil

    private static var showFiles = [String]()

    //==========================================================================================================
    // MARK: - Public Methods
    //==========================================================================================================
    /// Ignores all logs from other files
    public static func onlyShowTheseFiles(_ fileNames: Any...) {
        minimumLogLevelShown = 1

        let showFiles = fileNames.map { fileName in
            return fileName as? String ?? {
                let classString: String = {
                    let classString = String(describing: type(of: fileName))
                    return classString.ns.pathExtension
                }()

                return classString
            }()
        }

        self.showFiles = showFiles
        debugPrint(ColorLog.colorizeString("Logs: Only Showing: \(showFiles)", colorId: 5))
    }
    
    public static func lg(_ strings: Any...) {
        strings.forEach({ debugPrint($0) })
    }

    /// Ignores all logs from other files
    public static func onlyShowThisFile(_ fileName: Any) {
        onlyShowTheseFiles(fileName)
    }

    /// Test to see if its working
    public static func test() {
        let oldDebugLevel = minimumLogLevelShown
        minimumLogLevelShown = 1
        LDebug(LogDebug)
        LInfo(LogInfo)
        LWarning(LogWarning)
        LError(LogError)
        minimumLogLevelShown = oldDebugLevel
    }

    //==========================================================================================================
    // MARK: - Private Methods
    //==========================================================================================================
    fileprivate static func shouldPrintLine(level: Int, fileName: String) -> Bool {
        if !Log.enabled {
            return false
        } else if Log.minimumLogLevelShown <= level {
            return Log.shouldShowFile(fileName)
        } else {
            return false
        }
    }

    fileprivate static func shouldShowFile(_ fileName: String) -> Bool {
        return Log.showFiles.isEmpty || Log.showFiles.contains(fileName)
    }
}

public struct OnlineLog {
    private static let appVersion = versionAndBuild()
    private static var googleFormLink: String!
    private static var googleFormAppVersionField: String!
    private static var googleFormUserInfoField: String!
    private static var googleFormMethodInfoField: String!
    private static var googleFormErrorTextField: String!
    /// Online logs does not work while Logs is enabled
    public static var enabled = false

    /// 1 to 4
    public static var minimumLogLevelShown = 1

    /// Empty dictionary, add extra info like user id, username here
    public static var extraInformation = [String: String]()

    //==========================================================================================================
    // MARK: - Public Methods
    //==========================================================================================================
    /// Test to see if its working
    public static func test() {
        let oldDebugLevel = minimumLogLevelShown
        minimumLogLevelShown = 1
        LDebug(LogDebug)
        LInfo(LogInfo)
        LWarning(LogWarning)
        LError(LogError)
        minimumLogLevelShown = oldDebugLevel
    }

    /// Setup Google Form links
    public static func setupOnlineLogs(formLink: String, versionField: String, userInfoField: String, methodInfoField: String, textField: String) {
        googleFormLink = formLink
        googleFormAppVersionField = versionField
        googleFormUserInfoField = userInfoField
        googleFormMethodInfoField = methodInfoField
        googleFormErrorTextField = textField
    }

    //==========================================================================================================
    // MARK: - Private Methods
    //==========================================================================================================
    fileprivate static func sendError<T>(classInformation: String, textObject: T, level: String) {
        var text = ""
        if let stringObject = textObject as? String {
            text = stringObject
        } else {
            let stringObject = String(describing: textObject)
            text = stringObject
        }
        let versionLevel = (appVersion + " - " + level)

        let url = URL(string: googleFormLink)
        var postData = googleFormAppVersionField + "=" + versionLevel
        postData += "&" + googleFormUserInfoField + "=" + extraInformation.map{ "\($0.key):\($0.value)" }.joined(separator: "+")
        postData += "&" + googleFormMethodInfoField + "=" + classInformation
        postData += "&" + googleFormErrorTextField + "=" + text

        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = postData.data(using: String.Encoding.utf8)

        #if os(OSX)
            if kCFCoreFoundationVersionNumber > kCFCoreFoundationVersionNumber10_10 {
                Foundation.URLSession.shared.dataTask(with: request).resume()
            } else {
                NSURLConnection(request: request, delegate: nil)?.start()
            }
        #elseif os(iOS)
            URLSession.shared.dataTask(with: request).resume()
        #endif

        let printText = "OnlineLogs: \(extraInformation.description) - \(versionLevel) - \(classInformation) - \(text)"
        debugPrint(" \(ColorLog.colorizeString(printText, colorId: 5))\n", terminator: "")
    }

    fileprivate static func shouldSendLine(level: Int, fileName: String) -> Bool {
        if !OnlineLog.enabled {
            return false
        } else if OnlineLog.minimumLogLevelShown <= level {
            return Log.shouldShowFile(fileName)
        } else {
            return false
        }
    }
}

///Detailed logs only used while debugging
public func LDebug<T>(_ debug: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    LManager(debug, file: file, function: function, line: line, level:1)
}

///General information about app state
public func LInfo<T>(_ info: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    LManager(info,file: file,function: function,line: line,level:2)
}

///Indicates possible error
public func LWarning<T>(_ warning: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    LManager(warning,file: file,function: function,line: line,level:3)
}

///An unexpected error occured
public func LError<T>(_ error: T, _ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    LManager(error,file: file,function: function,line: line,level:4)
}

private func printLog<T>(_ informationPart: String, text: T, level: Int) {
    let priority = LogPriority(rawValue: level)
    
    switch priority {
    case .debug: debugPrint(" \(ColorLog.colorizeString(informationPart, colorId: 0))", terminator: "")
    case .information: break
    case .warning: debugPrint(" \(ColorLog.colorizeString(informationPart, colorId: level))", terminator: "")
    case .error: debugPrint(" \(ColorLog.colorizeString(informationPart, colorId: level))", terminator: "")
    case .none: break
    }
    
    debugPrint(" \(ColorLog.colorizeString(text, colorId: level))\n", terminator: "")
}

///=====
public func LShortLine(_ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    let lineString = "======================================"
    LineManager(lineString, file: file, function: function, line: line)
}

///+++++
public func LPlusLine(_ file: String = #file, _ function: String = #function, _ line: Int = #line) {
    let lineString = "+++++++++++++++++++++++++++++++++++++"
    LineManager(lineString, file: file, function: function, line: line)
}

///Print data with level
private func LManager<T>(_ debug: T, file: String, function: String, line: Int, level : Int) {

    let levelText : String;

    switch (level) {
    case 1: levelText = LogDebug
    case 2: levelText = LogInfo
    case 3: levelText = LogWarning
    case 4: levelText = LogError
    default: levelText = LogDebug
    }

    let fileExtension = file.ns.lastPathComponent.ns.pathExtension
    let filename = file.ns.lastPathComponent.ns.deletingPathExtension
    
    var text = ""
    if let stringObject = debug as? String {
        text = stringObject
    } else {
        let stringObject = String(describing: debug)
        text = stringObject
    }
    Log.trackLogFunction?(text)

    if Log.shouldPrintLine(level: level, fileName: filename) {
        let informationPart: String
        informationPart = "\(filename).\(fileExtension):\(line) \(function):"
        printLog(informationPart, text: debug, level: level)
    } else if OnlineLog.shouldSendLine(level: level, fileName: filename) {
        let informationPart = "\(filename).\(function)[\(line)]"
        OnlineLog.sendError(classInformation: informationPart, textObject: debug, level: levelText)
    }
//    saveLogToFile(text)
}

func saveLogToFile(_ log: String) {
    var Logtxt = readFromtxtFile(path: getDocumentsDirectory().appendingPathComponent("Log.txt"))
    let str = log
    Logtxt.append(contentsOf: "~<\(Date())>:\n\(str)\n")
    let filename = getDocumentsDirectory().appendingPathComponent("Log.txt")
    
    do {
        try Logtxt.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
    } catch {
        debugPrint(error)
    }
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

func readFromtxtFile(path: URL) -> String {
    
    do {
        let logs = try String(contentsOf: path, encoding: .utf8)
        return logs
    }
    catch {
        debugPrint(error)
    }
    return String()
}

///Print line
private func LineManager(_ lineString : String, file: String, function: String, line: Int) {
    let fileExtension = file.ns.lastPathComponent.ns.pathExtension
    let filename = file.ns.lastPathComponent.ns.deletingPathExtension
    if Log.shouldPrintLine(level: 2, fileName: filename) {
        let informationPart: String
        informationPart = "\(filename).\(fileExtension):\(line) \(function):"
        printLog(informationPart, text: lineString, level: 5)
    }
}

private struct ColorLog {
    private static let ESCAPE = "\u{001b}["
    private static let RESET_FG = ESCAPE + "fg;" // Clear any foreground color
    private static let RESET_BG = ESCAPE + "bg;" // Clear any background color
    private static let RESET = ESCAPE + ";"      // Clear any foreground or background color
    static func colorizeString<T>(_ object: T, colorId: Int) -> String {
        if Log.useAnsiColors {
            return "\(ESCAPE)1m\(ESCAPE)\(Log.ansiColorsForLogLevels[colorId])\(object)"
        } else if Log.useColors {
            return "\(ESCAPE)fg\(Log.colorsForLogLevels[colorId].redColor),\(Log.colorsForLogLevels[colorId].greenColor),\(Log.colorsForLogLevels[colorId].blueColor);\(object)\(RESET)"
        } else {
            return "\(Log.emojisForLogLevels[colorId])\(object)\(Log.emojisForLogLevels[colorId])"
        }
    }
}

private func versionAndBuild() -> String {

    let version = Bundle.main.infoDictionary? ["CFBundleShortVersionString"] as! String
    let build = Bundle.main.infoDictionary? [kCFBundleVersionKey as String] as! String

    return version == build ? "v\(version)" : "v\(version)(\(build))"
}

private extension String {
    /// Qorum Extension
    var ns: NSString { return self as NSString }
}

///Used in color settings for Logs
open class QLColor {
    #if os(OSX)
    var color: NSColor
    #elseif os(iOS) || os(tvOS)
    var color: UIColor
    #endif
    
    public init(r: CGFloat, g: CGFloat, b: CGFloat) {
        #if os(OSX)
            color = NSColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
        #elseif os(iOS) || os(tvOS)
            color = UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
        #endif
    }
    
    public convenience init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        self.init(r: red * 255, g: green * 255, b: blue * 255)
    }
    
    var redColor: Int {
        var r: CGFloat = 0
        color.getRed(&r, green: nil, blue: nil, alpha: nil)
        return Int(r * 255)
    }
    
    var greenColor: Int {
        var g: CGFloat = 0
        color.getRed(nil, green: &g, blue: nil, alpha: nil)
        return Int(g * 255)
    }
    var blueColor: Int {
        var b: CGFloat = 0
        color.getRed(nil, green: nil, blue: &b, alpha: nil)
        return Int(b * 255)
    }
}

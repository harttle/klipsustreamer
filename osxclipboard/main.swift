import Foundation
import AppKit
import Darwin

var pasteboard = NSPasteboard.general

func printInfo() {
    print(toJson(obj: ["count": pasteboard.changeCount, "types": pasteboard.types!]))
}

func printByType(type: NSString!) {
    let dataType = NSPasteboard.PasteboardType(rawValue: type as String)
    if let data = pasteboard.data(forType: dataType) {
        FileHandle.standardOutput.write(data)
    }
}

func setByType(type: NSString!) -> Bool {
    let dataType = NSPasteboard.PasteboardType(rawValue: type as String)
    let data = FileHandle.standardInput.readDataToEndOfFile()
    pasteboard.declareTypes([dataType], owner: nil)
    return pasteboard.setData(data, forType: dataType)
}

func toJson(obj: Any) -> NSString {
    let data = try! JSONSerialization.data(withJSONObject: obj)
    return NSString(data: data, encoding: String.Encoding.utf8.rawValue)!
}

func printHelp() {
    print("Usage:\n  -h, --help\tShow help\n  -c, --count\tShow clipboard change count\n  -i, --input <type>\tSet clipboard by type with content from stdin\n  -o, --output <type>\tOutput clipboard content by type\n  -s, --status\tShow clipboard information")
}

let args = CommandLine.arguments

if (args.count <= 1) {
    printHelp()
    exit(1)
}
else if (args[1] == "--help" || args[1] == "-h") {
    printHelp()
}
else if (args[1] == "--count" || args[1] == "-c") {
    print(pasteboard.changeCount)
}
else if (args[1] == "--status" || args[1] == "-s") {
    printInfo()
}
else if (args.count >= 2 && (args[1] == "--input" || args[1] == "-i")) {
    exit(setByType(type: args[2] as NSString) ? 0 : 1)
}
else if (args.count >= 2 && (args[1] == "--output" || args[1] == "-o")) {
    printByType(type: args[2] as NSString)
}
else {
    printHelp()
    exit(1)
}

/**
 * Расширение NSDate
 */

import Foundation

extension NSDate {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter.string(from: self as Date)
    }
}

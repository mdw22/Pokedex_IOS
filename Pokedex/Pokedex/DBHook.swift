//
//  DBHook.swift
//  Pokedex
//
//  Created by Michael White on 7/2/24.
//

import Foundation
import SQLite3

public struct DBHook {
    
    static let shared = DBHook()
        var db: OpaquePointer?

        public init() {
            db = openDatabase()
        }

        private func openDatabase() -> OpaquePointer? {
            let fileURL = Bundle.main.url(forResource: "LocalDB", withExtension: "db")!
            
            var db: OpaquePointer? = nil
            if sqlite3_open(fileURL.path, &db) == SQLITE_OK {
                print("Successfully opened connection to database at \(fileURL.path)")
                return db
            } else {
                print("Unable to open database.")
                return nil
            }
        }

        func query(_ queryString: String) -> [[String: Any]]? {
            var queryStatement: OpaquePointer? = nil
            var result = [[String: Any]]()

            if sqlite3_prepare_v2(db, queryString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    var row = [String: Any]()
                    for column in 0..<sqlite3_column_count(queryStatement) {
                        let columnName = String(cString: sqlite3_column_name(queryStatement, column))
                        let columnText = String(cString: sqlite3_column_text(queryStatement, column))
                        row[columnName] = columnText
                    }
                    result.append(row)
                }
            } else {
                print("SELECT statement could not be prepared")
                return nil
            }
            sqlite3_finalize(queryStatement)
            return result
        }
}

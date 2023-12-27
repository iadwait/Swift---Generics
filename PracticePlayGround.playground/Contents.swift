import UIKit

// MARK: - Variable Declarations
var greeting = "Hello, Adwait"
print(greeting)
print("----------Topic - Generics----------")

// MARK: - Classes and Structs
struct Person: Codable {
    var name: String
}

class Employee: Codable {
    var Employees: [EmpNames]
}

class EmpNames: Codable {
    var name: String
}

// MARK: - Generic Methods

/// Function call to get first and last element from a list
/// - Parameter list: List or array of any datatype
/// - Returns: (First Element, Last Element)
func getFirstAndLast<T>(list: [T]) -> (T, T) {
    return (list[0], list[list.count - 1])
}

/// Function call to parse JSON Response
/// - Parameters:
///   - parsingClassType: Parsing Class type
///   - response: Response in Data
/// - Returns: Parsed Object
func parseResponse<T: Decodable>(parsingClassType: T.Type, response: Data) -> T? {
    do {
        let obj = try JSONDecoder().decode(parsingClassType, from: response)
        return obj
    } catch {
        print("Catch Error \(error)")
        return nil
    }
}

// MARK: - Generic Method's Testing

print("1.Generic Function to get First and Last Element of a list(Any Datatype)")
let result = getFirstAndLast(list: [1,2,3,4,5])
print("Test Case 1 = \(result.0),\(result.1)")

let result1 = getFirstAndLast(list: ["A","B", "p"])
print("Test Case 2 = \(result1.0),\(result1.1)")

print("2.Generic Function to parse JSON Response by passing Parsing Class Name")
let sampleResponse = """
{
    "name": "John"
}
"""

let parsedObj = parseResponse(parsingClassType: Person.self, response: sampleResponse.data(using: .utf8) ?? Data())
print("Test Case 1: Object Parsed Response = \(parsedObj?.name ?? "")")

let sampleResponse2 = """
{
    "Employees": [
        {
            "name": "Peter"
        },
        {
            "name": "Bravo"
        }
    ]
}
"""

let obj = parseResponse(parsingClassType: Employee.self, response: sampleResponse2.data(using: .utf8) ?? Data())
print("Test Case 2: Employee Count = \(obj?.Employees.count ?? -1)")

print("----------End----------")

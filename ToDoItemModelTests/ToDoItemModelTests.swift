import XCTest
@testable import ToDoItemModel

class ToDoItemModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    //MARK: - ToDoItem testing
    
    func testThatJSONIsNotDictionary() throws {
        let incorrectJSON = [ true : "isDone" ]
        let result = ToDoItem.parse(json: incorrectJSON)
        XCTAssertNil(result)
    }
    
    func testThatIdIsNotString() throws {
        let incorrectJSON: [String : Any] = ["id" : 7]
        let result = ToDoItem.parse(json: incorrectJSON)
        XCTAssertNil(result)
    }
    
    func testThatTextIsNotString() throws {
        let incorrectJSON: [String : Any] = ["id" : "1", "text" : 7]
        let result = ToDoItem.parse(json: incorrectJSON)
        XCTAssertNil(result)
    }
    
    func testThatPriorityIsNotInt() throws {
        let incorrectJSON: [String : Any] = ["id" : "1",
                                             "text" : "7",
                                             "priority" : "a",
                                             "deadline":123.0,
                                             "isDone": false,
                                             "creationDate":123.0,
                                             "modificationDate":123.0]
        let result = ToDoItem.parse(json: incorrectJSON)
        XCTAssert(result?.priority == .regular)
    }
    
    func testThatPriorityIntIsMoreThan2() throws {
        let incorrectJSON: [String : Any] = ["id" : "1",
                                             "text" : "7",
                                             "priority" : 7,
                                             "deadline":123.0,
                                             "isDone": false,
                                             "creationDate":123.0,
                                             "modificationDate":123.0]
        let result = ToDoItem.parse(json: incorrectJSON)
        XCTAssert(result?.priority == .regular)
    }
    
    func testThatPriorityIntIs0() throws {
        let incorrectJSON: [String : Any] = ["id" : "1",
                                             "text" : "7",
                                             "priority" : 0,
                                             "deadline":123.0,
                                             "isDone": false,
                                             "creationDate":123.0,
                                             "modificationDate":123.0]
        let result = ToDoItem.parse(json: incorrectJSON)
        XCTAssert(result?.priority == .unimportant)
    }
    
    func testThatIsDoneNotBool() throws {
        let incorrectJSON: [String : Any] = ["id" : "1",
                                             "text" : "7",
                                             "priority" : 0,
                                             "deadline":123.0,
                                             "isDone": "false",
                                             "creationDate":123.0,
                                             "modificationDate":123.0]
        let result = ToDoItem.parse(json: incorrectJSON)
        XCTAssertNil(result)
    }
    
    func testThatCreationDateIsNotTimeInterval() throws {
        let incorrectJSON: [String : Any] = ["id" : "1",
                                             "text" : "7",
                                             "priority" : 0,
                                             "deadline":123.0,
                                             "isDone": false,
                                             "creationDate":"123.0",
                                             "modificationDate":123.0]
        let result = ToDoItem.parse(json: incorrectJSON)
        XCTAssertNil(result)
    }
    
    func testThatItIsNoPriority() throws {
        let incorrectJSON: [String : Any] = ["id" : "1",
                                             "text" : "7",
                                             "isDone": false,
                                             "deadline":123.0,
                                             "creationDate":123.0,
                                             "modificationDate":123.0]
        let result = ToDoItem.parse(json: incorrectJSON)
        XCTAssert(result != nil)
    }
    
    func testThatItIsNoDeadlineAndPriority() throws {
        let incorrectJSON: [String : Any] = ["id" : "1",
                                             "text" : "7",
                                             "isDone": false,
                                             "creationDate":123.0,
                                             "modificationDate":123.0]
        let result = ToDoItem.parse(json: incorrectJSON)
        XCTAssert(result != nil)
    }
    
    func testThatItIsNoDeadlineAndPriorityAndModificationDate() throws {
        let incorrectJSON: [String : Any] = ["id" : "1",
                                             "text" : "7",
                                             "isDone": false,
                                             "creationDate":123.0]
        let result = ToDoItem.parse(json: incorrectJSON)
        XCTAssert(result != nil)
    }
    
    func testThatJSONResultCreatedAsDictionary() throws {
        let task = ToDoItem(id: "1", text: "1", priority: .regular, deadline: nil, isDone: true, creationDate: Date(), modificationDate: nil)
        
        let result: [String:Any] = task.json as! [String : Any]
        
        XCTAssert(result["id"] as! String == "1")
    }
    
    func testThatJSONCreatedWithoutPriorityIfItIsRegular() throws {
        let task = ToDoItem(id: "1", text: "1", priority: .regular, deadline: nil, isDone: true, creationDate: Date(), modificationDate: nil)
        
        let result: [String:Any] = task.json as! [String : Any]
        
        XCTAssert(result["priority"] == nil)
    }
    
    func testThatJSONSavePriorityIfItIsNotRegular() throws {
        let task = ToDoItem(id: "1", text: "1", priority: .important, deadline: nil, isDone: true, creationDate: Date(), modificationDate: nil)
        
        let result: [String:Any] = task.json as! [String : Any]
        
        XCTAssert(result["priority"] != nil)
    }
    
    func testThatJSONSaveDeadline() throws {
        let task = ToDoItem(id: "1", text: "1", priority: .important, deadline: Date(), isDone: true, creationDate: Date(), modificationDate: nil)
        
        let result: [String:Any] = task.json as! [String : Any]
        
        XCTAssert(result["deadline"] != nil)
    }
    
    func testThatJSONSaveModificationDate() throws {
        let task = ToDoItem(id: "1", text: "1", priority: .important, deadline: Date(), isDone: true, creationDate: Date(), modificationDate: Date())
        
        let result: [String:Any] = task.json as! [String : Any]
        
        XCTAssert(result["modificationDate"] != nil)
    }
}

import UIKit

//Satya sowri Sampath Korturti
//002926129
//korturti.s@notheastern.edu
//Swift Functions

//Write a Swift function that computes the area of a rectangle while passing the length
//and breadth

func rectangleArea(length: Double, breadth: Double) -> Double {
    return length * breadth
}
let l = 10.0
let b = 5.0
let area = rectangleArea(length: l, breadth: b)
print("area of the rectangle of length \(l) and breadth \(b) is \(area)")

//Write a swift function personInfo() that prints a String with name, age and location of
//person which are to be passed as parameters to the function

func personInfo(name: String, age: Int, location: String) -> String {
    return "Name: \(name), Age: \(age), Location: \(location)"
}
let name = "Sowri"
let age = 30
let location = "London"
let personInfoString = personInfo(name: name, age: age, location: location)
print(personInfoString)

//Create a function isPalindrome() which take a string as input and checks whether the
//string is Palindrome or not, Print the value that returns from this function on the
//console (true or false)
func isPalindrome(input: String) -> Bool {
    let lowercased = input.lowercased()
    let reversed = String(lowercased.reversed())
    return lowercased == reversed
}
let input = "radar"
let isPalindromeResult = isPalindrome(input: input)
print(isPalindromeResult)

//Swift Structures
//Create a structure ‘Student with four properties: Name(String),Age(Int), ID(Int),
//isGraduated (Bool)
struct Student {
    var name: String
    var age: Int
    var id: Int
    var isGraduated: Bool
}
var student = Student(name: "Sowri", age: 25, id: 123456, isGraduated: false)
print("Name: \(student.name)")
print("Age: \(student.age)")
print("ID: \(student.id)")
print("Graduated: \(student.isGraduated)")

//Create 3 instances of the structure providing the Name, ID, Age and
//isGradtuated values.
var student1 = Student(name: "Sowri", age: 25, id: 123456, isGraduated: false)
var student2 = Student(name: "Rikin", age: 26, id: 654321, isGraduated: true)
var student3 = Student(name: "Sakhshi", age: 27, id: 111111, isGraduated: false)

print("Student 1:")
print("Name: \(student1.name)")
print("Age: \(student1.age)")
print("ID: \(student1.id)")
print("Graduated: \(student1.isGraduated)")

print("\nStudent 2:")
print("Name: \(student2.name)")
print("Age: \(student2.age)")
print("ID: \(student2.id)")
print("Graduated: \(student2.isGraduated)")

print("\nStudent 3:")
print("Name: \(student3.name)")
print("Age: \(student3.age)")
print("ID: \(student3.id)")
print("Graduated: \(student3.isGraduated)")

//In structure student, create a function which checks the graduation status and ID
//of the student and returns a String with the graduation status

struct Studentmod {
    var name: String
    var age: Int
    var id: Int
    var isGraduated: Bool
    
    func checkStatus() -> String {
        if self.isGraduated {
            return "Graduated"
        } else {
            return "Not Graduated"
        }
    }
}

var studentmod = Studentmod(name: "Sowri", age: 25, id: 123456, isGraduated: false)
student.name = "Jane"
print("Name: \(studentmod.name)")
print("Age: \(studentmod.age)")
print("ID: \(studentmod.id)")
print("Graduated: \(studentmod.isGraduated)")

//Call the function in the structure “Student” and print its values
var studentCall = Studentmod(name: "Sowri", age: 25, id: 123456, isGraduated: false)
print("Name: \(studentCall.name)")
print("ID: \(studentCall.id)")
print("Status: \(studentCall.checkStatus())")


//Swift Classes
//Create a class ‘Vehicle’ with properties wheels (Int), fuel (Int), maxSpeed(Int),
//color (String)
// Initialize the class and create 3 instances of Vehicle class.
// Create a function maxSpeed() that prints the maximum speed the car can go at
//and numberOfWheels() that print the total number of wheels on the vehicle

class Vehicle {
    var wheels: Int
    var fuel: Int
    var maxSpeed: Int
    var color: String
    
    init(wheels: Int, fuel: Int, maxSpeed: Int, color: String) {
        self.wheels = wheels
        self.fuel = fuel
        self.maxSpeed = maxSpeed
        self.color = color
    }
    
    func getMaxSpeed() {
        print("The maximum speed is: \(self.maxSpeed)")
    }
    
    func numberOfWheels() {
        print("The number of wheels is: \(self.wheels)")
    }
}

let car1 = Vehicle(wheels: 4, fuel: 50, maxSpeed: 200, color: "Red")
let car2 = Vehicle(wheels: 4, fuel: 60, maxSpeed: 180, color: "Blue")
let car3 = Vehicle(wheels: 4, fuel: 40, maxSpeed: 220, color: "Black")

car1.getMaxSpeed()
car1.numberOfWheels()

car2.getMaxSpeed()
car2.numberOfWheels()

car3.getMaxSpeed()
car3.numberOfWheels()

//Create a class “Bike” that inherits the Vehicle class. This class should override
//the numberOfWheels() to return the number of wheels as 2
//Create a class “Car” that inherits the Vehicle class. This class should override the
//numberOfWheels() to return the number of wheels as 4. Also create a new
//method numberOfSeats() that takes in an Integer and return the capacity of the
//Car

class Bike: Vehicle {
    override func numberOfWheels() {
        print("The number of wheels is: 2")
    }
}

class Car: Vehicle {
    override func numberOfWheels() {
        print("The number of wheels is: 4")
    }
    
    func numberOfSeats(seats: Int) -> String {
        return "The car has a capacity of \(seats) seats."
    }
}

//let bike = Bike(wheels: 2, fuel: 30, maxSpeed: 150, color: "Green")
//bike.numberOfWheels()

//let car = Car(wheels: 4, fuel: 50, maxSpeed: 200, color: "Red")
//car.numberOfWheels()
//print(car.numberOfSeats(seats: 5))

//Create an instance of class ‘Bike’ and class ‘Car’
//Print maxSpeed() and numberOfWheels() for both the instances.
//Print numberOfSeats() for the Car instance.

let bike = Bike(wheels: 2, fuel: 30, maxSpeed: 150, color: "Green")
bike.numberOfWheels()
bike.getMaxSpeed()


let car = Car(wheels: 4, fuel: 50, maxSpeed: 200, color: "Red")
car.numberOfWheels()
car.getMaxSpeed()
print(car.numberOfSeats(seats: 5))

//Swift Optionals
//declare an Optional integer in a variable with value set to 5
//Use Optional Binding and Optional Chaining both to print value of the variable
var optionalInt: Int? 

// Optional Binding
if let unwrappedInt = optionalInt {
  print("The value of the Optional integer is: \(unwrappedInt)")
} else {
  print("The Optional integer is nil")
}

// Optional Chaining
print("The value of the Optional integer is: \(optionalInt?.description ?? "nil")")

// Taking user input for zipcode using Optional
print("Enter the zipcode:")
let userInput = readLine()

// Checking if the zipcode is empty
if let zipcode = userInput {
  if zipcode.count == 5 {
    // Unwrapping the zipcode value
    if let zipcodeInt = Int(zipcode) {
      print("The zipcode is: \(zipcodeInt)")
    } else {
      print("Incorrect zipcode")
    }
  } else {
    print("Incorrect zipcode")
  }
} else {
  print("Empty value")
}

//Protocols

protocol House {
    func numberOfBedrooms() -> Int
    func numberOfBathrooms() -> Double
    func numberOfFloors() -> Int
}

class MyHouse: House {
    func numberOfBedrooms() -> Int {
        return 5
    }
    
    func numberOfBathrooms() -> Double {
        return 5.2
    }
    
    func numberOfFloors() -> Int {
        return 4
    }
}

let myHouse = MyHouse()
print("Number of Bedrooms: \(myHouse.numberOfBedrooms())")
print("Number of Bathrooms: \(myHouse.numberOfBathrooms())")
print("Number of Floors: \(myHouse.numberOfFloors())")

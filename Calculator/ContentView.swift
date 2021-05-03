//
//  ContentView.swift
//  Calculator
//
//  Created by joao camargo on 01/05/21.
//

import SwiftUI

enum MathOperation : Equatable{
    case number(Int)
    case addition
    case subtraction
    
    func description() -> String{
        switch self {
        case .addition:
            return " + "
        case .subtraction:
            return " - "
        case .number(let number):
            return "\(number)"
        }
    }
}

struct ContentView: View {
    
    var finalResult: Int {
        var result = 0
        
        var operationAction: MathOperation? = nil
        
        for oper in operation {
            switch oper {
            case .addition, .subtraction:
                operationAction = oper
            case .number(let number):
                if operationAction == .addition {
                    result += number
                } else if operationAction == .subtraction {
                    result -= number
                } else {
                    result += number
                }
            }
        }
        
        return result
    }
    
    
    //@State var operationSteps = [Int]()
    
    @State var operation = [MathOperation]()
    
    
    var operationDescription: String {
        var result = ""
        
        for oper in operation {
            result.append(oper.description())
        }
        
        return result
    }
    
    let title: String = "Calculate something"
    let clearButtonIsDisabled = false
    
    
    var body: some View {
        
        VStack(alignment: .center) {
            Text(title).font(.title).padding().offset(x: 10, y: 10)
            
            Text("\(finalResult)")
            Text(operationDescription).bold().font(.footnote).foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/).padding(10)
            
            HStack {
                
                ForEach(1..<10) { number in
                    Button(action: {
                        add(number)
                    }, label: {
                        Text("\(number)")
                    }).padding().border(Color.black)
                }

            }
            
            HStack {
                Button(action: {
                    operation.append(.addition)
                }, label: {
                    Text("+")
                })
                
                Button(action: {
                    operation.append(.subtraction)
                }, label: {
                    Text("-")
                })
            }
            
            Button(action: {
                operation.removeAll()
            }, label: {
                Text("A/C")
            }).padding(10).disabled(clearButtonIsDisabled)
            
            Button(action: {
                if operation.last != nil {
                    operation.removeLast()
                }
            }, label: {
                Text("<-")
            })
        }
    }
    
    
    func add(_ number: Int) {
        
        if let lastOperation = operation.last {
            switch lastOperation {
            case .addition, .subtraction:
                operation.append(.number(number))
            case .number(let numbervalue):
                let new = MathOperation.number(numbervalue * 10 + number)
                operation.removeLast()
                operation.append(new)
            }
        } else {
            operation.append(.number(number))
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}

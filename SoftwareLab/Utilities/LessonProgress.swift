import Foundation

enum VariableTask: Int, CaseIterable {
    case characterCreation = 0
    case treasureHunt = 1
    case temperatureConverter = 2
    case currencyCalculator = 3
    case ageCalculator = 4
    
    var nextTask: VariableTask? {
        let nextRawValue = self.rawValue + 1
        return VariableTask(rawValue: nextRawValue)
    }
    
    var destinationView: String {
        switch self {
        case .characterCreation:
            return "JsVariablePracticeView"
        case .treasureHunt:
            return "JsTreasureHuntView"
        case .temperatureConverter:
            return "JsTemperatureConverterView"
        case .currencyCalculator:
            return "JsCurrencyCalculatorView"
        case .ageCalculator:
            return "JsAgeCalculatorView"
        }
    }
}

enum OperatorTask: Int, CaseIterable {
    case basicOperators = 0    // Mevcut görev
    case comparisonTask = 1    // Karşılaştırma operatörleri
    case logicalTask = 2       // Mantıksal operatörler
    case combinedTask = 3      // Karışık operatörler
    case finalTask = 4         // Final görevi
    
    var nextTask: OperatorTask? {
        let nextRawValue = self.rawValue + 1
        return OperatorTask(rawValue: nextRawValue)
    }
    
    var destinationView: String {
        switch self {
        case .basicOperators:
            return "JsOperatorsPracticeView"
        case .comparisonTask:
            return "JsComparisonTaskView"
        case .logicalTask:
            return "JsLogicalOperatorsView"
        case .combinedTask:
            return "JsCombinedOperatorsView"
        case .finalTask:
            return "JsOperatorsFinalView"
        }
    }
}

enum LoopTask: Int, CaseIterable {
    case forLoop = 0
    case whileLoop = 1
    case doWhileLoop = 2
    case nestedLoops = 3
    case loopControl = 4
    
    var nextTask: LoopTask? {
        let nextRawValue = self.rawValue + 1
        return LoopTask(rawValue: nextRawValue)
    }
    
    var destinationView: String {
        switch self {
        case .forLoop:
            return "JsLoopsPracticeView"
        case .whileLoop:
            return "JsWhileLoopView"
        case .doWhileLoop:
            return "JsDoWhileLoopView"
        case .nestedLoops:
            return "JsNestedLoopsView"
        case .loopControl:
            return "JsLoopControlView"
        }
    }
}

enum FunctionTask: Int, CaseIterable {
    case basicFunction = 0      // Temel fonksiyon tanımlama
    case parameterFunction = 1  // Parametreli fonksiyon
    case returnFunction = 2     // Değer döndüren fonksiyon
    case arrowFunction = 3      // Arrow function kullanımı
    case calculatorFunction = 4 // Final görevi: Hesap makinesi
    
    var nextTask: FunctionTask? {
        let allCases = Self.allCases
        guard let currentIndex = allCases.firstIndex(of: self),
              currentIndex + 1 < allCases.count else {
            return nil
        }
        return allCases[currentIndex + 1]
    }
    
    var destinationView: String {
        switch self {
        case .basicFunction:
            return "JsBasicFunctionView"
        case .parameterFunction:
            return "JsParameterFunctionView"
        case .returnFunction:
            return "JsReturnFunctionView"
        case .arrowFunction:
            return "JsArrowFunctionView"
        case .calculatorFunction:
            return "JsCalculatorFunctionView"
        }
    }
}

class LessonProgress: ObservableObject {
    @Published var currentTask: VariableTask = .characterCreation
    @Published var currentOperatorTask: OperatorTask = .basicOperators
    @Published var currentLoopTask: LoopTask = .forLoop
    @Published var currentFunctionTask: FunctionTask = .basicFunction
    
    func moveToNextTask() -> Bool {
        if let next = currentTask.nextTask {
            currentTask = next
            return true
        }
        return false
    }
    
    func moveToNextOperatorTask() -> Bool {
        if let next = currentOperatorTask.nextTask {
            currentOperatorTask = next
            return true
        }
        return false
    }
    
    func moveToNextLoopTask() -> Bool {
        if let next = currentLoopTask.nextTask {
            currentLoopTask = next
            return true
        }
        return false
    }
    
    func moveToNextFunctionTask() -> Bool {
        if let next = currentFunctionTask.nextTask {
            currentFunctionTask = next
            return true
        }
        return false
    }
} 
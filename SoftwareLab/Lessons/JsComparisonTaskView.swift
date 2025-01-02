import SwiftUI

struct JsComparisonTaskView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
    // Karşılaştırma operatörlerini kullanarak x ve y değişkenlerini karşılaştırın
    let x = 15;
    let y = 10;

    // x, y'den büyüktür
    let result1 = x > y;  // true

    // x, y'ye eşit değildir
    let result2 = x != y; // true

    // x, y'den büyük veya eşittir
    let result3 = x >= y; // true
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Karşılaştırma Operatörleri",
                    description: "1. x ve y değişkenlerini tanımlayın (x=15, y=10)\n2. result1: x'in y'den büyük olup olmadığını kontrol edin (>)\n3. result2: x'in y'ye eşit olup olmadığını kontrol edin (!=)\n4. result3: x'in y'den büyük veya eşit olup olmadığını kontrol edin (>=)"
                )
                
                // Kod editörü kartı
                VStack(alignment: .leading, spacing: 12) {
                    Text("Kod Editörü")
                        .font(.headline)
                    
                    CodeEditor(text: $userCode)
                    
                    HStack {
                        Button("Çalıştır") {
                            withAnimation {
                                runCode()
                            }
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        
                        Button("Temizle") {
                            userCode = """
                            // Karşılaştırma operatörlerini kullanarak x ve y değişkenlerini karşılaştırın
                            let x = 15;
                            let y = 10;

                            // x, y'den büyüktür
                            let result1 = x > y;  // true

                            // x, y'ye eşit değildir
                            let result2 = x != y; // true

                            // x, y'den büyük veya eşittir
                            let result3 = x >= y; // true
                            """
                            outputMessage = ""
                            showResults = false
                            isCompleted = false
                        }
                        .buttonStyle(SecondaryButtonStyle())
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.1), radius: 5)
                
                // Sonuç mesajı
                if showResults {
                    Text(outputMessage)
                        .foregroundColor(isCompleted ? .green : .red)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    if isCompleted {
                        NavigationLink(destination: JsLogicalOperatorsView()) {
                            HStack {
                                Image(systemName: "arrow.right.circle.fill")
                                Text("Sonraki Görev")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding(.top, 20)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Karşılaştırma Operatörleri")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        var variables: [String: Any] = [:]
        
        // x ve y değerlerini kontrol et
        if let xRange = jsCode.range(of: "let x = "),
           let xEndRange = jsCode.range(of: ";", range: xRange.upperBound..<jsCode.endIndex) {
            let xStr = jsCode[xRange.upperBound..<xEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if let xValue = Double(xStr) {
                variables["x"] = xValue
            }
        }
        
        if let yRange = jsCode.range(of: "let y = "),
           let yEndRange = jsCode.range(of: ";", range: yRange.upperBound..<jsCode.endIndex) {
            let yStr = jsCode[yRange.upperBound..<yEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if let yValue = Double(yStr) {
                variables["y"] = yValue
            }
        }
        
        // Sonuçları kontrol et
        var result1: Bool?
        var result2: Bool?
        var result3: Bool?
        
        if let result1Range = jsCode.range(of: "let result1 = "),
           let result1EndRange = jsCode.range(of: ";", range: result1Range.upperBound..<jsCode.endIndex) {
            let expr = jsCode[result1Range.upperBound..<result1EndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if expr.contains("x > y") {
                result1 = (variables["x"] as? Double ?? 0) > (variables["y"] as? Double ?? 0)
            }
        }
        
        if let result2Range = jsCode.range(of: "let result2 = "),
           let result2EndRange = jsCode.range(of: ";", range: result2Range.upperBound..<jsCode.endIndex) {
            let expr = jsCode[result2Range.upperBound..<result2EndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if expr.contains("x != y") {
                result2 = (variables["x"] as? Double ?? 0) != (variables["y"] as? Double ?? 0)
            }
        }
        
        if let result3Range = jsCode.range(of: "let result3 = "),
           let result3EndRange = jsCode.range(of: ";", range: result3Range.upperBound..<jsCode.endIndex) {
            let expr = jsCode[result3Range.upperBound..<result3EndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if expr.contains("x >= y") {
                result3 = (variables["x"] as? Double ?? 0) >= (variables["y"] as? Double ?? 0)
            }
        }
        
        // Sonuçları değerlendir
        if let x = variables["x"] as? Double,
           let y = variables["y"] as? Double,
           let r1 = result1,
           let r2 = result2,
           let r3 = result3 {
            if x == 15 && y == 10 && r1 == true && r2 == true && r3 == true {
                outputMessage = "Tebrikler! Tüm karşılaştırmalar doğru! 🎉"
                isCompleted = true
            } else {
                outputMessage = "Karşılaştırma sonuçları yanlış. Tekrar deneyin!"
                isCompleted = false
            }
        } else {
            outputMessage = "Lütfen tüm değişkenleri ve karşılaştırmaları tanımlayın!"
            isCompleted = false
        }
        showResults = true
    }
} 
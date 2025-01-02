import SwiftUI

struct JsTemperatureConverterView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
    // Celsius'tan Fahrenheit'a dönüşüm yapın
    // Örnek:
    // let celsius = 25;
    // let fahrenheit = (celsius * 9/5) + 32;
    
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    @State private var celsiusValue: Double?
    @State private var fahrenheitValue: Double?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Sıcaklık Dönüştürücü",
                    description: "1. celsius değişkenini tanımlayın (25 derece)\n2. fahrenheit değişkenini tanımlayın ve formülü uygulayın\n3. Sonuç 77°F olmalı"
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
                            // Celsius'tan Fahrenheit'a dönüşüm yapın
                            // Örnek:
                            // let celsius = 25;
                            // let fahrenheit = (celsius * 9/5) + 32;
                            
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
                
                if showResults {
                    Text(outputMessage)
                        .foregroundColor(isCompleted ? .green : .red)
                        .font(.headline)
                        .padding()
                    
                    if isCompleted {
                        NavigationLink(destination: JsCurrencyCalculatorView()) {
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
        .navigationTitle("Sıcaklık Dönüştürücü")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Celsius değerini kontrol et
        if let celsiusRange = jsCode.range(of: "let celsius = "),
           let celsiusEndRange = jsCode.range(of: ";", range: celsiusRange.upperBound..<jsCode.endIndex) {
            let celsiusStr = jsCode[celsiusRange.upperBound..<celsiusEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            celsiusValue = Double(celsiusStr)
        }
        
        // Fahrenheit değerini kontrol et
        if let fahrenheitRange = jsCode.range(of: "let fahrenheit = "),
           let fahrenheitEndRange = jsCode.range(of: ";", range: fahrenheitRange.upperBound..<jsCode.endIndex) {
            let fahrenheitStr = jsCode[fahrenheitRange.upperBound..<fahrenheitEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            
            // Parantezleri ve boşlukları temizle
            let cleanFormula = fahrenheitStr.replacingOccurrences(of: " ", with: "")
            
            // Formülü kontrol et
            if cleanFormula.contains("celsius*9/5+32") || cleanFormula.contains("(celsius*9/5)+32") {
                fahrenheitValue = celsiusValue.map { ($0 * 9/5) + 32 }
            }
        }
        
        if let celsius = celsiusValue, let fahrenheit = fahrenheitValue {
            if celsius == 25 && abs(fahrenheit - 77) < 0.001 {
                outputMessage = "Tebrikler! Doğru dönüşüm yaptınız! 🎉\n25°C = 77°F"
                isCompleted = true
            } else {
                outputMessage = "Dönüşüm sonucu yanlış. Tekrar deneyin!"
                isCompleted = false
            }
        } else {
            outputMessage = "Lütfen celsius ve fahrenheit değişkenlerini doğru formatta tanımlayın!"
            isCompleted = false
        }
        showResults = true
    }
    
    private func getNextView() -> AnyView? {
        if progress.moveToNextTask() {
            switch progress.currentTask {
            case .currencyCalculator:
                return AnyView(JsCurrencyCalculatorView())
            case .ageCalculator:
                return AnyView(JsAgeCalculatorView())
            default:
                return nil
            }
        }
        return nil
    }
} 
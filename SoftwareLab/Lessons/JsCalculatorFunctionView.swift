import SwiftUI

struct JsCalculatorFunctionView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
    // Hesap makinesi fonksiyonları
    const add = (a, b) => a + b;
    const subtract = (a, b) => a - b;
    const multiply = (a, b) => a * b;
    const divide = (a, b) => b !== 0 ? a / b : "Sıfıra bölünemez";
    
    // Hesap makinesini çalıştır
    function calculator(operation, num1, num2) {
        switch(operation) {
            case '+': return add(num1, num2);
            case '-': return subtract(num1, num2);
            case '*': return multiply(num1, num2);
            case '/': return divide(num1, num2);
            default: return "Geçersiz işlem";
        }
    }
    
    // Test işlemleri
    console.log(calculator('+', 10, 5));  // 15
    console.log(calculator('-', 10, 5));  // 5
    console.log(calculator('*', 10, 5));  // 50
    console.log(calculator('/', 10, 5));  // 2
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Hesap Makinesi",
                    description: "1. Arrow function ile 4 işlem fonksiyonlarını tanımlayın\n2. calculator fonksiyonunu oluşturun\n3. switch-case yapısını kullanın\n4. Test işlemlerini yapın"
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
                            // Hesap makinesi fonksiyonları
                            
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
                
                if showResults {
                    Text(outputMessage)
                        .foregroundColor(isCompleted ? .green : .red)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                if isCompleted {
                    NavigationLink(destination: JsFunctionsPracticeView()) {
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
            .padding()
        }
        .navigationTitle("Hesap Makinesi")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if jsCode.contains("const add = (a, b) => a + b") &&
           jsCode.contains("const subtract = (a, b) => a - b") &&
           jsCode.contains("const multiply = (a, b) => a * b") &&
           jsCode.contains("const divide = (a, b) => b !== 0 ? a / b : \"Sıfıra bölünemez\"") &&
           jsCode.contains("function calculator(operation, num1, num2)") &&
           jsCode.contains("switch(operation)") {
            outputMessage = "Tebrikler! Hesap makinesi fonksiyonlarını doğru oluşturdunuz! 🎉\nÇıktı:\n15\n5\n50\n2"
            isCompleted = true
            progress.moveToNextFunctionTask()
        } else {
            outputMessage = "Hesap makinesi yapısı hatalı. Tekrar deneyin!"
            isCompleted = false
        }
        showResults = true
    }
}
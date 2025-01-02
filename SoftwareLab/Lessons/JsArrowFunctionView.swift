import SwiftUI

struct JsArrowFunctionView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
    // Arrow function kullanımı
    // Örnek:
    // const greet = (name) => {
    //     console.log("Merhaba " + name);
    // }
    
    const square = (number) => {
        return number * number;
    }
    
    // Kısa yazım
    const double = number => number * 2;
    
    // Fonksiyonları çağırın
    console.log(square(5));
    console.log(double(6));
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Arrow Function",
                    description: "1. square fonksiyonunu arrow function olarak tanımlayın\n2. double fonksiyonunu kısa syntax ile tanımlayın\n3. Fonksiyonları çağırın"
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
                            // Arrow function kullanımı
                            // Örnek:
                            // const greet = (name) => {
                            //     console.log("Merhaba " + name);
                            // }
                            
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
                    NavigationLink(destination: JsCalculatorFunctionView()) {
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
        .navigationTitle("Arrow Function")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if jsCode.contains("const square = (number) =>") &&
           jsCode.contains("return number * number") &&
           jsCode.contains("const double = number => number * 2") {
            outputMessage = "Tebrikler! Arrow function'ları doğru kullandınız! 🎉\nÇıktı:\n25\n12"
            isCompleted = true
            progress.moveToNextFunctionTask()
        } else {
            outputMessage = "Arrow function yapısı hatalı. Tekrar deneyin!"
            isCompleted = false
        }
        showResults = true
    }
}
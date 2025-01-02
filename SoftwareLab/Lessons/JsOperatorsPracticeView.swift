import SwiftUI

struct JsOperatorsPracticeView: View {
    @State private var userCode = """
    // Değişkenleri tanımlayın ve işlemlerin sonuçları tablodaki gibi olsun
    // Örnek:
    let A = 20;
    let B = 10;
    let C = 50;
    let D = 5;
    let E = 2;
    let F = 5;
    let X = 100;
    let Y = 50;
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Görev kartı
                TaskCard(
                    title: "Operatörler Görevi",
                    description: "1. Tüm değişkenleri tanımlayın (A, B, C, D, E, F, X, Y)\n2. İşlemlerin sonuçları tablodaki değerlerle eşleşmeli"
                )
                
                // Tablo
                VStack(spacing: 16) {
                    Text("Hedef Sonuçlar")
                        .font(.headline)
                    
                    Grid(alignment: .leading, horizontalSpacing: 20, verticalSpacing: 12) {
                        GridRow {
                            Text("İşlem").bold()
                            Text("Sonuç").bold()
                        }
                        Divider()
                        GridRow {
                            Text("A + B")
                            Text("30")
                        }
                        GridRow {
                            Text("C - D")
                            Text("45")
                        }
                        GridRow {
                            Text("E * F")
                            Text("10")
                        }
                        GridRow {
                            Text("X / Y")
                            Text("2")
                        }
                    }
                    .padding()
                    .background(Color(.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.1), radius: 5)
                }
                
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
                            // Değişkenleri tanımlayın ve işlemlerin sonuçları tablodaki gibi olsun
                            // Örnek:
                            let A = 20;
                            let B = 10;
                            let C = 50;
                            let D = 5;
                            let E = 2;
                            let F = 5;
                            let X = 100;
                            let Y = 50;
                            
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
                        NavigationLink(destination: JsComparisonTaskView()) {
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
        .navigationTitle("Operatörler Pratiği")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Değişkenlerin tanımlanması ve işlemlerin kontrolü
        if jsCode.contains("let A = 20") &&
           jsCode.contains("let B = 10") &&
           jsCode.contains("let C = 50") &&
           jsCode.contains("let D = 5") &&
           jsCode.contains("let E = 2") &&
           jsCode.contains("let F = 5") &&
           jsCode.contains("let X = 100") &&
           jsCode.contains("let Y = 50") {
            
            // Sonuçların kontrolü
            let a = 20, b = 10  // A + B = 30
            let c = 50, d = 5  // C - D = 45
            let e = 2, f = 5  // E * F = 10
            let x = 100, y = 50 // X / Y = 2
            
            if (a + b == 30) && (c - d == 45) && (e * f == 10) && (x / y == 2) {
                outputMessage = "Tebrikler! Tüm işlemler doğru! 🎉\n\nSonuçlar:\nA + B = 30\nC - D = 45\nE * F = 10\nX / Y = 2"
                isCompleted = true
            } else {
                outputMessage = "İşlem sonuçları tablodaki değerlerle eşleşmiyor. Tekrar deneyin!"
                isCompleted = false
            }
        } else {
            outputMessage = "Değişkenler eksik veya hatalı tanımlanmış. Tekrar deneyin!"
            isCompleted = false
        }
        showResults = true
    }
}

struct OperatorsCodeEditor: View {
    @Binding var text: String
    
    var body: some View {
        TextEditor(text: $text)
            .font(.system(.body, design: .monospaced))
            .frame(height: 200)
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}

struct JsOperatorsPracticeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JsOperatorsPracticeView()
        }
    }
} 

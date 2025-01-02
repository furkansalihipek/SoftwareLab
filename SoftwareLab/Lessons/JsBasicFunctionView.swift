import SwiftUI

struct JsBasicFunctionView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
    // Temel fonksiyon tanımlama
    // Örnek:
    // function sayHello() {
    //     console.log("Merhaba!");
    // }
    
    function welcomeMessage() {
        console.log("JavaScript'e Hoş Geldiniz!");
    }
    
    // Fonksiyonu çağırın
    welcomeMessage();
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Temel Fonksiyon",
                    description: "1. welcomeMessage adında bir fonksiyon tanımlayın\n2. Fonksiyon içinde karşılama mesajı yazdırın\n3. Fonksiyonu çağırın"
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
                            // Temel fonksiyon tanımlama
                            // Örnek:
                            // function sayHello() {
                            //     console.log("Merhaba!");
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
                    NavigationLink(destination: JsParameterFunctionView()) {
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
        .navigationTitle("Temel Fonksiyon")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if jsCode.contains("function welcomeMessage()") &&
           jsCode.contains("console.log(\"JavaScript'e Hoş Geldiniz!\")") &&
           jsCode.contains("welcomeMessage();") {
            outputMessage = "Tebrikler! Temel fonksiyonu doğru tanımladınız ve çağırdınız! 🎉"
            isCompleted = true
            progress.moveToNextFunctionTask()
        } else {
            outputMessage = "Fonksiyon yapısı hatalı. Tekrar deneyin!"
            isCompleted = false
        }
        showResults = true
    }
} 
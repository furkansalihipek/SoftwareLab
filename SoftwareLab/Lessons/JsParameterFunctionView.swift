import SwiftUI

struct JsParameterFunctionView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
    // Parametreli fonksiyon
    // Örnek:
    // function greet(name) {
    //     console.log("Merhaba " + name);
    // }
    
    function calculateArea(width, height) {
        console.log("Alan: " + (width * height));
    }
    
    // Fonksiyonu çağırın
    calculateArea(5, 3);
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Parametreli Fonksiyon",
                    description: "1. calculateArea fonksiyonunu tanımlayın\n2. width ve height parametrelerini kullanın\n3. Alanı hesaplayıp yazdırın\n4. Fonksiyonu çağırın (5, 3)"
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
                            // Parametreli fonksiyon
                            // Örnek:
                            // function greet(name) {
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
                    NavigationLink(destination: JsReturnFunctionView()) {
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
        .navigationTitle("Parametreli Fonksiyon")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if jsCode.contains("function calculateArea(width, height)") &&
           jsCode.contains("console.log(\"Alan: \" + (width * height))") &&
           jsCode.contains("calculateArea(5, 3)") {
            outputMessage = "Tebrikler! Parametreli fonksiyonu doğru kullandınız! 🎉\nÇıktı: Alan: 15"
            isCompleted = true
        } else {
            outputMessage = "Fonksiyon yapısı hatalı. Tekrar deneyin!"
            isCompleted = false
        }
        showResults = true
    }
} 
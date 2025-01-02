import SwiftUI

struct JsWhileLoopView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
    // While döngüsü ile çift sayıları bulun
    // Örnek:
    // let num = 1;
    // while(num <= 4) {
    //     if(num % 2 === 0) {
    //         console.log(num);
    //     }
    //     num++;
    // }
    
    let num = 1;
    while(num <= 10) {
        if(num % 2 === 0) {
            console.log(num);
        }
        num++;
    }
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Çift Sayıları Bulma",
                    description: "1. num değişkenini 1 olarak tanımlayın\n2. While döngüsü ile 1'den 10'a kadar olan çift sayıları bulun\n3. Beklenen çıktı: 2, 4, 6, 8, 10"
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
                            // While döngüsü ile çift sayıları bulun
                            // Örnek:
                            // let num = 1;
                            // while(num <= 4) {
                            //     if(num % 2 === 0) {
                            //         console.log(num);
                            //     }
                            //     num++;
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
                    NavigationLink(destination: JsDoWhileLoopView()) {
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
        .navigationTitle("While Döngüsü")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // While döngüsü kontrolü
        if jsCode.contains("while(num <= 10)") &&
           jsCode.contains("if(num % 2 === 0)") &&
           jsCode.contains("num++") {
            let evenNumbers = Array(stride(from: 2, through: 10, by: 2))
            outputMessage = "Tebrikler! Çift sayıları doğru buldunuz! 🎉\nÇift sayılar: \(evenNumbers.map(String.init).joined(separator: ", "))"
            isCompleted = true
        } else {
            outputMessage = "While döngüsü yapısı hatalı. Tekrar deneyin!"
            isCompleted = false
        }
        showResults = true
    }
} 
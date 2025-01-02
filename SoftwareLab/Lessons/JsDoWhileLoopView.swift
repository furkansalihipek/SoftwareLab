import SwiftUI

struct JsDoWhileLoopView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
    // Do-While döngüsü ile sayı tahmin oyunu
    // Örnek:
    // let guess;
    // do {
    //     guess = prompt("Sayı tahmini:");
    // } while(guess != 5);
    
    let targetNumber = 7;
    let guess;
    do {
        guess = prompt("1-10 arası bir sayı tahmin edin:");
    } while(guess != targetNumber);
    console.log("Tebrikler! Doğru tahmin!");
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Sayı Tahmin Oyunu",
                    description: "1. targetNumber değişkenini 7 olarak tanımlayın\n2. Do-While döngüsü ile kullanıcıdan tahmin alın\n3. Doğru tahmin edildiğinde tebrik mesajı gösterin"
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
                            // Do-While döngüsü ile sayı tahmin oyunu
                            // Örnek:
                            // let guess;
                            // do {
                            //     guess = prompt("Sayı tahmini:");
                            // } while(guess != 5);
                            
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
                }
                
                if isCompleted {
                    NavigationLink(destination: JsNestedLoopsView()) {
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
        .navigationTitle("Do-While Döngüsü")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Do-While döngüsü kontrolü
        if jsCode.contains("let targetNumber = 7") &&
           jsCode.contains("do {") &&
           jsCode.contains("guess = prompt") &&
           jsCode.contains("} while(guess != targetNumber)") &&
           jsCode.contains("console.log(\"Tebrikler! Doğru tahmin!\")") {
            outputMessage = "Tebrikler! Do-While döngüsünü doğru kullandınız! 🎉\nKullanıcı 7 sayısını tahmin edene kadar döngü devam edecek."
            isCompleted = true
        } else {
            outputMessage = "Do-While döngüsü yapısı hatalı. Tekrar deneyin!"
            isCompleted = false
        }
        showResults = true
    }
} 

import SwiftUI

struct JsNestedLoopsView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
    // İç içe döngüler ile çarpım tablosu
    // Örnek:
    // for(let i = 1; i <= 2; i++) {
    //     for(let j = 1; j <= 2; j++) {
    //         console.log(i + " x " + j + " = " + (i*j));
    //     }
    // }
    
    for(let i = 1; i <= 5; i++) {
        for(let j = 1; j <= 5; j++) {
            console.log(i + " x " + j + " = " + (i*j));
        }
    }
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Çarpım Tablosu",
                    description: "1. Dış döngü: 1'den 5'e kadar sayılar (i)\n2. İç döngü: 1'den 5'e kadar sayılar (j)\n3. Her adımda i x j işleminin sonucunu yazdırın"
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
                            // İç içe döngüler ile çarpım tablosu
                            // Örnek:
                            // for(let i = 1; i <= 2; i++) {
                            //     for(let j = 1; j <= 2; j++) {
                            //         console.log(i + " x " + j + " = " + (i*j));
                            //     }
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
                
                // Sonuç mesajı
                if showResults {
                    Text(outputMessage)
                        .foregroundColor(isCompleted ? .green : .red)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                }
                
                if isCompleted {
                    NavigationLink(destination: JsLoopControlView()) {
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
        .navigationTitle("İç İçe Döngüler")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // İç içe döngü kontrolü
        if jsCode.contains("for(let i = 1; i <= 5; i++)") &&
           jsCode.contains("for(let j = 1; j <= 5; j++)") &&
           jsCode.contains("console.log(i + \" x \" + j + \" = \" + (i*j))") {
            
            var output = "Tebrikler! İç içe döngüleri doğru kullandınız! 🎉\n\nÖrnek çıktı:\n"
            for i in 1...3 {
                for j in 1...3 {
                    output += "\(i) x \(j) = \(i*j)\n"
                }
            }
            output += "..."
            
            outputMessage = output
            isCompleted = true
        } else {
            outputMessage = "İç içe döngü yapısı hatalı. Tekrar deneyin!"
            isCompleted = false
        }
        showResults = true
    }
}
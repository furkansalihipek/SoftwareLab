import SwiftUI

struct JsLoopControlView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
    // Break ve Continue kullanımı
    // Örnek:
    // for(let i = 1; i <= 5; i++) {
    //     if(i === 3) continue;
    //     console.log(i);
    // }
    
    for(let i = 1; i <= 10; i++) {
        if(i === 5) continue;
        if(i === 8) break;
        console.log(i);
    }
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Break ve Continue",
                    description: "1. 1'den 10'a kadar döngü oluşturun\n2. 5 geldiğinde continue kullanın\n3. 8 geldiğinde break kullanın\n4. Beklenen çıktı: 1, 2, 3, 4, 6, 7"
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
                            // Break ve Continue kullanımı
                            // Örnek:
                            // for(let i = 1; i <= 5; i++) {
                            //     if(i === 3) continue;
                            //     console.log(i);
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
                    NavigationLink(destination: JavaScriptLessonsView()) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                            Text("Dersi Tamamla")
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
        .navigationTitle("Break ve Continue")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Break ve Continue kontrolü
        if jsCode.contains("for(let i = 1; i <= 10; i++)") &&
           jsCode.contains("if(i === 5) continue") &&
           jsCode.contains("if(i === 8) break") &&
           jsCode.contains("console.log(i)") {
            
            var output = "Tebrikler! Break ve Continue kullanımı doğru! 🎉\n\nÇıktı:\n"
            for i in 1...10 {
                if i == 5 { continue }
                if i == 8 { break }
                output += "\(i) "
            }
            
            outputMessage = output
            isCompleted = true
        } else {
            outputMessage = "Break ve Continue yapısı hatalı. Tekrar deneyin!"
            isCompleted = false
        }
        showResults = true
    }
} 
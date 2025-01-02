import SwiftUI

struct JsLoopsPracticeView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
    // For döngüsü ile 1'den 5'e kadar olan sayıları toplayın
    // Örnek:
    // let sum = 0;
    // for(let i = 1; i <= 3; i++) {
    //     sum = sum + i;
    // }
    
    let sum = 0;
    for(let i = 1; i <= 5; i++) {
        sum = sum + i;
    }
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Sayı Toplama",
                    description: "1. sum değişkenini 0 olarak tanımlayın\n2. For döngüsü ile 1'den 5'e kadar olan sayıları toplayın\n3. Beklenen sonuç: 15 (1+2+3+4+5)"
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
                            // For döngüsü ile 1'den 5'e kadar olan sayıları toplayın
                            // Örnek:
                            // let sum = 0;
                            // for(let i = 1; i <= 3; i++) {
                            //     sum = sum + i;
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
                    NavigationLink(destination: JsWhileLoopView()) {
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
        .navigationTitle("For Döngüsü")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        // Kod kontrolü ve değerlendirme mantığı
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        var sum = 0
        
        // For döngüsü kontrolü
        if jsCode.contains("for(let i = 1; i <= 5; i++)") &&
           jsCode.contains("sum = sum + i") {
            sum = (1...5).reduce(0, +)
            if sum == 15 {
                outputMessage = "Tebrikler! Doğru toplama işlemi! 🎉\nToplam: 15"
                isCompleted = true
            } else {
                outputMessage = "Toplama sonucu yanlış. Tekrar deneyin!"
                isCompleted = false
            }
        } else {
            outputMessage = "For döngüsü yapısı hatalı. Tekrar deneyin!"
            isCompleted = false
        }
        showResults = true
    }
}

struct JsLoopsPracticeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JsLoopsPracticeView()
        }
    }
} 
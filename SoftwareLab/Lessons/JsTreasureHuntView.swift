import SwiftUI

struct JsTreasureHuntView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var userCode = """
    // 1-10 arasında bir sayı tanımlayın
    // Örnek:
    // let steps = 5;
    
    """
    @State private var outputMessage = ""
    @State private var steps = 0
    @State private var showAnimation = false
    @State private var characterPosition: CGFloat = 0
    @State private var isCompleted = false
    @State private var navigateToLessons = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Görev kartı
                TaskCard(
                    title: "Hazine Avı",
                    description: "1. Number türünde bir değişken oluşturun\n2. 1-10 arasında bir değer atayın\n3. Karakteriniz bu değer kadar adım atacak\n4. Hazineye ulaşmak için 10 adım gerekiyor!"
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
                            // 1-10 arasında bir sayı tanımlayın
                            // Örnek:
                            // let steps = 5;
                            
                            """
                            outputMessage = ""
                            showAnimation = false
                            characterPosition = 0
                        }
                        .buttonStyle(SecondaryButtonStyle())
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.1), radius: 5)
                
                // Animasyon ve çıktı alanı
                if showAnimation {
                    VStack(spacing: 20) {
                        // Hazine avı animasyonu
                        ZStack(alignment: .leading) {
                            // Yol
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 10)
                            
                            // Hazine
                            Image(systemName: "trophy.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 40))
                                .offset(x: UIScreen.main.bounds.width - 100)
                            
                            // Karakter yerine daire
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 25, height: 25)
                                .offset(x: characterPosition)
                        }
                        .frame(height: 15)
                        .padding(.horizontal)
                        
                        // Çıktı mesajı
                        Text(outputMessage)
                            .foregroundColor(steps == 10 ? .green : .red)
                            .font(.headline)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        // Devam Et butonu - sadece bölüm tamamlandığında görünür
                        if isCompleted {
                            NavigationLink(destination: JsTemperatureConverterView()) {
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
            }
            .padding()
        }
        .navigationTitle("Hazine Avı")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Basit JS parser
        if let range = jsCode.range(of: "let steps = "),
           let endRange = jsCode.range(of: ";", range: range.upperBound..<jsCode.endIndex) {
            let numberStr = jsCode[range.upperBound..<endRange.lowerBound].trimmingCharacters(in: .whitespaces)
            
            if let number = Int(numberStr) {
                steps = number
                
                if number >= 1 && number <= 10 {
                    showAnimation = true
                    withAnimation(.easeInOut(duration: 2)) {
                        characterPosition = CGFloat(number) * ((UIScreen.main.bounds.width - 100) / 10)
                    }
                    
                    if number == 10 {
                        outputMessage = "Tebrikler! Hazineye ulaştınız! 🎉"
                        isCompleted = true
                    } else if number < 10 {
                        outputMessage = "Hazineye ulaşmak için \(10 - number) adım daha gerekiyor!"
                        isCompleted = false
                    }
                } else {
                    outputMessage = "Lütfen 1-10 arasında bir sayı girin!"
                    isCompleted = false
                }
            } else {
                outputMessage = "Geçerli bir sayı girmediniz!"
                isCompleted = false
            }
        } else {
            outputMessage = "Hata: Doğru formatta bir değişken tanımlamadınız!"
            isCompleted = false
        }
    }
} 

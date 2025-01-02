import SwiftUI

struct JsCurrencyCalculatorView: View {
    @State private var userCode = """
    // TL'yi dolara çevirin (1 dolar = 30 TL)
    // Örnek:
    // let tl = 300;
    // let dolar = tl / 30;
    
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Para Birimi Hesaplayıcı",
                    description: "1. tl değişkenini tanımlayın (300 TL)\n2. dolar değişkenini tanımlayın ve dönüşümü yapın\n3. Sonuç 10 dolar olmalı"
                )
                
                // Kod editörü ve diğer UI elemanları
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
                            // TL'yi dolara çevirin (1 dolar = 30 TL)
                            // Örnek:
                            // let tl = 300;
                            // let dolar = tl / 30;
                            
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
                
                if showResults {
                    Text(outputMessage)
                        .foregroundColor(isCompleted ? .green : .red)
                        .font(.headline)
                        .padding()
                    
                    if isCompleted {
                        NavigationLink(destination: JsAgeCalculatorView()) {
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
        .navigationTitle("Para Birimi Hesaplayıcı")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        var tlValue: Double?
        var dolarValue: Double?
        
        // TL değerini kontrol et
        if let tlRange = jsCode.range(of: "let tl = "),
           let tlEndRange = jsCode.range(of: ";", range: tlRange.upperBound..<jsCode.endIndex) {
            let tlStr = jsCode[tlRange.upperBound..<tlEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            tlValue = Double(tlStr)
        }
        
        // Dolar değerini kontrol et
        if let dolarRange = jsCode.range(of: "let dolar = "),
           let dolarEndRange = jsCode.range(of: ";", range: dolarRange.upperBound..<jsCode.endIndex) {
            let dolarStr = jsCode[dolarRange.upperBound..<dolarEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if dolarStr.contains("tl/30") || dolarStr.contains("tl / 30") {
                dolarValue = tlValue.map { $0 / 30 }
            }
        }
        
        if let tl = tlValue, let dolar = dolarValue {
            if tl == 300 && abs(dolar - 10) < 0.001 {
                outputMessage = "Tebrikler! Doğru dönüşüm yaptınız! 🎉\n300 TL = 10 Dolar"
                isCompleted = true
            } else {
                outputMessage = "Dönüşüm sonucu yanlış. Tekrar deneyin!"
                isCompleted = false
            }
        } else {
            outputMessage = "Lütfen tl ve dolar değişkenlerini doğru formatta tanımlayın!"
            isCompleted = false
        }
        showResults = true
    }
} 
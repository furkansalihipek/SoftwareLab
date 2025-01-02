import SwiftUI

struct JsCombinedOperatorsView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
    // Değişkenleri tanımlayın
    let price = 100;
    let isVIP = true;

    // İndirim hesaplama
    let discount = isVIP ? 20 : 0;
    let finalPrice = price * (1 - discount / 100);
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Karışık Operatörler",
                    description: "1. price değişkenini tanımlayın (100)\n2. isVIP değişkenini tanımlayın (true)\n3. discount değişkenini tanımlayın (isVIP ? 20 : 0)\n4. finalPrice değişkenini tanımlayın (price * (1 - discount / 100))"
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
                            // Değişkenleri tanımlayın
                            let price = 100;
                            let isVIP = true;

                            // İndirim hesaplama
                            let discount = isVIP ? 20 : 0;
                            let finalPrice = price * (1 - discount / 100);
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
                    NavigationLink(destination: JsOperatorsFinalView()) {
                        HStack {
                            Image(systemName: "arrow.right.circle.fill")
                            Text("Son Görev")
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
        .navigationTitle("Karışık Operatörler")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        var variables: [String: Any] = [:]
        
        // price değerini kontrol et
        if let priceRange = jsCode.range(of: "let price = "),
           let priceEndRange = jsCode.range(of: ";", range: priceRange.upperBound..<jsCode.endIndex) {
            let priceStr = jsCode[priceRange.upperBound..<priceEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if let priceValue = Double(priceStr) {
                variables["price"] = priceValue
            }
        }
        
        // isVIP değerini kontrol et
        if let isVIPRange = jsCode.range(of: "let isVIP = "),
           let isVIPEndRange = jsCode.range(of: ";", range: isVIPRange.upperBound..<jsCode.endIndex) {
            let isVIPStr = jsCode[isVIPRange.upperBound..<isVIPEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if isVIPStr == "true" {
                variables["isVIP"] = true
            }
        }
        
        // discount kontrolü
        var discount: Double?
        if let discountRange = jsCode.range(of: "let discount = "),
           let discountEndRange = jsCode.range(of: ";", range: discountRange.upperBound..<jsCode.endIndex) {
            let expr = jsCode[discountRange.upperBound..<discountEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if expr.contains("isVIP ? 20 : 0") {
                if let isVIP = variables["isVIP"] as? Bool {
                    discount = isVIP ? 20 : 0
                }
            }
        }
        
        // finalPrice kontrolü
        var finalPrice: Double?
        if let finalPriceRange = jsCode.range(of: "let finalPrice = "),
           let finalPriceEndRange = jsCode.range(of: ";", range: finalPriceRange.upperBound..<jsCode.endIndex) {
            let expr = jsCode[finalPriceRange.upperBound..<finalPriceEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if expr.contains("price * (1 - discount / 100)") {
                if let price = variables["price"] as? Double,
                   let disc = discount {
                    finalPrice = price * (1 - disc / 100)
                }
            }
        }
        
        // Sonuçları değerlendir
        if let price = variables["price"] as? Double,
           let isVIP = variables["isVIP"] as? Bool,
           let disc = discount,
           let final = finalPrice {
            if price == 100 && isVIP == true && disc == 20 && abs(final - 80) < 0.001 {
                outputMessage = "Tebrikler! Tüm operatörler doğru kullanıldı! 🎉\nİndirimli fiyat: 80 TL"
                isCompleted = true
            } else {
                outputMessage = "Hesaplama sonuçları yanlış. Tekrar deneyin!"
                isCompleted = false
            }
        } else {
            outputMessage = "Lütfen tüm değişkenleri doğru formatta tanımlayın!"
            isCompleted = false
        }
        showResults = true
    }
} 
import SwiftUI

struct JsOperatorsFinalView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
    // Final görevi: Alışveriş sepeti hesaplaması
    let itemCount = 5;
    let basePrice = 100;
    let isFirstTimeCustomer = true;
    let isBulkOrder = itemCount >= 5;
    let firstTimeDiscount = isFirstTimeCustomer ? 20 : 0;
    let bulkDiscount = isBulkOrder ? 15 : 0;
    let totalDiscount = firstTimeDiscount + bulkDiscount;
    let finalPrice = (basePrice * itemCount) * (1 - totalDiscount / 100);
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Alışveriş Sepeti Hesaplayıcı",
                    description: """
                    1. itemCount (ürün sayısı) = 5
                    2. basePrice (birim fiyat) = 100
                    3. isFirstTimeCustomer = true
                    4. isBulkOrder = itemCount >= 5
                    5. firstTimeDiscount = isFirstTimeCustomer ? 20 : 0
                    6. bulkDiscount = isBulkOrder ? 15 : 0
                    7. totalDiscount = firstTimeDiscount + bulkDiscount
                    8. finalPrice = (basePrice * itemCount) * (1 - totalDiscount / 100)
                    """
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
                            // Final görevi: Alışveriş sepeti hesaplaması
                            let itemCount = 5;
                            let basePrice = 100;
                            let isFirstTimeCustomer = true;
                            let isBulkOrder = itemCount >= 5;
                            let firstTimeDiscount = isFirstTimeCustomer ? 20 : 0;
                            let bulkDiscount = isBulkOrder ? 15 : 0;
                            let totalDiscount = firstTimeDiscount + bulkDiscount;
                            let finalPrice = (basePrice * itemCount) * (1 - totalDiscount / 100);
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
        .navigationTitle("Final Görevi")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        var variables: [String: Any] = [:]
        
        // Değişkenleri kontrol et
        if let itemCountRange = jsCode.range(of: "let itemCount = "),
           let itemCountEndRange = jsCode.range(of: ";", range: itemCountRange.upperBound..<jsCode.endIndex) {
            let itemCountStr = jsCode[itemCountRange.upperBound..<itemCountEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if let itemCountValue = Int(itemCountStr) {
                variables["itemCount"] = itemCountValue
            }
        }
        
        if let basePriceRange = jsCode.range(of: "let basePrice = "),
           let basePriceEndRange = jsCode.range(of: ";", range: basePriceRange.upperBound..<jsCode.endIndex) {
            let basePriceStr = jsCode[basePriceRange.upperBound..<basePriceEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if let basePriceValue = Double(basePriceStr) {
                variables["basePrice"] = basePriceValue
            }
        }
        
        if let isFirstTimeCustomerRange = jsCode.range(of: "let isFirstTimeCustomer = "),
           let isFirstTimeCustomerEndRange = jsCode.range(of: ";", range: isFirstTimeCustomerRange.upperBound..<jsCode.endIndex) {
            let isFirstTimeCustomerStr = jsCode[isFirstTimeCustomerRange.upperBound..<isFirstTimeCustomerEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if isFirstTimeCustomerStr == "true" {
                variables["isFirstTimeCustomer"] = true
            }
        }
        
        // isBulkOrder kontrolü
        var isBulkOrder: Bool?
        if let isBulkOrderRange = jsCode.range(of: "let isBulkOrder = "),
           let isBulkOrderEndRange = jsCode.range(of: ";", range: isBulkOrderRange.upperBound..<jsCode.endIndex) {
            let expr = jsCode[isBulkOrderRange.upperBound..<isBulkOrderEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if expr.contains("itemCount >= 5") {
                if let itemCount = variables["itemCount"] as? Int {
                    isBulkOrder = itemCount >= 5
                }
            }
        }
        
        // firstTimeDiscount kontrolü
        var firstTimeDiscount: Double?
        if let firstTimeDiscountRange = jsCode.range(of: "let firstTimeDiscount = "),
           let firstTimeDiscountEndRange = jsCode.range(of: ";", range: firstTimeDiscountRange.upperBound..<jsCode.endIndex) {
            let expr = jsCode[firstTimeDiscountRange.upperBound..<firstTimeDiscountEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if expr.contains("isFirstTimeCustomer ? 20 : 0") {
                if let isFirstTimeCustomer = variables["isFirstTimeCustomer"] as? Bool {
                    firstTimeDiscount = isFirstTimeCustomer ? 20 : 0
                }
            }
        }
        
        // bulkDiscount kontrolü
        var bulkDiscount: Double?
        if let bulkDiscountRange = jsCode.range(of: "let bulkDiscount = "),
           let bulkDiscountEndRange = jsCode.range(of: ";", range: bulkDiscountRange.upperBound..<jsCode.endIndex) {
            let expr = jsCode[bulkDiscountRange.upperBound..<bulkDiscountEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if expr.contains("isBulkOrder ? 15 : 0") {
                if let isBulkOrder = isBulkOrder {
                    bulkDiscount = isBulkOrder ? 15 : 0
                }
            }
        }
        
        // totalDiscount kontrolü
        var totalDiscount: Double?
        if let totalDiscountRange = jsCode.range(of: "let totalDiscount = "),
           let totalDiscountEndRange = jsCode.range(of: ";", range: totalDiscountRange.upperBound..<jsCode.endIndex) {
            let expr = jsCode[totalDiscountRange.upperBound..<totalDiscountEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if expr.contains("firstTimeDiscount + bulkDiscount") {
                if let ftd = firstTimeDiscount, let bd = bulkDiscount {
                    totalDiscount = ftd + bd
                }
            }
        }
        
        // finalPrice kontrolü
        var finalPrice: Double?
        if let finalPriceRange = jsCode.range(of: "let finalPrice = "),
           let finalPriceEndRange = jsCode.range(of: ";", range: finalPriceRange.upperBound..<jsCode.endIndex) {
            let expr = jsCode[finalPriceRange.upperBound..<finalPriceEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if expr.contains("(basePrice * itemCount) * (1 - totalDiscount / 100)") {
                if let basePrice = variables["basePrice"] as? Double,
                   let itemCount = variables["itemCount"] as? Int,
                   let td = totalDiscount {
                    finalPrice = Double(itemCount) * basePrice * (1 - td / 100)
                }
            }
        }
        
        // Sonuçları değerlendir
        if let itemCount = variables["itemCount"] as? Int,
           let basePrice = variables["basePrice"] as? Double,
           let isFirstTimeCustomer = variables["isFirstTimeCustomer"] as? Bool,
           let bo = isBulkOrder,
           let ftd = firstTimeDiscount,
           let bd = bulkDiscount,
           let td = totalDiscount,
           let fp = finalPrice {
            
            let expectedFinalPrice = 500 * (1 - 35.0 / 100) // 325
            
            if itemCount == 5 && basePrice == 100 && isFirstTimeCustomer == true && bo == true &&
                ftd == 20 && bd == 15 && td == 35 && abs(fp - expectedFinalPrice) < 0.001 {
                outputMessage = "Tebrikler! Alışveriş sepeti hesaplaması doğru! 🎉\nToplam İndirim: %35\nFinal Fiyat: 325 TL"
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
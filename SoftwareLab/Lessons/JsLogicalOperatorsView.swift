import SwiftUI

struct JsLogicalOperatorsView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
    // Mantıksal operatörleri kullanarak koşulları kontrol edin
    let age = 25;
    let isStudent = true;

    // Yaş 18'den büyük VE öğrenci
    let hasDiscount = age < 30 && isStudent;  // true

    // Yaş 30'dan küçük VEYA öğrenci
    let isEligible = age >= 18 || isStudent;  // true
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Mantıksal Operatörler",
                    description: "1. age değişkenini tanımlayın (25)\n2. isStudent değişkenini tanımlayın (true)\n3. hasDiscount değişkenini tanımlayın (age < 30 && isStudent)\n4. isEligible değişkenini tanımlayın (age >= 18 || isStudent)"
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
                            // Mantıksal operatörleri kullanarak koşulları kontrol edin
                            let age = 25;
                            let isStudent = true;

                            // Yaş 18'den büyük VE öğrenci
                            let hasDiscount = age < 30 && isStudent;  // true

                            // Yaş 30'dan küçük VEYA öğrenci
                            let isEligible = age >= 18 || isStudent;  // true
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
                    NavigationLink(destination: JsCombinedOperatorsView()) {
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
        .navigationTitle("Mantıksal Operatörler")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        var variables: [String: Any] = [:]
        
        // age değerini kontrol et
        if let ageRange = jsCode.range(of: "let age = "),
           let ageEndRange = jsCode.range(of: ";", range: ageRange.upperBound..<jsCode.endIndex) {
            let ageStr = jsCode[ageRange.upperBound..<ageEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if let ageValue = Int(ageStr) {
                variables["age"] = ageValue
            }
        }
        
        // isStudent değerini kontrol et
        if let isStudentRange = jsCode.range(of: "let isStudent = "),
           let isStudentEndRange = jsCode.range(of: ";", range: isStudentRange.upperBound..<jsCode.endIndex) {
            let isStudentStr = jsCode[isStudentRange.upperBound..<isStudentEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if isStudentStr == "true" {
                variables["isStudent"] = true
            }
        }
        
        // hasDiscount kontrolü
        var hasDiscount: Bool?
        if let hasDiscountRange = jsCode.range(of: "let hasDiscount = "),
           let hasDiscountEndRange = jsCode.range(of: ";", range: hasDiscountRange.upperBound..<jsCode.endIndex) {
            let expr = jsCode[hasDiscountRange.upperBound..<hasDiscountEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if expr.contains("age < 30 && isStudent") {
                if let age = variables["age"] as? Int,
                   let isStudent = variables["isStudent"] as? Bool {
                    hasDiscount = age < 30 && isStudent
                }
            }
        }
        
        // isEligible kontrolü
        var isEligible: Bool?
        if let isEligibleRange = jsCode.range(of: "let isEligible = "),
           let isEligibleEndRange = jsCode.range(of: ";", range: isEligibleRange.upperBound..<jsCode.endIndex) {
            let expr = jsCode[isEligibleRange.upperBound..<isEligibleEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if expr.contains("age >= 18 || isStudent") {
                if let age = variables["age"] as? Int,
                   let isStudent = variables["isStudent"] as? Bool {
                    isEligible = age >= 18 || isStudent
                }
            }
        }
        
        // Sonuçları değerlendir
        if let age = variables["age"] as? Int,
           let isStudent = variables["isStudent"] as? Bool,
           let hd = hasDiscount,
           let ie = isEligible {
            if age == 25 && isStudent == true && hd == true && ie == true {
                outputMessage = "Tebrikler! Tüm mantıksal operatörler doğru kullanıldı! 🎉"
                isCompleted = true
            } else {
                outputMessage = "Mantıksal operatör sonuçları yanlış. Tekrar deneyin!"
                isCompleted = false
            }
        } else {
            outputMessage = "Lütfen tüm değişkenleri ve mantıksal operatörleri doğru formatta tanımlayın!"
            isCompleted = false
        }
        showResults = true
    }
} 
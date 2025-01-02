import SwiftUI

struct JsAgeCalculatorView: View {
    @State private var userCode = """
    // Doğum yılından yaş hesaplama
    // Örnek:
    // let birthYear = 2000;
    // let currentYear = 2024;
    // let age = currentYear - birthYear;
    
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Yaş Hesaplayıcı",
                    description: "1. birthYear değişkenini tanımlayın (2000)\n2. currentYear değişkenini tanımlayın (2024)\n3. age değişkenini tanımlayın ve yaşı hesaplayın"
                )
                
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
                            // Doğum yılından yaş hesaplama
                            // Örnek:
                            // let birthYear = 2000;
                            // let currentYear = 2024;
                            // let age = currentYear - birthYear;
                            
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
            }
            .padding()
        }
        .navigationTitle("Yaş Hesaplayıcı")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        var birthYearValue: Int?
        var currentYearValue: Int?
        var ageValue: Int?
        
        // Doğum yılını kontrol et
        if let birthYearRange = jsCode.range(of: "let birthYear = "),
           let birthYearEndRange = jsCode.range(of: ";", range: birthYearRange.upperBound..<jsCode.endIndex) {
            let birthYearStr = jsCode[birthYearRange.upperBound..<birthYearEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            birthYearValue = Int(birthYearStr)
        }
        
        // Şimdiki yılı kontrol et
        if let currentYearRange = jsCode.range(of: "let currentYear = "),
           let currentYearEndRange = jsCode.range(of: ";", range: currentYearRange.upperBound..<jsCode.endIndex) {
            let currentYearStr = jsCode[currentYearRange.upperBound..<currentYearEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            currentYearValue = Int(currentYearStr)
        }
        
        // Yaş hesaplamasını kontrol et
        if let ageRange = jsCode.range(of: "let age = "),
           let ageEndRange = jsCode.range(of: ";", range: ageRange.upperBound..<jsCode.endIndex) {
            let ageStr = jsCode[ageRange.upperBound..<ageEndRange.lowerBound].trimmingCharacters(in: .whitespaces)
            if ageStr.contains("currentYear-birthYear") || ageStr.contains("currentYear - birthYear") {
                ageValue = currentYearValue.flatMap { currentYear in
                    birthYearValue.map { birthYear in
                        currentYear - birthYear
                    }
                }
            }
        }
        
        if let birthYear = birthYearValue,
           let currentYear = currentYearValue,
           let age = ageValue {
            if birthYear == 2000 && currentYear == 2024 && age == 24 {
                outputMessage = "Tebrikler! Doğru yaş hesaplaması yaptınız! 🎉\n2024 - 2000 = 24 yaş"
                isCompleted = true
            } else {
                outputMessage = "Hesaplama sonucu yanlış. Tekrar deneyin!"
                isCompleted = false
            }
        } else {
            outputMessage = "Lütfen tüm değişkenleri doğru formatta tanımlayın!"
            isCompleted = false
        }
        showResults = true
    }
} 
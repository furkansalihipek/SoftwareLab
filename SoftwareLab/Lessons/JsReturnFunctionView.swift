import SwiftUI

struct JsReturnFunctionView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
    // Değer döndüren fonksiyon
    // Örnek:
    // function sum(a, b) {
    //     return a + b;
    // }
    
    function calculateDiscount(price, discountRate) {
        return price - (price * discountRate / 100);
    }
    
    // Fonksiyonu çağırın ve sonucu yazdırın
    let finalPrice = calculateDiscount(100, 20);
    console.log("İndirimli fiyat: " + finalPrice);
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: "Değer Döndüren Fonksiyon",
                    description: "1. calculateDiscount fonksiyonunu tanımlayın\n2. İndirim hesaplamasını yapın\n3. Sonucu return ile döndürün\n4. Fonksiyonu çağırıp sonucu yazdırın"
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
                            // Değer döndüren fonksiyon
                            // Örnek:
                            // function sum(a, b) {
                            //     return a + b;
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
                    NavigationLink(destination: JsArrowFunctionView()) {
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
        .navigationTitle("Değer Döndüren Fonksiyon")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if jsCode.contains("function calculateDiscount(price, discountRate)") &&
           jsCode.contains("return price - (price * discountRate / 100)") &&
           jsCode.contains("calculateDiscount(100, 20)") {
            outputMessage = "Tebrikler! Değer döndüren fonksiyonu doğru kullandınız! 🎉\nÇıktı: İndirimli fiyat: 80"
            isCompleted = true
            progress.moveToNextFunctionTask()
        } else {
            outputMessage = "Fonksiyon yapısı hatalı. Tekrar deneyin!"
            isCompleted = false
        }
        showResults = true
    }
}
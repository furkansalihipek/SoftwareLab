import SwiftUI

struct JsVariablePracticeView: View {
    @StateObject private var progress = LessonProgress()
    @State private var userCode = """
// Karakterin adını ve yaşını tanımlayın
// Örnek:
// let characterName = "Ahmet";
// let characterAge = 25;

"""
    @State private var outputMessage = ""
    @State private var showCharacter = false
    @State private var characterName = ""
    @State private var characterAge = 0
    @State private var isShowingHint = false
    @State private var showSuccessMessage = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Görev kartı
                TaskCard(
                    title: "Görev",
                    description: "1. String türünde bir değişken oluşturun ve karakterinizin adını atayın\n2. Number türünde bir değişken oluşturun ve karakterinizin yaşını atayın"
                )
                
                // Kod editörü kartı
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Kod Editörü")
                            .font(.headline)
                        
                        Spacer()
                        
                        Button(action: { isShowingHint.toggle() }) {
                            Label("İpucu", systemImage: "lightbulb")
                                .font(.subheadline)
                        }
                        .buttonStyle(.bordered)
                    }
                    
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
                            // Karakterin adını ve yaşını tanımlayın
                            // Örnek:
                            // let characterName = "Ahmet";
                            // let characterAge = 25;

                            """
                            showCharacter = false
                            outputMessage = ""
                        }
                        .buttonStyle(SecondaryButtonStyle())
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .cornerRadius(12)
                .shadow(color: .gray.opacity(0.1), radius: 5)
                
                // Karakter görünümü
                if showCharacter {
                    VStack(spacing: 16) {
                        SuccessMessage()
                            .transition(AnyTransition.scale.combined(with: .opacity))
                        
                        CharacterView(name: characterName, age: characterAge)
                            .transition(AnyTransition.scale.combined(with: .opacity))
                        
                        // Sonraki göreve geçiş butonu
                        NavigationLink(destination: JsTreasureHuntView()) {
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
                    .padding()
                }
                
                // Hata mesajı
                if !outputMessage.isEmpty {
                    ErrorMessage(message: outputMessage)
                }
            }
            .padding()
        }
        .navigationTitle("Değişken Pratiği")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingHint) {
            HintView(isShowingHint: $isShowingHint)
        }
    }
    
    func runCode() {
        // Basit bir kod analizi
        let code = userCode.lowercased()
        
        // String değişken kontrolü
        if let nameRange = code.range(of: "let\\s+\\w+\\s*=\\s*[\"']([^\"']+)[\"']", options: .regularExpression) {
            let nameMatch = String(code[nameRange])
            if let nameValue = nameMatch.components(separatedBy: "=").last?
                .trimmingCharacters(in: .whitespaces)
                .trimmingCharacters(in: CharacterSet(charactersIn: "\"'")),
               !nameValue.isEmpty {
                characterName = nameValue
            }
        }
        
        // Number değişken kontrolü
        if let ageRange = code.range(of: "let\\s+\\w+\\s*=\\s*(\\d+)", options: .regularExpression) {
            let ageMatch = String(code[ageRange])
            if let ageStr = ageMatch.components(separatedBy: "=").last?
                .trimmingCharacters(in: .whitespaces),
               let age = Int(ageStr) {
                characterAge = age
            }
        }
        
        // Sonuç kontrolü
        if !characterName.isEmpty && characterAge > 0 {
            showCharacter = true
            outputMessage = ""
        } else {
            outputMessage = "Hata: Lütfen geçerli bir karakter adı ve yaşı tanımlayın."
            showCharacter = false
        }
    }
    
    private func getNextView() -> AnyView? {
        if progress.moveToNextTask() {
            switch progress.currentTask {
            case .treasureHunt:
                return AnyView(JsTreasureHuntView())
            case .temperatureConverter:
                return AnyView(JsTemperatureConverterView())
            case .currencyCalculator:
                return AnyView(JsCurrencyCalculatorView())
            case .ageCalculator:
                return AnyView(JsAgeCalculatorView())
            default:
                return nil
            }
        }
        return nil
    }
}

// Yardımcı görünümler
struct TaskCard: View {
    let title: String
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            
            Text(description)
                .lineSpacing(8)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.1), radius: 5)
    }
}

struct CodeEditor: View {
    @Binding var text: String
    
    var body: some View {
        TextEditor(text: $text)
            .font(.system(.body, design: .monospaced))
            .frame(height: 200)
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
    }
}

struct SuccessMessage: View {
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
            Text("Karakter Başarıyla Oluşturuldu!")
                .font(.headline)
                .foregroundColor(.green)
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(8)
    }
}

struct ErrorMessage: View {
    let message: String
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
            Text(message)
                .foregroundColor(.red)
        }
        .padding()
        .background(Color.red.opacity(0.1))
        .cornerRadius(8)
    }
}

struct HintView: View {
    @Binding var isShowingHint: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("İpuçları")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("1. String değişken tanımlama:")
                            .font(.headline)
                        Text("let isim = \"Ahmet\";")
                            .font(.system(.body, design: .monospaced))
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                        
                        Text("2. Number değişken tanımlama:")
                            .font(.headline)
                        Text("let yas = 25;")
                            .font(.system(.body, design: .monospaced))
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .navigationBarItems(trailing: Button("Kapat") {
                isShowingHint = false
            })
        }
    }
}

// Özel buton stilleri
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color.gray.opacity(0.1))
            .foregroundColor(.primary)
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct CharacterView: View {
    let name: String
    let age: Int
    @State private var isAnimating = false
    
    private var avatarColor: Color {
        if age < 18 {
            return Color(hex: "4299E1") // Genç - Mavi
        } else if age < 30 {
            return Color(hex: "48BB78") // Genç yetişkin - Yeşil
        } else if age < 50 {
            return Color(hex: "ED8936") // Orta yaş - Turuncu
        } else {
            return Color(hex: "9F7AEA") // Yaşlı - Mor
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                // Arka plan efekti
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [avatarColor.opacity(0.2), avatarColor.opacity(0.1)]),
                            center: .center,
                            startRadius: 50,
                            endRadius: 150
                        )
                    )
                    .frame(width: 250, height: 250)
                    .scaleEffect(isAnimating ? 1.1 : 1.0)
                
                // Minimalist Avatar
                VStack(spacing: 15) { // Baş ve vücut arasındaki boşluğu ayarladık
                    // Baş
                    Circle()
                        .fill(avatarColor)
                        .frame(width: 100, height: 100)
                        .overlay(
                            // Yüz özellikleri
                            VStack(spacing: 15) { // Göz ve ağız arasındaki mesafeyi artırdık
                                // Gözler
                                HStack(spacing: 25) { // Gözler arası mesafeyi artırdık
                                    // Sol göz
                                    ZStack {
                                        Circle()
                                            .fill(.white)
                                            .frame(width: 20, height: 20)
                                        Circle()
                                            .fill(.black)
                                            .frame(width: 10, height: 10)
                                    }
                                    
                                    // Sağ göz
                                    ZStack {
                                        Circle()
                                            .fill(.white)
                                            .frame(width: 20, height: 20)
                                        Circle()
                                            .fill(.black)
                                            .frame(width: 10, height: 10)
                                    }
                                }
                                .offset(y: 10) // Gözleri biraz aşağı indirdik
                                
                                // Gülümseme
                                Path { path in
                                    path.move(to: CGPoint(x: 25, y: 35))
                                    path.addQuadCurve(
                                        to: CGPoint(x: 75, y: 35),
                                        control: CGPoint(x: 50, y: 55)
                                    )
                                }
                                .stroke(Color.white, lineWidth: 4)
                                .offset(y: -5) // Gülümsemeyi biraz yukarı aldık
                            }
                        )
                    
                    // Vücut (boyun kaldırıldı)
                    Rectangle()
                        .fill(avatarColor)
                        .frame(width: 140, height: 120)
                        .cornerRadius(40, corners: [.bottomLeft, .bottomRight])
                        .overlay(
                            // Kıyafet detayları
                            VStack {
                                // Yaka çizgisi
                                Path { path in
                                    path.move(to: CGPoint(x: 40, y: 10))
                                    path.addLine(to: CGPoint(x: 100, y: 10))
                                }
                                .stroke(avatarColor.opacity(0.5), lineWidth: 3)
                                
                                // Düğmeler
                                VStack(spacing: 15) {
                                    Circle()
                                        .fill(avatarColor.opacity(0.5))
                                        .frame(width: 10, height: 10)
                                    Circle()
                                        .fill(avatarColor.opacity(0.5))
                                        .frame(width: 10, height: 10)
                                }
                                .padding(.top, 20)
                            }
                        )
                }
                .shadow(color: avatarColor.opacity(0.3), radius: 10, x: 0, y: 5)
                .offset(y: isAnimating ? -5 : 0)
            }
            
            // Karakter Bilgileri
            VStack(spacing: 8) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(avatarColor)
                
                Text("\(age) yaşında")
                    .font(.subheadline)
                    .foregroundColor(avatarColor.opacity(0.8))
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(color: avatarColor.opacity(0.2), radius: 5, x: 0, y: 2)
            )
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}

// Köşe yarıçapı için extension
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct JsVariablePracticeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JsVariablePracticeView()
        }
    }
} 
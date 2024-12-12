import SwiftUI
import ConfettiSwiftUI


struct FirstPartView: View {
    @State private var userInput: String = ""
    @State private var houseName: String = "Evin Adı"
    @State private var errorMessage: String? = nil
    @State private var confettiCounter: Int = 0
    @Binding var isFirstPartComplete: Bool
    var body: some View {
        ZStack {
            VStack {
                Text("Bölüm 1")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 20)

                Text("Görev: console.log kullanarak eve bir isim verin")
                    .font(.title2)
                    .foregroundColor(.gray)
                    .padding(.top, 10)

                Spacer()

                TextEditor(text: $userInput)
                    .frame(height: 150)
                    .border(Color.gray, width: 1)
                    .padding()
                    .autocapitalization(.none)
                    .keyboardType(.default)
                    .onAppear {
                        userInput = "console.log('')"
                    }

                ZStack {
                    Image(systemName: "house.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                        .foregroundColor(Color(red: 70/255, green: 115/255, blue: 161/255))

                    Text(houseName)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(8)
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(5)
                        .offset(y: -110)
                }
                .padding()

                Button(action: runFirstPartCode) {
                    Text("Çalıştır")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 236/255, green: 220/255, blue: 104/255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .padding()
                }

                Spacer()
            }

            ConfettiCannon(counter: $confettiCounter, num: 30, colors: [.red, .blue, .yellow, .green], confettiSize: 10)
        }
        .padding()
    }

    private func runFirstPartCode() {
        guard userInput.contains("console.log(") else {
            errorMessage = "Hata: Kodunuzda console.log() bulunamadı."
            return
        }

        let pattern = #"console\.log\(["'](.*?)["']\)"#
        if let regex = try? NSRegularExpression(pattern: pattern),
           let match = regex.firstMatch(in: userInput, range: NSRange(userInput.startIndex..., in: userInput)),
           let range = Range(match.range(at: 1), in: userInput) {
            houseName = String(userInput[range])
            errorMessage = nil
            confettiCounter += 1 // Konfeti patlat
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isFirstPartComplete = true
            }
        } else {
            errorMessage = "Hata: Lütfen doğru bir console.log() kullanın."
        }
    }
}

struct FirstPartView_Previews: PreviewProvider {
    static var previews: some View {
        FirstPartView(isFirstPartComplete: .constant(false))
    }
}


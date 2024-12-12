import SwiftUI
import ConfettiSwiftUI
import JavaScriptCore


struct SecondPartView: View {
    @Binding var isFirstPartComplete: Bool
    @Binding var isSecondPartComplete: Bool
    @State private var isSecondStageActive: Bool = false
    @State private var userInput: String = ""
    @State private var shoppingList: [String] = ["Elma", "Armut", "Portakal"]
    @State private var cleaningList: [String] = []
    @State private var errorMessage: String? = nil
    @State private var confettiCounter: Int = 0
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        isFirstPartComplete = false
                    }) {
                        HStack {
                            Image(systemName: "arrow.left")
                            Text("Geri")
                        }
                        .font(.headline)
                    }

                    Spacer()
                }
                .padding(.horizontal)

                Text("Bölüm 2")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)

                if !isSecondStageActive {
                    Text("1. Görev: Aşağıdaki alışveriş listesine array push kullanarak 'Mango' ekleyin.")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                } else {
                    Text("2. Görev: 'temizlik' adlı bir array oluşturun ve içine 'Deterjan', 'Sabun', 'Şampuan' ekleyin.")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                
                TextEditor(text: $userInput)
                    .frame(height: 150)
                    .border(Color.gray, width: 1)
                    .padding()
                    .autocapitalization(.none)
                    .keyboardType(.default)
                    .onAppear {
                        userInput = """
                        var meyveler = ["Elma", "Armut", "Portakal"];
                        meyveler.push('')
                        """
                    }
                
                VStack(alignment: .leading) {
                    if !isSecondStageActive {
                        Text("Alışveriş Listesi:")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                            .foregroundStyle(.white)

                        ForEach(shoppingList, id: \.self) { item in
                            Text("- \(item)")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    } else {
                        Text("Temizlik Listesi:")
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.bottom, 5)
                            .foregroundStyle(.white)

                        ForEach(cleaningList, id: \.self) { item in
                            Text("- \(item)")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(red: 70/255, green: 115/255, blue: 161/255))
                .cornerRadius(10)
                .frame(height: 200)
                .padding(.horizontal)

                Spacer()

                Button(action: runCode) {
                    Text("Çalıştır")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 236/255, green: 220/255, blue: 104/255))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)

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

    // Kod Çalıştırma
    private func runCode() {
        let context = JSContext()

        if !isSecondStageActive {
            context?.evaluateScript("""
            var meyveler = ["Elma", "Armut", "Portakal"];
            function pushToList(item) {
                meyveler.push(item);
                return meyveler;
            }
            """)
            context?.evaluateScript(userInput)

            if let meyveler = context?.objectForKeyedSubscript("meyveler"), meyveler.isArray {
                if let array = meyveler.toArray() as? [String] {
                    if array.contains("Mango") || array.contains("mango") {
                        shoppingList = array
                        errorMessage = nil
                        confettiCounter += 1

                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            isSecondStageActive = true
                            userInput = """
                            var temizlik = [];
                            temizlik.push("Şampuan")
                            temizlik.push("Sabun")
                            temizlik("Deterjan")
                            """
                        }
                    } else {
                        errorMessage = "Hata: Listeye 'Mango' eklenmedi."
                    }
                } else {
                    errorMessage = "Hata: Array içeriğini çözümleyemedik."
                }
            } else {
                errorMessage = "Hata: 'meyveler' array'i bulunamadı. Doğru tanımladığınızdan emin olun."
            }
        } else {
            context?.evaluateScript(userInput)

            if let temizlik = context?.objectForKeyedSubscript("temizlik"), temizlik.isArray {
                if let array = temizlik.toArray() as? [String] {
                    if array.contains("Deterjan") && array.contains("Sabun") && array.contains("Şampuan") {
                        cleaningList = array
                        errorMessage = nil
                        confettiCounter += 1
                    } else {
                        errorMessage = "Hata: Listeye 'Deterjan', 'Sabun' ve 'Şampuan' eklenmedi."
                    }
                } else {
                    errorMessage = "Hata: Array içeriğini çözümleyemedik."
                }
            } else {
                errorMessage = "Hata: 'temizlik' array'i bulunamadı. Doğru tanımladığınızdan emin olun."
            }
        }
    }
}

struct SecondPartView_Previews: PreviewProvider {
    static var previews: some View {
        SecondPartView(isFirstPartComplete: .constant(true), isSecondPartComplete: .constant(false))
    }
}


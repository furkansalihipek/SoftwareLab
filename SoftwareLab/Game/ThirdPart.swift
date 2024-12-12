import SwiftUI
import ConfettiSwiftUI
import JavaScriptCore


struct ThirdPartView: View {
    @Binding var isSecondPartComplete: Bool
    @State private var userInput: String = ""
    @State private var kitchenCabinet: [String] = []
    @State private var bathroomCabinet: [String] = []
    @State private var isSecondStageActive: Bool = false
    @State private var errorMessage: String? = nil
    @State private var confettiCounter: Int = 0

    let fruits = ["Elma", "Armut", "Portakal", "Mango"]
    let cleaningItems = ["Deterjan", "Sabun", "Şampuan"]

    var body: some View {
        ZStack {
            VStack {
                Text("Bölüm 3")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 10)

                if !isSecondStageActive {
                    Text("1. Görev: Aşağıdaki meyveleri for döngüsü kullanarak mutfaktaki dolaba yerleştirin.")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                } else {
                    Text("2. Görev: Temizlik malzemelerini for döngüsü ile banyodaki dolaba yerleştirin.")
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
                        userInput = isSecondStageActive
                            ? """
                              var temizlik = ["Deterjan", "Sabun", "Şampuan"];
                              """
                            : """
                              var meyveler = ["Elma", "Armut", "Portakal", "Mango"];
                              var dolap = []
                              """
                    }

                VStack(alignment: .leading) {
                    if !isSecondStageActive {
                        HStack {
                            Image(systemName: "archivebox.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.brown)

                            VStack(alignment: .leading) {
                                Text("Mutfak Dolabı:")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 5)
                                    .foregroundStyle(.white)

                                ForEach(kitchenCabinet, id: \.self) { item in
                                    HStack {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                        Text(item)
                                            .font(.headline)
                                    }
                                }
                            }
                        }
                    } else {
                        HStack {
                            Image(systemName: "tray.full.fill")
                                .resizable()
                                .frame(width: 100, height: 100)
                                .foregroundColor(.yellow)

                            VStack(alignment: .leading) {
                                Text("Banyo Dolabı:")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.bottom, 5)

                                ForEach(bathroomCabinet, id: \.self) { item in
                                    HStack {
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundColor(.green)
                                        Text(item)
                                            .font(.headline)
                                    }
                                }
                            }
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

            VStack {
                HStack {
                    Button(action: {
                        if isSecondStageActive {
                            isSecondStageActive = false
                            userInput = """
                            var meyveler = ["Elma", "Armut", "Portakal", "Mango"];
                            var dolap = [];
                            """
                            kitchenCabinet = []
                            errorMessage = nil
                        }
                    }) {
                        Image(systemName: "chevron.left.circle.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                    .padding()
                    Spacer()
                }
                Spacer()
            }

            ConfettiCannon(counter: $confettiCounter, num: 30, colors: [.red, .blue, .yellow, .green], confettiSize: 10)
        }
        .padding()
    }

    private func runCode() {
        let context = JSContext()

        if !isSecondStageActive {
            context?.evaluateScript("""
            var meyveler = ["Elma", "Armut", "Portakal", "Mango"];
            var dolap = [];
            \(userInput)
            """)
            if let dolap = context?.objectForKeyedSubscript("dolap"), dolap.isArray {
                if let array = dolap.toArray() as? [String], array == fruits {
                    kitchenCabinet = array
                    errorMessage = nil
                    confettiCounter += 1

                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        isSecondStageActive = true
                        userInput = """
                        var temizlik = ["Deterjan", "Sabun", "Şampuan"];
                        var dolap = [];
                        """
                    }
                } else {
                    errorMessage = "Hata: Meyveler doğru şekilde dolaba yerleştirilmedi."
                }
            } else {
                errorMessage = "Hata: 'dolap' array'i bulunamadı. Doğru tanımladığınızdan emin olun."
            }
        } else {
            context?.evaluateScript("""
            var temizlik = ["Deterjan", "Sabun", "Şampuan"];
            var dolap = [];
            \(userInput)
            """)
            if let dolap = context?.objectForKeyedSubscript("dolap"), dolap.isArray {
                if let array = dolap.toArray() as? [String], array == cleaningItems {
                    bathroomCabinet = array
                    errorMessage = nil
                    confettiCounter += 1
                } else {
                    errorMessage = "Hata: Temizlik malzemeleri doğru şekilde dolaba yerleştirilmedi."
                }
            } else {
                errorMessage = "Hata: 'dolap' array'i bulunamadı. Doğru tanımladığınızdan emin olun."
            }
        }
    }
}

struct ThirdPartView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdPartView(isSecondPartComplete: .constant(true))
    }
}


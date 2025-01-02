import SwiftUI

struct JsFunctionsPracticeView: View {
    @StateObject private var progress = LessonProgress()
    @State private var currentTask = 0
    @State private var userCode = """
    // 1. Görev için başlangıç kodu
    function sayHello(name) {
        // Kodunuzu buraya yazın
    }
    """
    @State private var outputMessage = ""
    @State private var isCompleted = false
    @State private var showResults = false
    
    let tasks = [
        TaskInfo(
            title: "Selamlama Fonksiyonu",
            description: "1. sayHello fonksiyonunu tamamlayın\n2. Parametre olarak isim alın\n3. 'Merhaba, {isim}!' şeklinde çıktı verin",
            startCode: """
            function sayHello(name) {
                // Çözüm:
                console.log("Merhaba, " + name + "!");
                
                // Kodunuzu buraya yazın
            }
            
            sayHello("Ahmet");
            """,
            expectedOutput: "Merhaba, Ahmet!"
        ),
        TaskInfo(
            title: "Yaş Hesaplama",
            description: "1. calculateAge fonksiyonunu yazın\n2. Doğum yılını parametre olarak alın\n3. Kişinin yaşını hesaplayıp döndürün",
            startCode: """
            function calculateAge(birthYear) {
                // Çözüm:
                return 2024 - birthYear;
                
                // Kodunuzu buraya yazın
            }
            
            let age = calculateAge(1990);
            console.log("Yaşınız: " + age);
            """,
            expectedOutput: "Yaşınız: 34"
        ),
        TaskInfo(
            title: "Not Hesaplama",
            description: "1. calculateGrade fonksiyonunu yazın\n2. Vize ve final notlarını parametre olarak alın\n3. Vize %40, final %60 olacak şekilde ortalamayı hesaplayın",
            startCode: """
            function calculateGrade(midterm, final) {
                // Çözüm:
                return midterm * 0.4 + final * 0.6;
                
                // Kodunuzu buraya yazın
            }
            
            let average = calculateGrade(80, 90);
            console.log("Ortalamanız: " + average);
            """,
            expectedOutput: "Ortalamanız: 86"
        ),
        TaskInfo(
            title: "Kelime İşleme",
            description: "1. processWord fonksiyonunu arrow function olarak yazın\n2. Bir kelimeyi parametre olarak alın\n3. Kelimenin ilk harfini büyük, diğerlerini küçük yapın",
            startCode: """
            const processWord = (word) => {
                // Çözüm:
                return word.charAt(0).toUpperCase() + word.slice(1).toLowerCase();
                
                // Kodunuzu buraya yazın
            }
            
            console.log(processWord("javaScript"));
            """,
            expectedOutput: "Javascript"
        ),
        TaskInfo(
            title: "Dizi İşlemleri",
            description: "1. processArray fonksiyonunu yazın\n2. Sayı dizisini parametre olarak alın\n3. Dizideki çift sayıları filtreleyin ve her elemanın karesini alın",
            startCode: """
            const processArray = (numbers) => {
                // Çözüm:
                return numbers.filter(num => num % 2 === 0).map(num => num * num);
                
                // Kodunuzu buraya yazın
            }
            
            let numbers = [1, 2, 3, 4, 5, 6];
            console.log(processArray(numbers));
            """,
            expectedOutput: "[4, 16, 36]"
        )
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                TaskCard(
                    title: tasks[currentTask].title,
                    description: tasks[currentTask].description
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
                            userCode = tasks[currentTask].startCode
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
                    if currentTask < tasks.count - 1 {
                        Button(action: {
                            currentTask += 1
                            userCode = tasks[currentTask].startCode
                            isCompleted = false
                            showResults = false
                        }) {
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
                    } else {
                        NavigationLink(destination: JavaScriptLessonsView()) {
                            HStack {
                                Image(systemName: "checkmark.circle.fill")
                                Text("Pratikleri Tamamla")
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
        .navigationTitle("Fonksiyon Pratikleri")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            userCode = tasks[currentTask].startCode
        }
    }
    
    private func runCode() {
        let jsCode = userCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        switch currentTask {
        case 0: // Selamlama Fonksiyonu
            if jsCode.contains("function sayHello(name)") &&
               jsCode.contains("console.log(\"Merhaba, \" + name + \"!\")") {
                outputMessage = "Tebrikler! Selamlama fonksiyonunu doğru yazdınız! 🎉\nÇıktı: Merhaba, Ahmet!"
                isCompleted = true
                if currentTask == tasks.count - 1 {
                    progress.moveToNextFunctionTask()
                }
            }
        case 1: // Yaş Hesaplama
            if jsCode.contains("function calculateAge(birthYear)") &&
               jsCode.contains("return 2024 - birthYear") {
                outputMessage = "Tebrikler! Yaş hesaplama fonksiyonunu doğru yazdınız! 🎉\nÇıktı: Yaşınız: 34"
                isCompleted = true
            }
        case 2: // Not Hesaplama
            if jsCode.contains("function calculateGrade(midterm, final)") &&
               jsCode.contains("return midterm * 0.4 + final * 0.6") {
                outputMessage = "Tebrikler! Not hesaplama fonksiyonunu doğru yazdınız! 🎉\nÇıktı: Ortalamanız: 86"
                isCompleted = true
            }
        case 3: // Kelime İşleme
            if jsCode.contains("const processWord = (word)") &&
               jsCode.contains("return word.charAt(0).toUpperCase() + word.slice(1).toLowerCase()") {
                outputMessage = "Tebrikler! Kelime işleme fonksiyonunu doğru yazdınız! 🎉\nÇıktı: Javascript"
                isCompleted = true
            }
        case 4: // Dizi İşlemleri
            if jsCode.contains("const processArray = (numbers)") &&
               jsCode.contains("filter") && jsCode.contains("map") &&
               jsCode.contains("% 2 === 0") {
                outputMessage = "Tebrikler! Dizi işleme fonksiyonunu doğru yazdınız! 🎉\nÇıktı: [4, 16, 36]"
                isCompleted = true
            }
        default:
            outputMessage = "Fonksiyon yapısı hatalı. Tekrar deneyin!"
            isCompleted = false
        }
        showResults = true
    }
}

struct TaskInfo {
    let title: String
    let description: String
    let startCode: String
    let expectedOutput: String
}

struct JsFunctionsPracticeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JsFunctionsPracticeView()
        }
    }
} 
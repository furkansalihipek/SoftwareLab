import SwiftUI

struct Js_Inspect: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // Başlık
                VStack(spacing: 10) {
                    Text("Neler Öğreneceğiz?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    Text("Hayalinizdeki web projelerini yapabilmek için ihtiyacınız olan tüm temel JavaScript bilgilerini öğreneceksiniz! Bu kursla, sıfırdan başlayarak değişkenler, fonksiyonlar, diziler, DOM manipülasyonu ve asenkron JavaScript gibi temel konuları kolayca kavrayacak, interaktif web uygulamaları geliştirebileceksiniz.🚀\n\nNeden Bu Kurs?\n\n- Hızlıca projeler yaparak öğrenin.\n- Temel JavaScript bilgileriyle güçlü bir altyapı oluşturun.\n- Pratik örneklerle hemen başlayın!\n\nHazır mısınız? Hadi, JavaScript dünyasına adım atın ve web geliştirme yolculuğunuzda bir adım öne geçin! 🌟")
                        .font(.body)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.blue.opacity(0.05))
                        .cornerRadius(12)
                        .padding(.horizontal)
                }

                // Bölümler (Accordion Yapı)
                VStack(spacing: 20) {
                    Js_AccordionView(title: "JavaScript'e Giriş", items: [
                        "JavaScript Nedir?",
                        "\"Hello World\" Kodu"
                    ])

                    Js_AccordionView(title: "Değişkenler ve Veri Türleri", items: [
                        "`var`, `let`, `const`",
                        "Sayılar, Stringler, Boolean"
                    ])

                    Js_AccordionView(title: "Operatörler", items: [
                        "Aritmetik, Karşılaştırma ve Mantıksal Operatörler"
                    ])

                    Js_AccordionView(title: "Koşul İfadeleri", items: [
                        "`if`, `else`, `switch`"
                    ])

                    Js_AccordionView(title: "Döngüler", items: [
                        "`for`, `while`"
                    ])

                    Js_AccordionView(title: "Fonksiyonlar", items: [
                        "Fonksiyon Tanımlama ve Kullanma"
                    ])

                    Js_AccordionView(title: "Diziler (Arrays)", items: [
                        "Dizi Tanımlama, Elemanlara Erişim"
                    ])

                    Js_AccordionView(title: "Nesneler (Objects)", items: [
                        "Nesne Tanımlama ve Özelliklere Erişim"
                    ])

                    Js_AccordionView(title: "DOM Manipülasyonu", items: [
                        "HTML Elemanlarına Erişim ve Değiştirme"
                    ])

                    Js_AccordionView(title: "Olaylar (Events)", items: [
                        "`click`, `mouseover`, vb. Olay Dinleyicileri"
                    ])

                    Js_AccordionView(title: "Temel Hata Yönetimi", items: [
                        "`try...catch` ile Hata Yakalama"
                    ])

                    Js_AccordionView(title: "Asenkron JavaScript", items: [
                        "`setTimeout()`, `setInterval()`"
                    ])

                    Js_AccordionView(title: "JSON", items: [
                        "JSON Verisi ile Çalışma (`JSON.parse()`, `JSON.stringify()`)"])
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top)
        }
    }
}

struct Js_AccordionView: View {
    let title: String
    let items: [String]

    @State private var isExpanded: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Button(action: {
                withAnimation {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .background(Color.blue.opacity(0.1))
            .cornerRadius(12)

            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(items, id: \ .self) { item in
                        Text("• " + item)
                            .font(.body)
                            .foregroundColor(.black)
                            .padding(.leading, 5)
                    }
                }
                .padding(12)
                .cornerRadius(12)
                .shadow(color: Color.gray.opacity(0.2), radius: 8, x: 0, y: 2)
            }
        }
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}

struct Js_Inspect_Previews: PreviewProvider {
    static var previews: some View {
        Js_Inspect()
    }
}

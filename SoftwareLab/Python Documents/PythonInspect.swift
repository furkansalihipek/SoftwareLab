import SwiftUI

struct PythonInspect: View {
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

                    Text("Hayalinizdeki projeleri geliştirmek için ihtiyaç duyduğunuz temel Python bilgilerini bu kursta öğreneceksiniz! Sıfırdan başlayarak değişkenler, fonksiyonlar, diziler, koşul ifadeleri ve döngüler gibi temel konuları öğrenip, Python ile güçlü projeler yapmaya başlayacaksınız.\n\nNeden Bu Kurs?\n\n- Pratik örneklerle öğrenin, hemen projelere başlayın.\n- Python’un temellerini kolayca kavrayın.\n- Web geliştirme, veri analizi ve daha fazlası için güçlü bir altyapı kazanın.\n\nHazır mısınız? Python dünyasına adım atın ve programlama yolculuğunuzda bir adım öne geçin! 🌟")
                        .font(.body)
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.blue.opacity(0.05))
                        .cornerRadius(12)
                        .padding(.horizontal)
                }

                // Bölümler (Accordion Yapı)
                VStack(spacing: 20) {
                    Py_AccordionView(title: "Python'a Giriş", items: [
                        "Python Nedir? (Temel Tanım)",
                        "Python ile \"Hello World\" Kodu",
                        "Python Kurulumu ve Çalıştırma Ortamı"
                    ])

                    Py_AccordionView(title: "Değişkenler ve Veri Türleri", items: [
                        "Değişken Tanımlama",
                        "Sayılar (int, float)",
                        "Metinler (Strings)",
                        "Boolean (True/False)",
                        "Tip Dönüşümü (Type Conversion)"
                    ])

                    Py_AccordionView(title: "Operatörler", items: [
                        "Aritmetik Operatörler (+, -, *, /)",
                        "Karşılaştırma Operatörleri (==, !=, <, >)",
                        "Mantıksal Operatörler (and, or, not)"
                    ])

                    Py_AccordionView(title: "Koşul İfadeleri (Conditionals)", items: [
                        "if, else, elif Kullanımı",
                        "Mantıksal Koşullar ile Karar Verme"
                    ])

                    Py_AccordionView(title: "Döngüler (Loops)", items: [
                        "for Döngüsü",
                        "while Döngüsü",
                        "break, continue ve else Döngüleri"
                    ])

                    Py_AccordionView(title: "Fonksiyonlar", items: [
                        "Fonksiyon Tanımlama ve Çağırma",
                        "Parametreler ve Geri Dönüş Değerleri",
                        "Lambda Fonksiyonları (Kısa Fonksiyonlar)"
                    ])

                    Py_AccordionView(title: "Veri Yapıları", items: [
                        "Listeler (Lists)",
                        "Demetler (Tuples)",
                        "Sözlükler (Dictionaries)",
                        "Kümeler (Sets)"
                    ])

                    Py_AccordionView(title: "Diziler ve Koleksiyonlar", items: [
                        "Listelerde Eleman İşlemleri (Ekleme, Silme, Arama)",
                        "Listelerde Slicing ve Indexing",
                        "range() Fonksiyonu ile Liste Üzerinde Döngüler"
                    ])

                    Py_AccordionView(title: "Dosya İşlemleri", items: [
                        "Dosya Açma, Okuma ve Yazma",
                        "Dosya Kapatma ve Yönetme"
                    ])

                    Py_AccordionView(title: "Hata Yönetimi (Error Handling)", items: [
                        "try, except, finally Blokları",
                        "Hatalarla Baş Etme"
                    ])

                    Py_AccordionView(title: "Modüller ve Kütüphaneler", items: [
                        "Python Modülleri Nedir? Nasıl Kullanılır?",
                        "Python Standart Kütüphaneleri",
                        "Örnek Modüller: math, random, time"
                    ])

                    Py_AccordionView(title: "Temel Veri Analizi", items: [
                        "Python ile Basit Hesaplamalar",
                        "Veri Manipülasyonu: Sayılar, Listeler ve Diziler"
                    ])
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding(.top)
        }
    }
}

struct Py_AccordionView: View {
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

struct PyhonInspect_Previews: PreviewProvider {
    static var previews: some View {
        PythonInspect()
    }
}


import SwiftUI

struct JavaScriptLessonsView: View {
    @State private var completedLessons: Set<String> = []
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Başlık ve Açıklama
                VStack(alignment: .leading, spacing: 10) {
                    Text("JavaScript Dersleri")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Web geliştirmenin temellerini öğrenin")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                
                // Dersler Listesi
                LazyVStack(spacing: 15) {
                    JsLessonCard(
                        title: "JavaScript'e Giriş",
                        description: "JavaScript'in temellerini ve tarihçesini öğrenin",
                        duration: "15 dakika",
                        completedLessons: $completedLessons
                    )
                    
                    JsLessonCard(
                        title: "Değişkenler ve Veri Tipleri",
                        description: "let, const, var ve temel veri tiplerini keşfedin",
                        duration: "25 dakika",
                        completedLessons: $completedLessons
                    )
                    
                    JsLessonCard(
                        title: "Operatörler ve Koşullar",
                        description: "Matematiksel ve mantıksal operatörleri öğrenin",
                        duration: "20 dakika",
                        completedLessons: $completedLessons
                    )
                    
                    JsLessonCard(
                        title: "Döngüler",
                        description: "for, while ve do-while döngülerini kullanın",
                        duration: "30 dakika",
                        completedLessons: $completedLessons
                    )
                    
                    JsLessonCard(
                        title: "Fonksiyonlar",
                        description: "Fonksiyon tanımlama ve kullanma",
                        duration: "35 dakika",
                        completedLessons: $completedLessons
                    )
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
    }
}

struct JsLessonCard: View {
    let title: String
    let description: String
    let duration: String
    @Binding var completedLessons: Set<String>
    
    var isCompleted: Bool {
        completedLessons.contains(title)
    }
    
    var body: some View {
        NavigationLink(destination: JsLessonDetailView(title: title, completedLessons: $completedLessons)) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Text(description)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                    }
                    
                    Spacer()
                    
                    Image(systemName: isCompleted ? "checkmark.circle.fill" : "circle")
                        .foregroundColor(isCompleted ? .green : .gray)
                }
                
                HStack {
                    Image(systemName: "clock")
                        .foregroundColor(.blue)
                    Text(duration)
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(10)
            .shadow(radius: 2)
        }
    }
}

struct JsLessonDetailView: View {
    let title: String
    @Binding var completedLessons: Set<String>
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color(hex: "2D3748"))
                    .padding()
                
                if title == "JavaScript'e Giriş" {
                    VStack(alignment: .leading, spacing: 16) {
                        // Tarihçe Bölümü
                        Group {
                            LessonSectionTitle(title: "1. JavaScript'in Tarihçesi")
                            
                            LessonContentText(text: "JavaScript, 1995 yılında Brendan Eich tarafından geliştirildi. İlk olarak Mocha adıyla başlatılan bu dil, daha sonra LiveScript ve en sonunda JavaScript adını aldı. Adı Java ile benzer olsa da, bu iki dil tamamen farklıdır.\n\n1997 yılında JavaScript, ECMAScript standardına dahil edildi. Bu standart, dilin gelişimi için bir rehber oldu. Özellikle 2015'te çıkan ES6 ile birlikte, modern JavaScript'in temelleri atıldı. Bugün, web geliştirme başta olmak üzere birçok alanda kullanılıyor.")
                        }
                        
                        // Syntax Bölümü
                        Group {
                            LessonSectionTitle(title: "2. JavaScript'in Temel Syntax'ı")
                            
                            LessonContentText(text: "JavaScript, basit ve esnek bir syntax sunar. Kod yazımı HTML sayfalarıyla kolayca entegre edilebilir.")
                            
                            // 2.1 Değişken Tanımlama
                            Text("2.1 Değişken Tanımlama")
                                .font(.headline)
                                .foregroundColor(Color(hex: "4A5568"))
                                .padding(.horizontal)
                                .padding(.top, 8)
                            
                            LessonContentText(text: "JavaScript'te değişkenler let, const ve var anahtar kelimeleriyle tanımlanır.")
                            
                            CodeBlockView(code: """
                            let isim = "Ahmet";    // Değişebilir değer
                            const yas = 25;        // Sabit değer
                            var sehir = "Ankara";  // Eski yöntem
                            """)
                                .padding(.vertical, 8)
                            
                            // 2.2 Veri Tipleri
                            Text("2.2 Veri Tipleri")
                                .font(.headline)
                                .foregroundColor(Color(hex: "4A5568"))
                                .padding(.horizontal)
                                .padding(.top, 8)
                            
                            LessonContentText(text: "JavaScript'te yaygın olarak kullanılan veri tipleri:")
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("• String: Metin verileri")
                                Text("• Number: Sayılar")
                                Text("• Boolean: Doğruluk değeri")
                                Text("• Array: Liste yapıları")
                                Text("• Object: Nesne yapıları")
                            }
                            .padding(.horizontal)
                            .foregroundColor(Color(hex: "4A5568"))
                            
                            CodeBlockView(code: """
                            let metin = "JavaScript";       // String
                            let sayi = 42;                  // Number
                            let dogruMu = true;             // Boolean
                            let liste = ["Elma", "Armut"];  // Array
                            let nesne = {                   // Object
                                isim: "Ahmet",
                                yas: 30
                            };
                            """)
                                .padding(.vertical, 8)
                            
                            // 2.3 Fonksiyonlar
                            Text("2.3 Fonksiyonlar")
                                .font(.headline)
                                .foregroundColor(Color(hex: "4A5568"))
                                .padding(.horizontal)
                                .padding(.top, 8)
                            
                            LessonContentText(text: "Fonksiyonlar, belirli bir işlemi tanımlamak ve tekrar kullanmak için yazılır.")
                            
                            CodeBlockView(code: """
                            // Fonksiyon tanımlama
                            function topla(a, b) {
                                return a + b;
                            }
                            
                            // Fonksiyon kullanımı
                            console.log(topla(5, 3));  // Çıktı: 8
                            """)
                                .padding(.vertical, 8)
                            
                            // 2.4 Koşullar
                            Text("2.4 Koşullar")
                                .font(.headline)
                                .foregroundColor(Color(hex: "4A5568"))
                                .padding(.horizontal)
                                .padding(.top, 8)
                            
                            LessonContentText(text: "Koşullar, belirli bir durumun kontrol edilmesini sağlar.")
                            
                            CodeBlockView(code: """
                            let yas = 18;
                            
                            if (yas >= 18) {
                                console.log("Erişime izin verildi.");
                            } else {
                                console.log("Erişime izin verilmedi.");
                            }
                            """)
                                .padding(.vertical, 8)
                        }
                        
                        // Özet ve İpuçları
                        Group {
                            LessonSectionTitle(title: "3. Özet ve İpuçları")
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("🔑 Önemli Noktalar")
                                    .font(.headline)
                                    .foregroundColor(Color(hex: "2C5282"))
                                
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("• JavaScript case-sensitive bir dildir (büyük-küçük harf duyarlı)")
                                    Text("• Her ifade sonunda noktalı virgül (;) kullanılması önerilir")
                                    Text("• Kodları düzenli yazmak okunabilirliği artırır")
                                    Text("• console.log() ile debug yapabilirsiniz")
                                }
                                .foregroundColor(Color(hex: "4A5568"))
                            }
                            .padding()
                            .background(Color(hex: "EDF2F7"))
                            .cornerRadius(12)
                        }
                        
                        // Son Not
                        VStack(alignment: .leading, spacing: 10) {
                            Text("📝 Not")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text("Burada ki amacımız javascript'e karşı önbilgi ve göz aşinalığı kazanmanız. Burada gördüğünüz örnekleri şimdi anlamadıysanız hiç sorun değil, ilerleyen derslerde bu konuları tümünü detaylıca işleyeceğiz.")
                                .foregroundColor(.white)
                                .lineSpacing(6)
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(hex: "4299E1"))
                        )
                        .padding()

                        // Tamamla butonu
                        Button(action: {
                            completedLessons.insert(title)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            HStack {
                                Image(systemName: completedLessons.contains(title) ? "checkmark.circle.fill" : "play.circle.fill")
                                Text(completedLessons.contains(title) ? "Tamamlandı" : "Dersi Tamamla")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(completedLessons.contains(title) ? Color.green : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .disabled(completedLessons.contains(title))
                        .padding(.top, 20)
                        .padding(.horizontal, 15)
                    }
                    .padding(.bottom, 40)
                } else if title == "Değişkenler ve Veri Tipleri" {
                    VStack(alignment: .leading, spacing: 16) {
                        // Başlık
                        Text("1. JavaScript'te Değişkenler ve Veri Tipleri")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom, 8)
                        
                        // 1.1 Değişkenler
                        Group {
                            LessonSectionTitle(title: "1.1 Değişkenler")
                            
                            LessonContentText(text: "JavaScript'te değişkenler veriyi depolamak için kullanılır. Önceleri sadece var kullanılırken, modern JavaScript ile birlikte let ve const da eklenmiştir:")
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("• let: Blok seviyesinde kapsam sunar ve değeri değiştirilebilir.")
                                Text("• const: Sabit değerler için kullanılır, bir kez atandıktan sonra değiştirilemez.")
                                Text("• var: Fonksiyon seviyesinde kapsam sunar ve modern projelerde artık pek tercih edilmez.")
                            }
                            .foregroundColor(Color(hex: "4A5568"))
                            
                            CodeBlockView(code: """
                            let yas = 30; // Değiştirilebilir
                            const dogumYili = 1993; // Sabit değer
                            var meslek = "Mühendis"; // Eski yöntem

                            // let ile tanımlanan değişkeni güncelleme
                            yas = 31;
                            console.log(yas); // 31

                            // const ile tanımlanan değişkeni güncellemeye çalışma (Hata verir)
                            dogumYili = 1994; // TypeError: Assignment to constant variable.
                            """)
                        }
                        
                        // 1.2 Veri Tipleri
                        Group {
                            LessonSectionTitle(title: "1.2 Veri Tipleri")
                            
                            LessonContentText(text: "JavaScript'te veri tipleri ikiye ayrılır: ilkel (primitive) ve referans (non-primitive).")
                            
                            // 1.2.1 İlkel Veri Tipleri
                            Text("1.2.1 İlkel Veri Tipleri")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Group {
                                    Text("1. String: Metinsel veriler")
                                    CodeBlockView(code: """
                                    let isim = "Ahmet";
                                    console.log(isim); // "Ahmet"
                                    """)
                                }
                                
                                Group {
                                    Text("2. Number: Sayılar")
                                    CodeBlockView(code: """
                                    let yas = 25;
                                    let pi = 3.14;
                                    console.log(yas, pi); // 25, 3.14
                                    """)
                                }
                                
                                Group {
                                    Text("3. Boolean: Mantıksal değerler")
                                    CodeBlockView(code: """
                                    let dogruMu = true;
                                    let yanlisMi = false;
                                    """)
                                }
                                
                                Group {
                                    Text("4. Undefined ve Null")
                                    CodeBlockView(code: """
                                    let tanimsiz;
                                    console.log(tanimsiz); // undefined
                                    
                                    let bosDeger = null;
                                    console.log(bosDeger); // null
                                    """)
                                }
                            }
                            
                            // 1.2.2 Referans Veri Tipleri
                            Text("1.2.2 Referans Veri Tipleri")
                                .font(.headline)
                                .padding(.top, 16)
                            
                            VStack(alignment: .leading, spacing: 16) {
                                Group {
                                    Text("1. Object: Anahtar-değer çiftleri")
                                    CodeBlockView(code: """
                                    let kisi = {
                                      isim: "Ahmet",
                                      yas: 30,
                                    };
                                    console.log(kisi.isim); // "Ahmet"
                                    """)
                                }
                                
                                Group {
                                    Text("2. Array: Sıralı veri koleksiyonları")
                                    CodeBlockView(code: """
                                    let meyveler = ["Elma", "Armut", "Muz"];
                                    console.log(meyveler[0]); // "Elma"
                                    """)
                                }
                            }
                        }
                        
                        // 1.3 Tip Kontrolü
                        Group {
                            LessonSectionTitle(title: "1.3 Tip Kontrolü")
                            
                            LessonContentText(text: "JavaScript'te bir değişkenin tipi typeof operatörü ile kontrol edilebilir:")
                            
                            CodeBlockView(code: """
                            let metin = "Merhaba";
                            console.log(typeof metin); // "string"

                            let sayi = 42;
                            console.log(typeof sayi); // "number"

                            let bos = null;
                            console.log(typeof bos); // "object" (JavaScript'te bilinen bir tutarsızlık)
                            """)
                        }
                        
                        // Özet bölümünden önce pratik butonu ekle
                        Button(action: {}) {
                            NavigationLink(destination: JsVariablePracticeView()) {
                                HStack {
                                    Image(systemName: "gamecontroller.fill")
                                        .foregroundColor(.white)
                                    Text("Pratik Yap")
                                        .fontWeight(.semibold)
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.blue)
                                )
                            }
                        }
                        .padding(.top, 20)

                        // Özet bölümü
                        VStack(alignment: .leading, spacing: 12) {
                            Text("🔑 Önemli Noktalar")
                                .font(.headline)
                                .foregroundColor(Color(hex: "2C5282"))
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("• Değişkenler let, const ve var ile tanımlanır")
                                Text("• İlkel veri tipleri: string, number, boolean, undefined, null")
                                Text("• Referans tipleri: object, array, function")
                                Text("• typeof operatörü ile tip kontrolü yapılabilir")
                            }
                            .foregroundColor(Color(hex: "4A5568"))
                        }
                        .padding()
                        .background(Color(hex: "EDF2F7"))
                        .cornerRadius(12)
                    }
                    .padding(.bottom, 40)
                    .padding(.horizontal)
                } else if title == "Operatörler ve Koşullar" {
                    VStack(alignment: .leading, spacing: 16) {
                        // 1. Operatörler Bölümü
                        Group {
                            LessonSectionTitle(title: "1. Operatörler")
                            
                            LessonContentText(text: "JavaScript'te operatörler, değişkenlerle işlemler yapmak için kullanılır. Operatörler birkaç kategoriye ayrılır:")
                            
                            // 1.1 Atama Operatörleri
                            Text("1.1 Atama Operatörleri")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            LessonContentText(text: "Atama operatörleri bir değişkene değer atamak için kullanılır.")
                            
                            CodeBlockView(code: """
                            let x = 10;     // Basit atama
                            x += 5;         // x = x + 5
                            x -= 3;         // x = x - 3
                            x *= 2;         // x = x * 2
                            x /= 2;         // x = x / 2
                            """)
                            
                            // 1.2 Aritmetik Operatörler
                            Text("1.2 Aritmetik Operatörler")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            CodeBlockView(code: """
                            5 + 3    // 8  (Toplama)
                            5 - 3    // 2  (Çıkarma)
                            5 * 3    // 15 (Çarpma)
                            6 / 3    // 2  (Bölme)
                            5 % 2    // 1  (Mod)
                            2 ** 3   // 8  (Üs alma)
                            """)
                        }
                        
                        // 1.3 Karşılaştırma Operatörleri
                        Group {
                            Text("1.3 Karşılaştırma Operatörleri")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            CodeBlockView(code: """
                            5 == "5"   // true  (Değer eşitliği)
                            5 === "5"  // false (Tip ve değer eşitliği)
                            5 < 10     // true  (Küçüktür)
                            5 <= 5     // true  (Küçük eşittir)
                            10 > 5     // true  (Büyüktür)
                            """)
                        }
                        
                        // 2. Koşullar Bölümü
                        Group {
                            LessonSectionTitle(title: "2. Koşullar")
                            
                            LessonContentText(text: "JavaScript'te koşullar, belirli bir koşula göre farklı kodlar çalıştırmanızı sağlar.")
                            
                            CodeBlockView(code: """
                            let not = 85;
                            
                            if (not >= 90) {
                                console.log("Harika!");
                            } else if (not >= 50) {
                                console.log("Geçtiniz");
                            } else {
                                console.log("Kaldınız");
                            }
                            """)
                        }
                        
                        // Pratik butonu
                        NavigationLink(destination: JsOperatorsPracticeView()) {
                            HStack {
                                Image(systemName: "gamecontroller.fill")
                                Text("Pratik Yap")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding(.top, 20)
                    }
                    .padding()
                } else if title == "Döngüler" {
                    VStack(alignment: .leading, spacing: 16) {
                        // 1. Döngüler Nedir?
                        Group {
                            LessonSectionTitle(title: "1. Döngüler Nedir?")
                            
                            LessonContentText(text: "Döngüler, bir kod bloğunu birden fazla kez çalıştırmak için kullanılır. Belirli bir koşul doğru olduğu sürece, döngü içindeki kodlar çalışmaya devam eder.")
                            
                            Text("Neden Döngüler Kullanılır?")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            LessonContentText(text: """
                            • Tekrarlayan işleri otomatikleştirmek için
                            • Veri setleri üzerinde işlem yapmak için
                            • Kodun daha az yer kaplaması ve okunabilirliğinin artması için
                            """)
                        }
                        
                        // 2. Döngü Türleri
                        Group {
                            LessonSectionTitle(title: "2. JavaScript'te Döngülerin Türleri")
                            
                            Text("2.1 for Döngüsü")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            LessonContentText(text: "for döngüsü, sabit bir sayıda tekrar eden işlemler için kullanılır.")
                            
                            CodeBlockView(code: """
                            for (let i = 1; i <= 5; i++) {
                                console.log("Adım: " + i);
                            }
                            """)
                            
                            Text("2.2 while Döngüsü")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            CodeBlockView(code: """
                            let sayac = 1;
                            while (sayac <= 5) {
                                console.log("Sayı: " + sayac);
                                sayac++;
                            }
                            """)
                            
                            Text("2.3 do...while Döngüsü")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            CodeBlockView(code: """
                            do {
                                console.log("Sayı: " + sayac);
                                sayac++;
                            } while (sayac <= 5);
                            """)
                        }
                        
                        // 3. Döngü Kontrolleri
                        Group {
                            LessonSectionTitle(title: "3. Döngülerle İlgili Kontrol Mekanizmaları")
                            
                            Text("break ve continue")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            CodeBlockView(code: """
                            // break örneği
                            for (let i = 1; i <= 10; i++) {
                                if (i === 5) break;
                                console.log(i);
                            }

                            // continue örneği
                            for (let i = 1; i <= 5; i++) {
                                if (i === 3) continue;
                                console.log(i);
                            }
                            """)
                        }
                        
                        // Pratik butonu
                        NavigationLink(destination: JsLoopsPracticeView()) {
                            HStack {
                                Image(systemName: "gamecontroller.fill")
                                Text("Pratik Yap")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding(.top, 20)
                    }
                    .padding()
                } else if title == "Fonksiyonlar" {
                    VStack(alignment: .leading, spacing: 16) {
                        // 1. Fonksiyon Nedir?
                        Group {
                            LessonSectionTitle(title: "1. Fonksiyon Nedir?")
                            
                            LessonContentText(text: "Fonksiyonlar, bir işlemi gerçekleştirmek için birden fazla kod satırını bir araya getiren, tekrar kullanılabilir yapılardır.")
                            
                            Text("Fonksiyonların Avantajları:")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            LessonContentText(text: """
                            • Kodun tekrarını azaltır
                            • Okunabilirliği ve bakım kolaylığını artırır
                            • Daha düzenli ve modüler bir kod yapısı sağlar
                            """)
                        }
                        
                        // 2. Fonksiyon Tanımlama Yöntemleri
                        Group {
                            LessonSectionTitle(title: "2. Fonksiyon Tanımlama Yöntemleri")
                            
                            Text("2.1 Fonksiyon Bildirimi")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            CodeBlockView(code: """
                            function topla(a, b) {
                                return a + b;
                            }
                            
                            console.log(topla(5, 3)); // Çıktı: 8
                            """)
                            
                            Text("2.2 Fonksiyon İfadesi")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            CodeBlockView(code: """
                            const carp = function(a, b) {
                                return a * b;
                            };
                            
                            console.log(carp(4, 2)); // Çıktı: 8
                            """)
                            
                            Text("2.3 Ok Fonksiyonları")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            CodeBlockView(code: """
                            const cikarma = (a, b) => a - b;
                            
                            console.log(cikarma(10, 3)); // Çıktı: 7
                            """)
                        }
                        
                        // 3. Parametreler ve Return
                        Group {
                            LessonSectionTitle(title: "3. Parametreler ve Return")
                            
                            Text("3.1 Varsayılan Parametreler")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            CodeBlockView(code: """
                            function selamla(isim = "Misafir") {
                                console.log("Merhaba, " + isim);
                            }
                            
                            selamla(); // Çıktı: Merhaba, Misafir
                            selamla("Ali"); // Çıktı: Merhaba, Ali
                            """)
                            
                            Text("3.2 Return Kullanımı")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            CodeBlockView(code: """
                            function kareAl(sayi) {
                                return sayi * sayi;
                            }
                            
                            let sonuc = kareAl(4);
                            console.log(sonuc); // Çıktı: 16
                            """)
                        }
                        
                        // 4. İleri Seviye Konular
                        Group {
                            LessonSectionTitle(title: "4. İleri Seviye Konular")
                            
                            Text("4.1 Callback Fonksiyonlar")
                                .font(.headline)
                                .padding(.top, 8)
                            
                            CodeBlockView(code: """
                            function islemYap(sayi1, sayi2, islem) {
                                return islem(sayi1, sayi2);
                            }
                            
                            const topla = (a, b) => a + b;
                            console.log(islemYap(3, 4, topla)); // Çıktı: 7
                            """)
                        }
                        
                        // Pratik butonu
                        NavigationLink(destination: JsFunctionsPracticeView()) {
                            HStack {
                                Image(systemName: "gamecontroller.fill")
                                Text("Pratik Yap")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding(.top, 20)
                    }
                    .padding()
                } else {
                    Text("Bu dersin içeriği yakında eklenecek...")
                        .padding()
                }
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Kod bloklarını göstermek için yardımcı view
struct CodeBlockView: View {
    let code: String
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Rectangle()
                    .fill(Color(hex: "343942"))
                    .frame(width: 3)
                    .padding(.vertical, 8)
                
                Text(code)
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(Color(hex: "ABB2BF")) // Varsayılan metin rengi
                    .padding()
                    .lineSpacing(8)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(hex: "282C34"))
                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
        )
        .padding(.horizontal)
    }
}

// Renk uzantısı
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

// Ders içeriği için özel stil
struct LessonContentText: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(.body))
            .lineSpacing(8)
            .padding(.horizontal)
            .foregroundColor(Color(hex: "333333"))
    }
}

// Başlık stili
struct LessonSectionTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(Color(hex: "2C5282")) // Koyu mavi
            .padding(.top, 20)
            .padding(.horizontal)
    }
}

struct PracticeRow: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 2)
    }
}

struct JavaScriptLessonsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            JavaScriptLessonsView()
        }
    }
} 

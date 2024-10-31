import SwiftUI

struct FeaturedView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Öne Çıkanlar")
                    .font(.largeTitle)
                    .bold()
                    .padding()

                Text("Sıfırdan İleri Düzey JavaScript")
                    .font(.title2)
                    .padding(.leading)

                Image("featuredImage") // Resim eklemek için
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                
                Text("Kursu İncele")
                    .font(.title3)
                    .padding(.leading)

                // Kurslar bölümü
                VStack(alignment: .leading) {
                    Text("JavaScript")
                        .font(.title)
                        .bold()

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            CourseCardView(title: "JavaScript'e Başlangıç", imageName: "jsBeginner")
                            CourseCardView(title: "İleri Seviye JavaScript", imageName: "jsAdvanced")
                        }
                    }
                }
                .padding(.leading)

                // Python kursları
                VStack(alignment: .leading) {
                    Text("Python")
                        .font(.title)
                        .bold()

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            CourseCardView(title: "Python'a Başlangıç", imageName: "pythonBeginner")
                            CourseCardView(title: "İleri Seviye Python", imageName: "pythonAdvanced")
                        }
                    }
                }
                .padding(.leading)
            }
        }
    }
}

struct CourseCardView: View {
    var title: String
    var imageName: String

    var body: some View {
        VStack {
            Image(imageName) // Görselin adını burada belirtin
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .cornerRadius(10)

            Text(title)
                .font(.headline)
                .padding(.top, 5)
            
            Button(action: {
                // Kursu incele butonuna tıklanma olayı
            }) {
                Text("Kursu İncele")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            .padding(.top, 5)
        }
        .frame(width: 160)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

#Preview {
    FeaturedView()
}


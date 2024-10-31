import SwiftUI

struct CourseDetailView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("JavaScript'e Başlangıç")
                    .font(.largeTitle)
                    .bold()
                    .padding()

                Text("Önizleme")
                    .font(.title2)
                    .padding(.leading)

                Image("js_banner")
                    .resizable()
                    .aspectRatio(4/3, contentMode: .fill)
                    .frame(height: 200)
                    .clipped()

                Text("İçerik")
                    .font(.title3)
                    .bold()
                    .padding([.leading, .top])

                VStack(alignment: .leading) {
                    ForEach(1..<9) { i in
                        Text("Ders \(i)- JavaScript'in Temel Konusu")
                            .padding(.leading)
                    }
                }
            }
        }
    }
}

#Preview {
    CourseDetailView()
}


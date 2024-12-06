import SwiftUI

struct FeaturedView: View {
    let javascriptVideos = [
        "https://www.youtube.com/embed/8A7RWDgkXgg",
        "https://www.youtube.com/embed/pl8W3ypHmbk",
        "https://www.youtube.com/embed/BVNsL2UiDXg"
    ]

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Öne Çıkanlar")
                        .font(.largeTitle)
                        .bold()
                        .padding()

                    Text("Sıfırdan İleri Düzey JavaScript")
                        .font(.title2)
                        .padding(.leading)

                    Image("banner")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()

                    Text("Kursu İncele")
                        .font(.title3)
                        .padding(.leading)
                        .foregroundColor(Color.blue)

                    VStack(alignment: .leading) {
                        Text("JavaScript")
                            .font(.title)
                            .bold()

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                NavigationLink(destination: CourseDetailView(courseTitle: "JavaScript'e Başlangıç", videos: javascriptVideos)) {
                                    CourseCardView(title: "JavaScript'e Başlangıç", imageName: "java_script_gorsel")
                                }
                                NavigationLink(destination: CourseDetailView(courseTitle: "İleri Seviye JavaScript", videos: javascriptVideos)) {
                                    CourseCardView(title: "İleri Seviye JavaScript", imageName: "ileriseviyejs")
                                }
                            }
                        }
                    }
                    .padding(.leading)
                }
            }
        }
    }
}

struct CourseCardView: View {
    var title: String
    var imageName: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .cornerRadius(10)

            Text(title)
                .font(.headline)
                .padding(.top, 5)
            
            Button(action: {
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

struct FeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedView()
    }
}


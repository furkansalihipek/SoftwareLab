import SwiftUI

struct DownloadedContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("İndirilen İçerikler")
                .font(.largeTitle)
                .bold()
                .padding()

            Image("ileriseviyejs")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                .clipped()

            Text("İleri Seviye JavaScript")
                .font(.title2)
                .padding(.leading)

            List {
                ForEach(1..<9) { i in
                    HStack {
                        Text("Ders \(i)")
                        Spacer()
                        if i < 4 {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        } else {
                            Image(systemName: "arrow.down.circle")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    DownloadedContentView()
}


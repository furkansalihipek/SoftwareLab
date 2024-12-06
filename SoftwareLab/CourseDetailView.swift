import SwiftUI

struct CourseDetailView: View {
    var courseTitle: String
    var videos: [String]
    @State private var showVideo: [Bool]

    init(courseTitle: String, videos: [String]) {
        self.courseTitle = courseTitle
        self.videos = videos
        _showVideo = State(initialValue: Array(repeating: false, count: videos.count))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(courseTitle)
                    .font(.largeTitle)
                    .bold()
                    .padding()

                ForEach(0..<videos.count, id: \.self) { index in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Ders \(index + 1)")
                                .font(.title3)
                                .bold()

                            Spacer()

                            Button(action: {
                                withAnimation {
                                    showVideo[index].toggle()
                                }
                            }) {
                                Image(systemName: showVideo[index] ? "chevron.down" : "chevron.right")
                                    .font(.title2)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.top)

                        if showVideo[index] {
                            YouTubeWebView(videoURL: videos[index])
                                .frame(height: 250)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                                .padding(.bottom, 20)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Ders Detayları")
    }
}


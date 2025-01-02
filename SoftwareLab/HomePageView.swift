import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var userSession: UserSession
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    Text("Hoş Geldin \(userSession.username)")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)

                    Spacer()

                    NavigationLink(destination: ProfileView()) {
                        Image(systemName: "person")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .padding(.trailing)
                            .foregroundColor(.black)
                    }
                }

                // JavaScript Kartı
                VStack {
                    CardView(
                        imageName: "js",
                        title: "JavaScript",
                        description: "Etkileşimli web uygulamaları geliştirmeye başla!",
                        primaryButtonTitle: "Başla",
                        secondaryButtonTitle: "İncele",
                        primaryButtonAction: {
                        }
                    )
                    
                    HStack(spacing: 20) {
                        NavigationLink(destination: JavaScriptLessonsView()) {
                            Text("Başla")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        NavigationLink(destination: Js_Inspect()) {
                            Text("İncele")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)

                // Python Kartı
                VStack {
                    CardView(
                        imageName: "ileriseviyepy",
                        title: "Python",
                        description: "Esnek ve güçlü uygulamalar yarat!",
                        primaryButtonTitle: "Başla",
                        secondaryButtonTitle: "İncele",
                        primaryButtonAction: {
                        }
                    )
                    
                    HStack(spacing: 20) {
                        NavigationLink(destination: PythonLessonsView()) {
                            Text("Başla")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        NavigationLink(destination: PythonInspect()) {
                            Text("İncele")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.yellow)
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
            }
            .padding(.horizontal)
            .navigationBarHidden(true)
        }
    }
}

struct CardView: View {
    let imageName: String
    let title: String
    let description: String
    let primaryButtonTitle: String
    let secondaryButtonTitle: String
    let primaryButtonAction: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)

            Text(title)
                .font(.headline)

            Text(description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(UserSession())
    }
}

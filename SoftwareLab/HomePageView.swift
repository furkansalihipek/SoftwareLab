import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var userSession: UserSession
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    Text("Hoş Geldin \(userSession.username)")  // Kullanıcı adı burada görünecek
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
                NavigationLink(destination: Js_Inspect()) {
                    CardView(
                        imageName: "js",
                        title: "JavaScript",
                        description: "Etkileşimli web uygulamaları geliştirmeye başla!",
                        primaryButtonTitle: "Başla",
                        secondaryButtonTitle: "İncele",
                        primaryButtonAction: {
                            print("JavaScript öğrenmeye başla butonuna tıklandı")
                        }
                    )
                }

                // Python Kartı
                NavigationLink(destination: PythonInspect()) {
                    CardView(
                        imageName: "ileriseviyepy",
                        title: "Python",
                        description: "Esnek ve güçlü uygulamalar yarat!",
                        primaryButtonTitle: "Başla",
                        secondaryButtonTitle: "İncele",
                        primaryButtonAction: {
                            print("Python öğrenmeye başla butonuna tıklandı")
                        }
                    )
                }
            }
            .navigationTitle("Ana Sayfa")
            .navigationBarHidden(true)
            .onAppear {
                // Kullanıcı verisini çekmek için fetchUserData çağırıyoruz
                if !userSession.isLoggedIn {
                    // Eğer kullanıcı giriş yapmamışsa, giriş ekranına yönlendirebilirsiniz.
                    print("Kullanıcı giriş yapmamış.")
                }
            }
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

            HStack(spacing: 20) {
                Button(action: primaryButtonAction) {
                    Text(primaryButtonTitle)
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Text(secondaryButtonTitle)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.yellow)
                    .foregroundColor(.black)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(UserSession())  // UserSession'i Preview'e ekliyoruz
    }
}

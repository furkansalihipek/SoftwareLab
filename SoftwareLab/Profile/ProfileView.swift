import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userSession: UserSession
    @Environment(\.presentationMode) var presentationMode
    @State private var showingLogoutAlert = false
    
    var body: some View {
        VStack {
            ZStack {
                Color(red: 236/255, green: 220/255, blue: 104/255)
                    .ignoresSafeArea()
                
                VStack {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.white)
                        .padding(.top, 40)
                }
            }
            .frame(height: 200)
            .padding(.bottom, 20)

            // Kullanıcı Adı
            Text("Merhaba, \(userSession.username)")
                .font(.title)
                .fontWeight(.semibold)

            // Kullanıcı Bilgileri Formu
            ZStack(alignment: .topTrailing) {
                Form {
                    Section(header: Text("KULLANICI BILGILERI").font(.subheadline).fontWeight(.semibold).foregroundColor(.gray)) {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                            // TextField için Binding kullanıyoruz
                            TextField("Ad", text: $userSession.username)
                                .textFieldStyle(PlainTextFieldStyle())
                        }
                        
                        HStack {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.gray)
                            // TextField için Binding kullanıyoruz
                            TextField("E-posta", text: $userSession.email)
                                .textFieldStyle(PlainTextFieldStyle())
                                .keyboardType(.emailAddress)
                        }
                    }
                }
                .frame(maxWidth: UIScreen.main.bounds.width - 40, maxHeight: UIScreen.main.bounds.height / 1.5, alignment: .topLeading)
                .cornerRadius(12)
                
                // Kalem İkonu
                NavigationLink(destination: ProfileEditView()) {
                    Image(systemName: "pencil")
                        .foregroundColor(.black)
                        .padding()
                }
            }

            Spacer()

            // Çıkış Yap butonu
            Button(action: {
                showingLogoutAlert = true
            }) {
                Text("Çıkış Yap")
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .navigationBarBackButtonHidden(false)
        .alert(isPresented: $showingLogoutAlert) {
            Alert(
                title: Text("Çıkış Yap"),
                message: Text("Çıkış yapmak istediğinize emin misiniz?"),
                primaryButton: .destructive(Text("Çıkış Yap")) {
                    userSession.isLoggedIn = false
                    // Tüm navigation stack'i temizleyip login sayfasına yönlendir
                    let scenes = UIApplication.shared.connectedScenes
                    let windowScene = scenes.first as? UIWindowScene
                    let window = windowScene?.windows.first
                    window?.rootViewController = UIHostingController(rootView: 
                        NavigationView {
                            IntroView() // ContentView yerine IntroView'a yönlendir
                        }
                    )
                },
                secondaryButton: .cancel(Text("İptal"))
            )
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserSession())
    }
}


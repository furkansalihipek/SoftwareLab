import SwiftUI

class UserSession: ObservableObject {
    @Published var isLoggedIn = false
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var token: String? = nil
    
    func login(username: String, email: String, token: String) {
        self.username = username
        self.email = email
        self.token = token
        self.isLoggedIn = true
    }
    
    func logout() {
        self.username = ""
        self.email = ""
        self.token = nil
        self.isLoggedIn = false
    }
}

struct ContentView: View {
    @StateObject private var userSession = UserSession()
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var isLoginMode = true
    @State private var isLoading = false
    @State private var loginSuccess = false
    
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Text(isLoginMode ? "Giriş Yap" : "Kayıt Ol")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 40)
                
                if !isLoginMode {
                    TextField("Kullanıcı Adı", text: $username)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(25)
                        .padding(.horizontal, 30)
                        .autocapitalization(.none)
                }
                
                TextField("E-posta", text: $email)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(25)
                    .padding(.horizontal, 30)
                    .autocapitalization(.none)

                SecureField("Parola", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(25)
                    .padding(.horizontal, 30)
                    .padding(.top, 10)
                    .autocapitalization(.none)
                
                Button(action: {
                    isLoading = true
                    if isLoginMode {
                        login()
                    } else {
                        register()
                    }
                }) {
                    Text(isLoginMode ? "Giriş Yap" : "Kayıt Ol")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(isLoginMode
                                    ? Color(red: 236/255, green: 220/255, blue: 104/255)
                                    : Color(red: 70/255, green: 115/255, blue: 161/255))
                        .cornerRadius(25)
                        .padding(.horizontal, 30)
                }
                .padding(.top, 30)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Bilgi"), message: Text(alertMessage), dismissButton: .default(Text("Tamam")))
                }
                
                if isLoading {
                    ProgressView()
                        .padding(.top, 20)
                }
                
                Spacer()
                
                HStack {
                    Text(isLoginMode ? "Hesabınız yok mu?" : "Zaten bir hesabınız var mı?")
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        isLoginMode.toggle()
                    }) {
                        Text(isLoginMode ? "Kayıt Ol" : "Giriş Yap")
                            .foregroundColor(isLoginMode
                                            ? Color(red: 70/255, green: 115/255, blue: 161/255)
                                            : Color(red: 236/255, green: 220/255, blue: 104/255))
                            .fontWeight(.bold)
                    }
                }
                .padding(.bottom, 40)
                
                NavigationLink(destination: HomePageView().environmentObject(userSession), isActive: $loginSuccess) {
                    EmptyView()
                }
            }
            .navigationBarHidden(false)
        }
    }
    
    private func login() {
        guard !email.isEmpty, !password.isEmpty else {
            alertMessage = "Lütfen tüm alanları doldurun."
            showAlert = true
            isLoading = false
            return
        }
        
        guard let url = URL(string: "http://localhost:3000/users/login") else { return }
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            alertMessage = "JSON verisi oluşturulamadı: \(error)"
            showAlert = true
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                alertMessage = "Giriş hatası: \(error.localizedDescription)"
                showAlert = true
                isLoading = false
                return
            }
            
            guard let data = data else {
                alertMessage = "Giriş sırasında veri alınamadı."
                showAlert = true
                isLoading = false
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("JSON yanıt: \(json)")

                    if let token = json["token"] as? String, let username = json["username"] as? String {
                        DispatchQueue.main.async {
                            userSession.login(username: username, email: self.email, token: token)
                            loginSuccess = true
                            isLoading = false
                        }
                    } else {
                        alertMessage = "Giriş başarısız. Token veya kullanıcı adı alınamadı."
                        showAlert = true
                        isLoading = false
                    }
                } else {
                    alertMessage = "Yanıt işleme hatası: Yanıt JSON formatında değil."
                    showAlert = true
                    isLoading = false
                }
            } catch {
                alertMessage = "Yanıt işleme hatası: \(error.localizedDescription)"
                showAlert = true
                isLoading = false
            }
        }.resume()
    }

    
    private func register() {
        guard !email.isEmpty, !password.isEmpty, !username.isEmpty else {
            alertMessage = "Lütfen tüm alanları doldurun."
            showAlert = true
            isLoading = false
            return
        }
        
        guard let url = URL(string: "http://localhost:3000/users/register") else { return }
        
        let parameters: [String: Any] = [
            "email": email,
            "password": password,
            "username": username
        ]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            alertMessage = "JSON verisi oluşturulamadı: \(error)"
            showAlert = true
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                alertMessage = "Kayıt hatası: \(error.localizedDescription)"
                showAlert = true
                isLoading = false
                return
            }
            
            guard let data = data else {
                alertMessage = "Kayıt sırasında veri alınamadı."
                showAlert = true
                isLoading = false
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Backend Yanıtı: \(jsonString)")
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("JSON yanıt: \(json)")

                    if let token = json["token"] as? String {
                        DispatchQueue.main.async {
                            userSession.login(username: self.username, email: self.email, token: token)
                            loginSuccess = true
                            isLoading = false
                        }
                    } else {
                        alertMessage = "Kayıt başarısız. Token alınamadı."
                        showAlert = true
                        isLoading = false
                    }
                } else {
                    alertMessage = "Yanıt işleme hatası: Yanıt JSON formatında değil."
                    showAlert = true
                    isLoading = false
                }
            } catch {
                alertMessage = "Yanıt işleme hatası: \(error.localizedDescription)"
                showAlert = true
                isLoading = false
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserSession())
    }
}


import SwiftUI

struct ProfileEditView: View {
    @State private var username = "John"
    @State private var email = "example@gmail.com"
    @State private var phoneNumber = "+14987889999"
    @State private var password = "evFTbyVVCd"
    
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
            Button("Fotoğrafı Düzenle") {
            }
            .padding(.bottom, 20)
            
            Form {
                Section(header: Text("Kullanıcı Bilgileri")) {
                    TextField("Username", text: $username)
                    TextField("Email I’d", text: $email)
                    TextField("Phone Number", text: $phoneNumber)
                    SecureField("Password", text: $password)
                }
            }
            .padding(.bottom, 20)
            
            Button(action: {
            }) {
                Text("Update")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 70/255, green: 115/255, blue: 161/255))
                    .cornerRadius(10)
            }
            .padding([.leading, .trailing], 20)
        }
    }
}

#Preview {
    ProfileEditView()
}

import SwiftUI

struct ProfileEditView: View {
    @EnvironmentObject var userSession: UserSession
    
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
                    TextField("Kullanıcı Adı", text: $userSession.username)
                    TextField("Email", text: $userSession.email)
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
        .environmentObject(UserSession())
}

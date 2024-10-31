import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userSession: UserSession
    
    var body: some View {
        VStack {
            headerView
            userInfo
            contentForm
        }
    }
    
    private var headerView: some View {
        ZStack {
            Color(red: 236/255, green: 220/255, blue: 104/255)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: 120, height: 120)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
            }
        }
        .frame(height: 180)
    }
    
    private var userInfo: some View {
        Text("Merhaba, \(userSession.username)")
            .font(.title)
            .padding(.top, 10)
    }
    
    private var contentForm: some View {
        Form {
            Section(header: Text("Kullanıcı Bilgileri")) {
                userInfoRow(imageName: "person", text: userSession.username)
                userInfoRow(imageName: "envelope", text: userSession.email)
            }
            
            Section(header: Text("İçerik")) {
                navigationLinkRow(destination: Text("Kurslarım"), imageName: "book", text: "Kurslarım")
                navigationLinkRow(destination: Text("Favoriler"), imageName: "heart", text: "Favoriler")
                navigationLinkRow(destination: Text("İndirilenler"), imageName: "arrow.down.circle", text: "İndirilenler")
            }
        }
    }
    
    private func userInfoRow(imageName: String, text: String) -> some View {
        HStack {
            Image(systemName: imageName)
            Text(text)
        }
    }
    
    private func navigationLinkRow<Destination: View>(destination: Destination, imageName: String, text: String) -> some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: imageName)
                Text(text)
            }
        }
    }
}


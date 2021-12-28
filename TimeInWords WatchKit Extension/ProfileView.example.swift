//import SwiftUI
//
//struct CreateProfileView: View {
//    @StateObject var profileViewModel = ProfileViewModel()
//    @Environment(\.presentationMode) var presentation
//
//    var body: some View {
//        EditProfileElement(
//            pageTitle: "Create Your Profile",
//            state: $profileViewModel.state,
//            avatar: $profileViewModel.avatar,
//            newAvatar: $profileViewModel.newAvatar,
//            fullName: $profileViewModel.fullName,
//            email: $profileViewModel.email,
//            saveEnabled: $profileViewModel.saveEnabled,
//            errorMessage: $profileViewModel.errorMessage,
//            showEmail: false,
//            saveButtonTitle: "Continue"
//        ) {
//            profileViewModel.update()
//        }
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    presentation.wrappedValue.dismiss()
//                    profileViewModel.logout()
//                } label: { Image("Back") }
//                .accessibility(label: Text("Back Button"))
//            }
//        }
//        .onAppear {
//            profileViewModel.getProfile()
//        }
//    }
//}
//
//struct CreateProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            CreateProfileView(profileViewModel: PreviewProfileViewModel())
//        }
//    }
//}

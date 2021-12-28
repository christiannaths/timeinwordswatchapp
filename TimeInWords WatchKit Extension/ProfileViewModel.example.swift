//import Foundation
//import Combine
//import UIKit
//
//class ProfileViewModel: ObservableObject {
//
//    @Published var fullName: String = "" {
//        didSet {
//            updateSaveEnabled()
//        }
//    }
//    @Published var email: String = ""
//    @Published var isAdmin = false
//    @Published var avatar: UIImage? = nil
//    @Published var newAvatar: UIImage? = nil {
//        didSet {
//            updateSaveEnabled()
//        }
//    }
//    @Published var state: EditProfileState = .idle {
//        didSet {
//            guard case .authenticated(let userProfile) = state else {
//                return
//            }
//            fullName = userProfile.fullName
//            email = userProfile.email
//            isAdmin = userProfile.isAdmin
//            updateSaveEnabled()
//        }
//    }
//    @Published var errorMessage: String? = nil
//    @Published var saveEnabled = false
//
//    private var cancellables: Set<AnyCancellable> = []
//
//    var userRequestLoader: UserLoadable
//
//    init(userRequestLoader: UserLoadable = UserRequestLoader.shared) {
//        self.userRequestLoader = userRequestLoader
//    }
//
//    deinit {
//        cancellables.removeAll()
//    }
//
//    var isDirty: Bool {
//        guard case .authenticated(let userProfile) = state else {
//            return false
//        }
//        return userProfile.fullName != fullName || newAvatar != nil
//    }
//
//    private func updateSaveEnabled() {
//        saveEnabled = isDirty && state != .updating
//    }
//
//    private func getProfileImage(profile: UserProfile) {
//        userRequestLoader.getProfileImage(userProfile: profile)
//            .sink(receiveCompletion: { completion in
//            switch completion {
//            case .failure(let error):
//                self.errorMessage = error.type.userMessage()
//            case .finished: print("finished")
//            }
//        }, receiveValue: { response in
//            self.avatar = UIImage(data: response)
//        })
//        .store(in: &cancellables)
//    }
//
//    func getProfile() {
//        userRequestLoader.getProfile()
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure(let error):
//                    self.state = .errorAuthenticating(error.type.userMessage())
//                case .finished: print("finished")
//                }
//            }, receiveValue: { profile in
//                self.state = .authenticated(profile)
//                self.getProfileImage(profile: profile)
//            })
//            .store(in: &cancellables)
//    }
//
//
//    func update() {
//        guard case .authenticated(let userProfile) = state else {
//            return
//        }
//        var avatarData: Data? = nil
//        if let avatar = newAvatar{
//            avatarData = avatar.jpegData(compressionQuality: 1.0)
//        }
//
//        guard fullName.count > 0 else {
//            errorMessage = "You must enter a name"
//            return
//        }
//
//        state = .updating
//        errorMessage = nil
//        userRequestLoader.update(currentProfile: userProfile, fullName: fullName, avatar: avatarData)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .failure(let error):
//                    print("Error \(error))")
//                    self.errorMessage = error.type.userMessage()
//                case .finished: print("finished")
//                }
//            }, receiveValue: { response in
//                self.state = .authenticated(response)
//            })
//            .store(in: &cancellables)
//    }
//
//    func logout() {
//        userRequestLoader.logout()
//    }
//}

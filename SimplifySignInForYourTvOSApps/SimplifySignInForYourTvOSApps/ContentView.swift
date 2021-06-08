//
//  ContentView.swift
//  SimplifySignInForYourTvOSApps
//
//  Created by Daniel Saidi on 2021-06-08.
//

import SwiftUI
import AuthenticationServices

class LoginService: NSObject, ASAuthorizationControllerDelegate {
    
    let controller = ASAuthorizationController(authorizationRequests: [
        ASAuthorizationPasswordProvider().createRequest(),
        ASAuthorizationAppleIDProvider().createRequest(),
    ])
    
    func login() {
        controller.customAuthorizationMethods = [
            .other,
            .restorePurchase]
        
        controller.delegate = nil // Set real thing
        controller.performRequests()
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // These can't be in the view
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        // These can't be in the view
    }
    
    func authorizationController(_ controller: ASAuthorizationController, didCompleteWithCustomMethod method: ASAuthorizationCustomMethod) {
        // These can't be in the view
    }
}

/**
 Use associated domains with webcredentials: prefix
 
 e.g. webcredentials:danielsaidi.com
 
 In .well-known/apple-app-site-association
 {
    "webcredentials": {
        "apps": ["bundleid1", "bundleid2"]
    }
 }
 */
struct ContentView: View {
    
    // ASAuthorizationCustomMethod.videoSubscriberAccount
    // ASAuthorizationCustomMethod.restorePurchase
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

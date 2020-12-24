//
//  AppDelegate.swift
//  SwensonheCodingChallenge
//
//  Created by Mohamed Elzohirey on 11/19/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("debit card".isAnagramWith(secondString: "bad credit"))
        print("punishments".isAnagramWith(secondString: "ninethumps"))
        for s in sequenceByRecursion(state_first: (0, 1), while: { $1 <= 100 }, state_next: { ($1, $0 + $1)}) {
            print(s.1)
        }
        print(fibGeneratorByItterations(10))
        return true
    }
    public func sequenceByRecursion<T>(state_first: T, while condition: @escaping (T)-> Bool, state_next: @escaping (T) -> T) -> UnfoldSequence<T, T> {
        let state_next = { (stateToCheck: inout T) -> T? in
            guard condition(stateToCheck) else { return nil }
            defer { stateToCheck = state_next(stateToCheck) }
            return stateToCheck
        }
        return Swift.sequence(state: state_first, next: state_next)
    }
    func fibGeneratorByItterations(_ n: Int) -> [Int] {
        var fibArray: [Int] = [1, 1]
        (2...n).forEach { i in
            fibArray.append(fibArray[i - 1] + fibArray[i - 2])
        }
        return fibArray
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


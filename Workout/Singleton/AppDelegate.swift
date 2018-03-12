//
//  AppDelegate.swift
//  Workout
//
//  Created by Allen Johnson on 3/7/18.
//  Copyright © 2018 Allen Johnson. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let config = Realm.Configuration(
            schemaVersion: 0,
            deleteRealmIfMigrationNeeded: true
        )
        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()

        let exercises: Results<Exercise> = { realm.objects(Exercise.self) }()
        let workouts: Results<Workout> = { realm.objects(Workout.self) }()
        
        populateDefaultExercises(realm: realm, exercises: exercises)
        populateDefaultWorkouts(realm: realm, workouts: workouts)
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func populateDefaultExercises(realm: Realm, exercises: Results<Exercise>) {
        
        var exercises = exercises
        if exercises.count == 0 {
            
            print("No exercises found; populating...")
            
            try! realm.write() {
                
                let defaultExercises = ["Dumbbell Curl",
                                         "Seated Dumbbell Shoulder Press",
                                         "Seated Overhead Triceps Extension",
                                         "Dumbbell Lateral Raise",
                                         "Dumbbell Rear Lateral Raise",
                                         "Dumbbell Front Raise",
                                         "Dumbbell Front Raise",
                                         "Triceps Rope Pushdown",
                                         "Triceps Pulldown",
                                         "Cable Overhead Triceps Rope Pulldown",
                                         "Triceps Pushdown",
                                         "Dumbbell Rotational Punch",
                                         "Dumbbell Shrug",
                                         "Cable Rear Lateral Raise",
                                         "Inclined Shoulder Raise"]
                
                for exercise in defaultExercises {
                    let newExercise = Exercise()
                    newExercise.name = exercise
                    realm.add(newExercise)
                }
                
            }
            
            exercises = realm.objects(Exercise.self)
        }
        
        print("Number of exercises: \(exercises.count)")
        
    }
    
    func populateDefaultWorkouts(realm: Realm, workouts: Results<Workout>) {
        
        var workouts = workouts
        if workouts.count == 0 {
            
            print("No workout found; populating...")
            
            try! realm.write() {
                
                let defaultWorkouts = ["Arms, Shoulders, Serratus, Traps",
                                       "Back, Serratus, Traps",
                                       "Chest, Abs",
                                       "Legs, Abs",
                                       "Chest, Legs, Abs"]
                
                for workout in defaultWorkouts {
                    let newWorkout = Workout()
                    newWorkout.name = workout
                    realm.add(newWorkout)
                }
                
            }
            
            workouts = realm.objects(Workout.self)
        }
        
        print("Number of workouts: \(workouts.count)")
        
    }

}


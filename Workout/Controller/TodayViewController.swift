//
//  ViewController.swift
//  Workout
//
//  Created by Allen Johnson on 3/7/18.
//  Copyright © 2018 Allen Johnson. All rights reserved.
//

import UIKit
import RealmSwift

class TodayViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIView!
    
    @IBOutlet weak var workoutsCountLabel: UILabel!
    @IBOutlet weak var firstWorkoutLabel: UILabel!
    
    @IBOutlet weak var bestGuessUIView: PredictiveWorkoutThumbnailView!
    
    // Labels
    @IBOutlet weak var bestGuessLabel: UILabel!
    @IBOutlet weak var altGuessLabel: UILabel!
    
    // Constraints
    @IBOutlet weak var bestGuessViewHeight: NSLayoutConstraint!
    @IBOutlet weak var bestGuessHeaderTop: NSLayoutConstraint!
    @IBOutlet weak var bestGuessHeaderLeading: NSLayoutConstraint!
    
    @IBOutlet weak var altGuessViewHeight: NSLayoutConstraint!
    
    @IBAction func tapBestGuess(_ recognizer: UITapGestureRecognizer) {
        guard recognizer.view != nil else { return }
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        
        var animator:UIViewPropertyAnimator!
        if recognizer.state == .ended {
            let timing = UISpringTimingParameters(dampingRatio: 0.8,
                                                initialVelocity: CGVector(dx:0.0, dy: 0.0))
            animator = UIViewPropertyAnimator(duration: 0.5, timingParameters:timing)
            animator.addAnimations {
                recognizer.view?.frame.size.width = screenWidth
                recognizer.view!.center.y = 0 + (recognizer.view?.frame.height)! / 2
                recognizer.view!.center.x = screenWidth / 2
                recognizer.view!.layer.cornerRadius = 0
                recognizer.view!.frame.size.height = 300
//                self.bestGuessViewHeight.constant = 300
                self.bestGuessHeaderTop.constant = 50
//                self.bestGuessLastCompletedBottom.constant = 8
                
            }
            animator.startAnimation()
        }
        recognizer.isEnabled = false
    }
    
    let realm = try! Realm()
    lazy var workouts: Results<Workout> = { realm.objects(Workout.self) }()
    let predictedWorkouts = List<Workout>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup profileImageView
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
        self.profileImageView.clipsToBounds = true;
        
        //realm workout tests
        workoutsCountLabel.text = String(format: "There are %02d stored workouts", workouts.count)
        firstWorkoutLabel.text = workouts[0].name
        
        //predictive workout thumbnails
        predictWorkouts()
//        print(predictedWorkouts)
        
        if predictedWorkouts.count > 0 {
            
            // BestGuessUIView
//            let gradient = CAGradientLayer()
//
//            gradient.frame = bestGuessUIView.bounds
//            gradient.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
//            bestGuessUIView.layer.insertSublayer(gradient, at: 0)
            
            // set corner radius
            bestGuessUIView.layer.cornerRadius = 12
            
            // set drop shadow
            bestGuessUIView.dropShadow(color: UIColor(red:0.12, green:0.20, blue:0.29, alpha:1), opacity: 0.2, offSet: CGSize(width: 0, height: bestGuessUIView.frame.height / 2), radius: 10, scale: true)
            
            // set height
            bestGuessLabel.text = predictedWorkouts[0].name
            let bestGuessLabelSize = bestGuessLabel.text?.size(withAttributes: [.font: bestGuessLabel.font]) ?? .zero
//            print(bestGuessLabelSize)
            let bestGuessLabelLinesNum = bestGuessLabel.calculateMaxLines()
//            print(bestGuessLabelLinesNum)
            bestGuessViewHeight.constant += bestGuessLabelSize.height * CGFloat(bestGuessLabelLinesNum)

            
            // AltGuessUIView
            
            altGuessLabel.text = predictedWorkouts[1].name
            let altGuessLabelSize = altGuessLabel.text?.size(withAttributes: [.font: altGuessLabel.font]) ?? .zero
            let altGuessLabelLinesNum = altGuessLabel.calculateMaxLines()
            altGuessViewHeight.constant += altGuessLabelSize.height * CGFloat(altGuessLabelLinesNum)
            
//            self.view.layoutIfNeeded()
            
//            let animator = UIViewPropertyAnimator(duration: 2.5, curve: .linear) {
//                self.bestGuessUIView.frame = self.bestGuessUIView.frame.offsetBy(dx: 100, dy: 0)
//            }
//            animator.startAnimation()
            
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func predictWorkouts() {
    // Stub implementation to be replaced with prediction algorithm
        for idx in 0..<2 {
            predictedWorkouts.append(workouts[idx])
        }
    }
    
}

extension UILabel {
    
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
        let charSize = font.lineHeight
        let text = (self.text ?? "") as NSString
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        let lines = Int(textSize.height/charSize)
        return lines
    }
    
}

extension UIView {
    
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    // OUTPUT 2
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

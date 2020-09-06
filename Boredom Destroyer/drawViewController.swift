//
//  drawViewController.swift
//  Boredom Destroyer
//
//  Created by Evan Kwak on 2020-09-04.
//  Copyright © 2020 Evan Kwak. All rights reserved.
//

import UIKit

class Canvas: UIView {
    
    
    fileprivate var strokeColor = UIColor.black
    fileprivate var strokeWidth: Float = 1
    
    func setStrokeWidh(width: Float){
        
        self.strokeWidth = width
        }
    
    func setStrokeColor(color: UIColor) {
        
        self.strokeColor = color
    }
    
    
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else
        {return}
        
     
       
       
        context.setLineCap(.butt)
        
        
      lines.forEach { (line) in
        context.setStrokeColor(line.color.cgColor)
        context.setLineWidth(CGFloat(line.strokeWidth))
        context.setLineCap(.round)
        for (i, p) in line.points.enumerated() {
              if i == 0 {
                  context.move(to: p)
              } else {
                  context.addLine(to: p)
              }
          }
        context.strokePath()
      }
        
        
        
        lines.forEach{(line) in
          
    }
        
       
        
        
        context.strokePath()
        
        
    }
    
    
    
    fileprivate var lines = [Line]()
    
     override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        lines.append(Line.init(strokeWidth: strokeWidth, color: strokeColor, points: []))
    }
    
    
    
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
     guard let point = touches.first?.location(in: nil)
    
        else {return}
    
        guard var lastline = lines.popLast() else {return}
        lastline.points.append(point)
        
        lines.append(lastline)
        
       // var lastline = lines.last
        
        //lastline?.append(point)
        
        //lines.append(point)
       // print(point)
        
    setNeedsDisplay()
    }
}



class drawViewController: UIViewController {

    
    let canvas = Canvas()
    
   
        
    
    //under button (invivisible but still able to click on it (left side) )

    let undoButton: UIButton = {
                let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize:10)
        button.addTarget(self, action: #selector(handleUndo),
            for: .touchUpInside)
        return button
        
    }()
    
    @objc fileprivate func handleUndo() {
        
        canvas.undo()
        
        
        
        
        
        
        
        
        
        
    }
    //clear button (invivisible but still able to click on it (right side) )
    let clearButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize:10)
        button.addTarget(self, action: #selector(handleclear),
                   for: .touchUpInside)
        
        return button
        
    }()
    
    
   
    //yellow ccolor selector
    
    let yellowButton: UIButton={
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 1
        button.addTarget(self, action:
            #selector(handleColorChange),for:
            .touchUpInside)
        return button
        
    }()
    
    
    //red color selector
    let redButton: UIButton={
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.addTarget(self, action:
            #selector(handleColorChange),for:
        .touchUpInside)
        return button
        
    }()
    
    //blue color selector
    let blueButton: UIButton={
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.addTarget(self, action:
            #selector(handleColorChange),for:
        .touchUpInside)
        button.layer.borderWidth = 1
        return button
        
    }()
    
    @objc fileprivate func handleColorChange(button: UIButton){
        canvas.setStrokeColor(color: button.backgroundColor ?? .black)   }
    //size slider
    let slider: UISlider  = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 20
        slider.addTarget(self, action: #selector(handleSliderChange),
        for: .valueChanged)
        return slider
        
    }()
    
    @objc fileprivate func handleSliderChange(){
        canvas.setStrokeWidh(width: slider.value)
    }
    
    
    
    
    
    @objc func handleclear(){
        canvas.clear()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(canvas)
        
        
        canvas.backgroundColor = .white
        
        
        canvas.frame = view.frame
        //inserts stack view
        let colorsStackView = UIStackView (arrangedSubviews:
        [yellowButton, redButton, blueButton])
        colorsStackView.distribution = .fillEqually
        
        let stackView = UIStackView(arrangedSubviews: [
            undoButton,
            colorsStackView,
            clearButton,
            slider,
        ])
        
        
        //creates stack view
        stackView.spacing = 5
        
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.leadingAnchor.constraint(equalTo:
            view.leadingAnchor).isActive = true
        
        stackView.bottomAnchor.constraint(equalTo:
            view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        stackView.trailingAnchor.constraint(equalTo:
            view.trailingAnchor, constant: -8).isActive = true
    
    
    
    
    


}
}

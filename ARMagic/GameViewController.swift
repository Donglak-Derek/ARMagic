//
//  GameViewController.swift
//  ARMagic
//
//  Created by DerekMacbook on 5/29/18.
//  Copyright © 2018 DerekMacbook. All rights reserved.
//

import ARKit
import LBTAComponents

class GameViewController: UIViewController, ARSCNViewDelegate {
    
    let arView: ARSCNView = {
        let view = ARSCNView()
//        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let plusButtonWidth = ScreenSize.width * 0.1
    lazy var plusButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "plusbutton").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(white: 1.0, alpha: 0.7)
        button.layer.cornerRadius = plusButtonWidth * 0.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handlePlusButtonTapped), for: .touchUpInside)
        // Safe way to use img
        button.layer.zPosition = 1
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    @objc func handlePlusButtonTapped() {
        print("Tapped on plus button")
        addNode()
        
    }
    
    let resetButtonWidth = ScreenSize.width * 0.1
    lazy var resetButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "reset").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(white: 1.0, alpha: 0.7)
//        button.layer.cornerRadius = resetButtonWidth * 0.5
//        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleResetButtonTapped), for: .touchUpInside)
        // Safe way to use img
        button.layer.zPosition = 1
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    @objc func handleResetButtonTapped() {
        print("Tapped on reset button")
        resetScene()
        
    }
    
    
    let minusButtonWidth = ScreenSize.width * 0.1
    lazy var minusButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "minusButton").withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(white: 1.0, alpha: 0.7)
        button.layer.cornerRadius = minusButtonWidth * 0.5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleMinusButtonTapped), for: .touchUpInside)
        // Safe way to use img
        button.layer.zPosition = 1
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }()
    
    @objc func handleMinusButtonTapped() {
        print("Tapped on minus button")
        removeAllBoxes()
        
    }
    
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupViews()
        
        configuration.planeDetection = .horizontal


        arView.session.run(configuration, options: [])
        // yellow little dots. information from the camera
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        arView.autoenablesDefaultLighting = true
        arView.delegate = self
        }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    func setupViews() {
//        arView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        arView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
//        arView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        arView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        view.addSubview(arView)
//        arView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant
//            : 0)
        arView.fillSuperview()
        
        view.addSubview(plusButton)
        plusButton.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 24, bottomConstant: 24, rightConstant: 0, widthConstant: plusButtonWidth, heightConstant: plusButtonWidth)
        
        view.addSubview(minusButton)
        minusButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 24, rightConstant: 24, widthConstant: minusButtonWidth, heightConstant: minusButtonWidth)
        
        view.addSubview(resetButton)
        resetButton.anchor(nil, left: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 24, rightConstant: 0, widthConstant: resetButtonWidth, heightConstant: resetButtonWidth)
        resetButton.anchorCenterXToSuperview()
    }
    
    func addNode() {
        let shapeNode = SCNNode()
//        boxNode.geometry = SCNBox(width: 0.05, height: 0.05, length: 0.05, chamferRadius: 0.0002)
//        shapeNode.geometry = SCNCapsule(capRadius: 0.05, height: 0.20)
//        shapeNode.geometry = SCNCone(topRadius: 0.05, bottomRadius: 0.10, height: 0.15)
//        shapeNode.geometry = SCNCylinder(radius: 0.15, height: 0.15)
        shapeNode.geometry = SCNTorus(ringRadius: 0.15, pipeRadius: 0.05)

        shapeNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
        // 0.3 = 30cm, random position
        shapeNode.position = SCNVector3(Float.random(-0.5, max: 0.5), Float.random(-0.5, max: 0.5), Float.random(-0.5, max: 0.5) )
//        shapeNode.position = SCNVector3(0.0, 0.0, -0.3)
        shapeNode.name = "node"
        arView.scene.rootNode.addChildNode(shapeNode)
    }
    
    func removeAllBoxes() {
        arView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "node"{
                node.removeFromParentNode()
            }
        
        }
    }
    
    func resetScene() {
        arView.session.pause()
        arView.scene.rootNode.enumerateChildNodes { (node, _) in
            if node.name == "node" {
                node.removeFromParentNode()
            }
        }
        arView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
    
    }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
        print("New Plane Anchor found at extent:", anchorPlane.extent)
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
        print("Plane Anchor updated with extent:", anchorPlane.extent)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
        print("Plane Anchor removed with extent:", anchorPlane.extent)
    }
    
}






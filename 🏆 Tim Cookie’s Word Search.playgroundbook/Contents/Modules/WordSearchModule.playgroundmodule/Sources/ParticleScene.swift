

import Foundation
import SpriteKit

class ParticleScene: SKScene {
    override func didMove(to view: SKView) {
        super.didMove(to: view)
    }
    
    func setupParticleEmitter() {
        var particleEmitter = SKEmitterNode()
        particleEmitter = SKEmitterNode(fileNamed: "CookieParticles")!
        particleEmitter.particleBirthRate = 10
        particleEmitter.particleLifetime = 50000
        particleEmitter.particleSpeed = 250
        particleEmitter.particleAlphaRange = 100
        particleEmitter.particleTexture = SKTexture(image: UIImage(named: "Cookie")!)
        
        particleEmitter.position = CGPoint(x: size.width/2, y: size.height)
        addChild(particleEmitter)
        
    }
}

//
//  GameScene.swift


import SnapKit
import SpriteKit
import GameplayKit

enum GameState {
    case back
    case updateScoreBackEnd
    case noCoints
    case gameBack
}

class GameScene: SKScene {
    
    
    private var coints: Int = 0
    private var points: Int = 0
    private var popupActive: Bool = false
    
    private var slowModeTimer: Timer?
    private var startView: SKSpriteNode!
    private var progressBarBackground: SKSpriteNode!
    private var progressBarFill: SKSpriteNode!
    private var cup: SKSpriteNode!
    
    private var dropButton = CustomSKButton(texture: SKTexture(imageNamed: "playBtn"))
    private var x2PointBtn = CustomSKButton(texture: SKTexture(imageNamed: "x2PointsTapped"))
    private var addTimeBtn = CustomSKButton(texture: SKTexture(imageNamed: "addTimeTapped"))
    private var lightningBtn = CustomSKButton(texture: SKTexture(imageNamed: "lightningTapped"))
    
    private var countX2Points = SKLabelNode()
    private var countAddTimeLabel = SKLabelNode()
    private var countLightningLabel = SKLabelNode()
    private var pointsLabel = SKLabelNode()
    private var cointsLabel = SKLabelNode()
    
    private var spawnTimer: Timer?
    private var spawnDuration = 60.0
    private let playItems = ["imgTrash10", "imgTimeG", "imgPointsG","imgCoinsG", "imgTrashA", "imgTrashJ", "imgTrashK", "imgTrashQ"]

    private var doublePointsActive = false
    private var hasCollidedWithTrash = false
    private var collidedWithImgPointsG = false
    private var collidedWithImgTimeG = false
    private var usedX2Bonus = false
    private var usedAddTimeBonus = false
    private var usedLightningBonus = false

    private let storage = Memory.shared

    public var resultTransfer: ((GameState) -> Void)?
    
    
    override func didMove(to view: SKView) {
        swipeGesture()
        addSettingsScene()
        setupGameSubviews()
        setupButtons()
    }

    
    private func swipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view?.addGestureRecognizer(swipeRight)

        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        view?.addGestureRecognizer(swipeLeft)

    }
    
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        let moveDistance: CGFloat = 50 // Дистанция, на которую будет смещаться объект
        if gesture.direction == .right {
            let moveRight = SKAction.moveBy(x: moveDistance, y: 0, duration: 0.1)
            cup.run(moveRight)
        } else if gesture.direction == .left {
            let moveLeft = SKAction.moveBy(x: -moveDistance, y: 0, duration: 0.1)
            cup.run(moveLeft)
        }
    }
    
    private func addSettingsScene() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
    }
    
    
    private func setupGameSubviews() {
        setupBackground()
        setupNavigation()
        setupProgressBar()
    }
    
    func updateCoinsBalance() {
        pointsLabel.text = String(points)
        cointsLabel.text = String(coints)
    }
    
    private func setupButtons() {
        dropButton.normal = UIImage(named: "playBtn")
        dropButton.highlighted = UIImage(named: "playBtnTapped")
        x2PointBtn.normal = UIImage(named: "x2PointsBtn")
        x2PointBtn.highlighted = UIImage(named: "x2PointsTapped")
        addTimeBtn.normal = UIImage(named: "addTimeBtn")
        addTimeBtn.highlighted = UIImage(named: "addTimeTapped")
        lightningBtn.normal = UIImage(named: "lightningBtn")
        lightningBtn.highlighted = UIImage(named: "lightningTapped")
        
    }
    
    private func setupBackground() {
        let hpNode = SKSpriteNode(imageNamed: "bgStart")
        hpNode.anchorPoint = .init(x: 0, y: 0)
        hpNode.size = .init(width: size.width, height: size.height)
        hpNode.position = CGPoint(x: 0, y: 0)
        hpNode.zPosition = -1
        addChild(hpNode)
    }
    
    
    private func setupNavigation() {
        let backBtn = CustomSKButton(texture: SKTexture(imageNamed: "btnBack"))
        backBtn.size = .init(width: 48, height: 48)
        backBtn.anchorPoint = .init(x: 0, y: 1.0)
        backBtn.position = CGPoint(x: 24.autoSize, y: size.height - 58.autoSize)
        backBtn.normal = UIImage(named: "btnBack")
        backBtn.highlighted = UIImage(named: "btnBackTapped")
        backBtn.zPosition = 50
        backBtn.action = { self.backButtonAction() }
        addChild(backBtn)
        
        let pointsImgTexture = SKTexture(imageNamed: "pointCont")
        let pointsImg = SKSpriteNode(texture: pointsImgTexture)
        pointsImg.size = CGSize(width: 146, height: 76)
        pointsImg.position = CGPoint(x: backBtn.position.x + backBtn.size.width + 80, y: size.height - 86.autoSize)
        pointsImg.zPosition = 50
        addChild(pointsImg)
        
        pointsLabel.fontName = "Unbounded-Bold"
        pointsLabel.fontSize = 16
        pointsLabel.fontColor = .white
        pointsLabel.position = CGPoint(x: 20.autoSize, y: 0)
        pointsLabel.zPosition = 50
        pointsImg.addChild(pointsLabel)
        
        let countsImgTexture = SKTexture(imageNamed: "cointCont")
        let countsImg = SKSpriteNode(texture: countsImgTexture)
        countsImg.size = CGSize(width: 146, height: 76)
        countsImg.position = CGPoint(x: self.size.width - 146 / 2 - 24, y: size.height - 86.autoSize)
        countsImg.zPosition = 50
        addChild(countsImg)
        
        cointsLabel.fontName = "Unbounded-Bold"
        cointsLabel.fontSize = 16
        cointsLabel.fontColor = .white
        cointsLabel.position = CGPoint(x: 20.autoSize, y: 0)
        cointsLabel.zPosition = 50
        countsImg.addChild(cointsLabel)
        
        let shapeWidth = self.size.width / 3
        let shapeHeight: CGFloat = 114.autoSize
        
//        x2PointBtn.size = CGSize(width: shapeWidth, height: shapeHeight)
//        x2PointBtn.anchorPoint = CGPoint(x: 0, y: 0)
//        x2PointBtn.position = CGPoint(x: 0, y: 0)
//        x2PointBtn.zPosition = 32
//        x2PointBtn.action = {self.dropButtonButtonActionOne() }
//        addChild(x2PointBtn)
//        
//        let cointLabeX2PointslImgTexture = SKTexture(imageNamed: "countLabel")
//        let labelX2PointsImg = SKSpriteNode(texture: cointLabeX2PointslImgTexture)
//        labelX2PointsImg.size = CGSize(width: 24.autoSize, height: 24.autoSize)
//        labelX2PointsImg.position = CGPoint(x: 102.autoSize, y: 56.autoSize)
//        labelX2PointsImg.zPosition = 33
//        x2PointBtn.addChild(labelX2PointsImg)
//        
//        countX2Points.fontName = "Unbounded-Regular"
//        countX2Points.text = "\(storage.pointsX2)"
//        countX2Points.fontSize = 14.autoSize
//        countX2Points.fontColor = .white
//        countX2Points.position = CGPoint(x: 102.autoSize, y: 50.autoSize)
//        countX2Points.zPosition = 34
//        x2PointBtn.addChild(countX2Points)
//        
//        addTimeBtn.size = CGSize(width: shapeWidth, height: shapeHeight)
//        addTimeBtn.anchorPoint = CGPoint(x: 0, y: 0)
//        addTimeBtn.position = CGPoint(x: shapeWidth, y: 0)
//        addTimeBtn.zPosition = 32
//        addTimeBtn.action = {self.dropButtonButtonActionTwo() }
//        addChild(addTimeBtn)
//        
//        let cointLabelAddTimeImgTexture = SKTexture(imageNamed: "countLabel")
//        let labelAddTimeImg = SKSpriteNode(texture: cointLabelAddTimeImgTexture)
//        labelAddTimeImg.size = CGSize(width: 24.autoSize, height: 24.autoSize)
//        labelAddTimeImg.position = CGPoint(x: 98.autoSize, y: 56.autoSize)
//        labelAddTimeImg.zPosition = 33
//        addTimeBtn.addChild(labelAddTimeImg)
//        
//        countAddTimeLabel.fontName = "Unbounded-Regular"
//        countAddTimeLabel.text = "\(storage.addTime)"
//        countAddTimeLabel.fontSize = 14.autoSize
//        countAddTimeLabel.fontColor = .white
//        countAddTimeLabel.position = CGPoint(x: 98.autoSize, y: 50.autoSize)
//        countAddTimeLabel.zPosition = 34
//        addTimeBtn.addChild(countAddTimeLabel)
//        
//        lightningBtn.size = CGSize(width: shapeWidth, height: shapeHeight)
//        lightningBtn.anchorPoint = CGPoint(x: 0, y: 0)
//        lightningBtn.position = CGPoint(x: shapeWidth * 2, y: 0)
//        lightningBtn.zPosition = 32
//        lightningBtn.action = {self.dropButtonButtonActionThree() }
//        addChild(lightningBtn)
//        
//        let cointLabelLightningImgTexture = SKTexture(imageNamed: "countLabel")
//        let labelLightningImg = SKSpriteNode(texture: cointLabelLightningImgTexture)
//        labelLightningImg.size = CGSize(width: 24.autoSize, height: 24.autoSize)
//        labelLightningImg.position = CGPoint(x: 96.autoSize, y: 56.autoSize)
//        labelLightningImg.zPosition = 33
//        lightningBtn.addChild(labelLightningImg)
//        
//        countLightningLabel.fontName = "Unbounded-Regular"
//        countLightningLabel.text = "\(storage.lightning)"
//        countLightningLabel.fontSize = 14.autoSize
//        countLightningLabel.fontColor = .white
//        countLightningLabel.position = CGPoint(x: 96.autoSize, y: 50.autoSize)
//        countLightningLabel.zPosition = 34
//        lightningBtn.addChild(countLightningLabel)
        
    }


    private func setupProgressBar() {
        let timeImg = SKSpriteNode(imageNamed: "imgTimeG")
        timeImg.size = CGSize(width: 47, height: 47)
        if UIScreen.main.bounds.height < 852 {
              timeImg.position = CGPoint(x: 78, y: size.height - 126)
          } else {
              timeImg.position = CGPoint(x: 60, y: size.height - 126)
          }
        timeImg.zPosition = 14
        self.addChild(timeImg)
        // Фон прогресс-бара
        progressBarBackground = SKSpriteNode(imageNamed: "imgTimeline")
        progressBarBackground.size = CGSize(width: 255.autoSize, height: 11)
        progressBarBackground.position = CGPoint(x: self.size.width / 2, y: size.height - 126)
        progressBarBackground.zPosition = 13
        self.addChild(progressBarBackground)

        // Заполнение прогресс-бара
        progressBarFill = SKSpriteNode(imageNamed: "imgProgress")
        progressBarFill.size = CGSize(width: 0, height: 13)
        progressBarFill.anchorPoint = CGPoint(x: 0, y: 0.5)
        progressBarFill.position = CGPoint(x: progressBarBackground.position.x - progressBarBackground.size.width / 2, y: size.height - 126)
        progressBarFill.zPosition = 21
        self.addChild(progressBarFill)

    }
}
extension GameScene {
    
 
//    private func showGameOverViewScore() {
//        storage.scoreCoints += coints
//        storage.scorePoints += points
//        
//        let gameOverNode = SKSpriteNode(color: .cDarkBlue.withAlphaComponent(0.6), size: self.size)
//        gameOverNode.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)
//        gameOverNode.zPosition = 100
//        gameOverNode.name = "gameOverNode"
//        
//        let square = SKSpriteNode(imageNamed: "scoreContImg")
//        square.size = CGSize(width: 346.autoSize, height: 674.autoSize)
//        square.position = CGPoint(x: 0, y: -80.autoSize)
//        square.zPosition = 101
//        gameOverNode.addChild(square)
//        
//        let titleLabel = SKLabelNode()
//          let titleText = "Well done!".uppercased()
//          let titleAttributes: [NSAttributedString.Key: Any] = [
//              .font: UIFont(name: "Unbounded-Bold", size: 24)!,
//              .foregroundColor: UIColor.cYellow,
//              .kern: 1.2
//          ]
//          let attributedTitle = NSAttributedString(string: titleText, attributes: titleAttributes)
//          titleLabel.attributedText = attributedTitle
//          titleLabel.position = CGPoint(x: 0, y: 280.autoSize)
//          titleLabel.zPosition = 102
//          square.addChild(titleLabel)
//          
//          let subTitleLabel = SKLabelNode()
//          let subTitleText = "Your response is excellent\n            You've earned"
//          let subTitleAttributes: [NSAttributedString.Key: Any] = [
//              .font: UIFont(name: "Unbounded-Regular", size: 12)!,
//              .foregroundColor: UIColor.white,
//              .kern: 1.2
//          ]
//          let attributedSubTitle = NSAttributedString(string: subTitleText, attributes: subTitleAttributes)
//          subTitleLabel.attributedText = attributedSubTitle
//          subTitleLabel.horizontalAlignmentMode = .center
//          subTitleLabel.verticalAlignmentMode = .center
//          subTitleLabel.numberOfLines = 0
//          subTitleLabel.position = CGPoint(x: 0, y: 246.autoSize)
//          subTitleLabel.zPosition = 102
//        square.addChild(subTitleLabel)
//
//        
//        let scoreImg = SKSpriteNode(imageNamed: "scoreImg")
//        scoreImg.size = CGSize(width: 200.autoSize, height: 50.autoSize)
//        scoreImg.position = CGPoint(x: 0, y: 184.autoSize)
//        scoreImg.zPosition = 102
//        square.addChild(scoreImg)
//        
//        let pointsLabel = SKLabelNode()
//            let pointsText = "\(points)"
//            let pointsAttributes: [NSAttributedString.Key: Any] = [
//                .font: UIFont(name: "Unbounded-Bold", size: 20)!,
//                .foregroundColor: UIColor.white,
//                .kern: 5.0
//            ]
//            let attributedPoints = NSAttributedString(string: pointsText, attributes: pointsAttributes)
//            pointsLabel.attributedText = attributedPoints
//            pointsLabel.position = CGPoint(x: 64.autoSize, y: -8.autoSize)
//            pointsLabel.zPosition = 102
//            scoreImg.addChild(pointsLabel)
//            
//            let cointsLabel = SKLabelNode()
//            let cointsText = "\(coints)"
//            let cointsAttributes: [NSAttributedString.Key: Any] = [
//                .font: UIFont(name: "Unbounded-Bold", size: 20)!,
//                .foregroundColor: UIColor.white,
//                .kern: 5.0
//            ]
//            let attributedCoints = NSAttributedString(string: cointsText, attributes: cointsAttributes)
//            cointsLabel.attributedText = attributedCoints
//            cointsLabel.position = CGPoint(x: -30.autoSize, y: -8.autoSize)
//            cointsLabel.zPosition = 102
//            scoreImg.addChild(cointsLabel)
//        
//        let imgYouWin = SKSpriteNode(imageNamed: "scoreCenterImg")
//        imgYouWin.size = CGSize(width: 250.autoSize, height: 250.autoSize)
//        imgYouWin.position = CGPoint(x: -4, y: 24.autoSize)
//        imgYouWin.zPosition = 101
//        square.addChild(imgYouWin)
//                
//        let thanksBtn = CustomSKButton(texture: SKTexture(imageNamed: "thanksBtn"))
//        thanksBtn.size = .init(width: 250.autoSize, height: 84.autoSize)
//        thanksBtn.position =  CGPoint(x: 0, y: -142.autoSize)
//        thanksBtn.zPosition = 40
//        thanksBtn.normal = UIImage(named: "thanksBtn")
//        thanksBtn.action = { self.backHomeAction() }
//        square.addChild(thanksBtn)
//        
//        self.addChild(gameOverNode)
//        self.enumerateChildNodes(withName: "\(playItems)") { (node, _) in
//            node.removeFromParent()
//        }
//    }
//    
//


 
 
    @objc private func settingsButtonAction() {
        guard popupActive == false else { return }
        resultTransfer?(.updateScoreBackEnd)
    }
    
    @objc private func backHomeAction() {
        guard popupActive == false else { return }
        resultTransfer?(.gameBack)
    }
    
    @objc private func backButtonAction() {
        guard popupActive == false else { return }
        resultTransfer?(.back)
    }
    
    @objc private func dropButtonButtonAction() {
        guard popupActive == false else { return }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA
        let bodyB = contact.bodyB

        if (bodyA.categoryBitMask == 0x1 << 1 && bodyB.categoryBitMask == 0x1 << 2) ||
           (bodyA.categoryBitMask == 0x1 << 2 && bodyB.categoryBitMask == 0x1 << 1) {
            let cupBody = bodyA.categoryBitMask == 0x1 << 1 ? bodyA : bodyB
            let otherBody = cupBody == bodyA ? bodyB : bodyA
            
            if let nodeName = otherBody.node?.name {
                switch nodeName {
                case "imgPointsG":
                    collidedWithImgPointsG = true
                    var pointsToAdd = 1
                    if doublePointsActive {
                        pointsToAdd *= 2
                    }
                    points += pointsToAdd
                    pointsLabel.text = "\(points)"
                    otherBody.node?.removeFromParent()
                case "imgCoinsG":
                    coints += 1
                    cointsLabel.text = "\(coints)"
                    otherBody.node?.removeFromParent()
                case "imgTrash10":
                    if coints > 0 {
                            coints -= 1
                        hasCollidedWithTrash = true
                        }
                    cointsLabel.text = "\(coints)"
                    otherBody.node?.removeFromParent()
                case "imgTrashA":
                    if coints > 0 {
                            coints -= 1
                        hasCollidedWithTrash = true
                        }
                    cointsLabel.text = "\(coints)"
                    otherBody.node?.removeFromParent()
                case "imgTrashJ":
                    if coints > 0 {
                            coints -= 1
                        hasCollidedWithTrash = true
                        }
                    cointsLabel.text = "\(coints)"
                    otherBody.node?.removeFromParent()
                case "imgTrashK":
                    if coints > 0 {
                            coints -= 1
                        hasCollidedWithTrash = true
                        }
                    cointsLabel.text = "\(coints)"
                    otherBody.node?.removeFromParent()
                case "imgTrashQ":
                    if coints > 0 {
                            coints -= 1
                        hasCollidedWithTrash = true
                        }
                    cointsLabel.text = "\(coints)"
                    otherBody.node?.removeFromParent()
                case "imgTimeG":
                    collidedWithImgTimeG = true
                    recalculateProgress(additionalTime: 3)
                    otherBody.node?.removeFromParent()
                default:
                    break
                }
            }

        }
    }

    func recalculateProgress(additionalTime: TimeInterval) {
        progressBarFill.removeAllActions()

        let currentProgress = progressBarFill.size.width / progressBarBackground.size.width
        let currentTime = currentProgress * CGFloat(spawnDuration)

        spawnDuration += additionalTime

        let newRemainingTime = spawnDuration - currentTime

        let newWidth = progressBarBackground.size.width * (currentTime + newRemainingTime) / CGFloat(spawnDuration)
        let resizeAction = SKAction.resize(toWidth: newWidth, duration: TimeInterval(newRemainingTime))
        progressBarFill.run(resizeAction)
    }

   
}

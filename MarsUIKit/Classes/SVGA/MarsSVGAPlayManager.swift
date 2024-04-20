//
//  MarsSVGAPlayManager.swift
//  MarsUIKit
//
//  Created by Teng Fei on 2022/5/14.
//

#if os(iOS)
import UIKit
#if canImport(SVGAPlayer)
import SVGAPlayer

@objc public protocol MarsSVGAPlayPresentable: AnyObject {
    var svgaPlayer: SVGAPlayer? { get set }
}

public class MarsSVGAPlayManager: NSObject, MarsSVGAPlayPresentable {
    
    @objc public static let shared = MarsSVGAPlayManager()
    
    @objc public private(set) var svgaParser: SVGAParser!
    
    @objc public weak var svgaPlayer: SVGAPlayer? {
        didSet {
            svgaPlayer?.delegate = self
        }
    }
    
    private override init() {
        svgaParser = SVGAParser()
    }
    
    /// The handler for finishing animation.
    @objc public var onFinishAnimationHandler: (() -> Void)?
    /// The handler for animating to percentage.
    @objc public var onSvgaAnimatedToPercentageHandler: ((_ percentage: CGFloat) -> Void)?
    
    /// The operations currently in the queue.
    @objc public var operations: [MarsSVGAPlayOperation] = []
    
    @objc public private(set) var currOp: MarsSVGAPlayOperation?
    /// The count of retries is 3.
    private var retryCount: Int8 = 3
    private var animFinished: Bool = false
    private let sema = DispatchSemaphore(value: 1)
    
    /// queue.operations: expression of type '[Operation]' is unused.
    private lazy var queue: OperationQueue = {
        let queue = OperationQueue.init()
        queue.maxConcurrentOperationCount = 1
        queue.name = "mars.play.svga.queue"
        return queue
    }()
    
    /// Gets an operation queue that has already been created.
    @objc public var opQueue: OperationQueue { queue }
    
    @objc public func setSVGAPlayer(_ player: SVGAPlayer?) {
        self.svgaPlayer = player
    }
    
    @objc public func play(url: String?, loops: Int = 1, clearsAfterStop: Bool = true) {
        configSVGAPlayer(loops, clearsAfterStop)
        let operation = MarsSVGAPlayOperation.create(withUrl: url) { [unowned self] op in
            self.play(with: op)
        }
        // Add operation to the array(`operations`).
        operations.append(operation)
        queue.addOperation(operation)
    }
    
    @objc public func play(named: String?, inBundle bundle: Bundle? = nil, loops: Int = 1, clearsAfterStop: Bool = true) {
        configSVGAPlayer(loops, clearsAfterStop)
        let operation = MarsSVGAPlayOperation.create(withName: named, inBundle: bundle) { [unowned self] op in
            self.play(with: op)
        }
        // Add operation to the array(`operations`).
        operations.append(operation)
        queue.addOperation(operation)
    }
    
    private func configSVGAPlayer(_ loops: Int, _ clearsAfterStop: Bool) {
        if let player = svgaPlayer {
            let lps: Int32 = Int32(loops)
            if player.loops != lps {
                player.loops = lps
            }
            if player.clearsAfterStop != clearsAfterStop {
                player.clearsAfterStop = clearsAfterStop
            }
        }
    }
    
    private func play(with op: MarsSVGAPlayOperation) {
        self.currOp = op
        if let url = op.svgaUrl, !url.isEmpty {
            svgaParser.parse(with: URL(string: url)!) { [unowned self] videoItem in
                self.startAnimation(with: videoItem)
            } failureBlock: { [unowned self] error in
                if let err = error {
                    debugPrint("[E] error=\(err)")
                }
                self.retryToPlay(with: op)
            }
        } else if let name = op.svgaName, !name.isEmpty {
            svgaParser.parse(withNamed: name, in: op.inBundle) { [unowned self] videoItem in
                self.startAnimation(with: videoItem)
            } failureBlock: { [unowned self] error in
                debugPrint("[E] error=\(error)")
                self.retryToPlay(with: op)
            }
        } else {
            finishAnimating()
        }
    }
    
    private func retryToPlay(with op: MarsSVGAPlayOperation) {
        if retryCount == 0 {
            finishAnimating()
        } else {
            retryCount -= 1
            play(with: op)
        }
    }
    
    @objc public func pause() {
        svgaPlayer?.pauseAnimation()
    }
    
    @objc public func step(toFrame frame: Int, andPlay play: Bool) {
        svgaPlayer?.step(toFrame: frame, andPlay: play)
    }
    
    @objc public func step(toPercentage percentage: CGFloat, andPlay play: Bool) {
        svgaPlayer?.step(toPercentage: percentage, andPlay: play)
    }
    
    @objc public func finishAnimating() {
        sema.wait()
        retryCount = 3
        if let op = currOp {
            operations.removeAll { $0 === op }
            self.currOp?.finish()
            self.currOp = nil
        }
        if animFinished {
            animFinished = false
        } else {
            DispatchQueue.main.async {
                self.clear()
            }
        }
        DispatchQueue.main.async {
            self.svgaPlayer?.isHidden = true
        }
        sema.signal()
    }
    
    private func startAnimation(with videoItem: SVGAVideoEntity?) {
        self.svgaPlayer?.isHidden = false
        self.svgaPlayer?.videoItem = videoItem
        self.svgaPlayer?.startAnimation()
    }
    
    private func clear() {
        svgaPlayer?.stopAnimation()
        if svgaPlayer?.clearsAfterStop == false {
            svgaPlayer?.clear()
        }
    }
    
}

extension MarsSVGAPlayManager: SVGAPlayerDelegate {
    
    public func svgaPlayerDidFinishedAnimation(_ player: SVGAPlayer!) {
        animFinished = true
        onFinishAnimationHandler?()
        finishAnimating()
    }
    
    public func svgaPlayer(_ player: SVGAPlayer!, didAnimatedToPercentage percentage: CGFloat) {
        onSvgaAnimatedToPercentageHandler?(percentage)
    }
    
}

extension SVGAPlayer {
    
    open override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView == self {
            return nil
        }
        return hitView
    }
    
}

#endif
#endif

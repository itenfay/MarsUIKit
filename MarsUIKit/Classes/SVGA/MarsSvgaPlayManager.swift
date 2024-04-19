//
//  MarsSvgaPlayManager.swift
//  MarsUIKit
//
//  Created by Teng Fei on 2022/5/14.
//

#if os(iOS)
import UIKit
#if canImport(SVGAPlayer)
import SVGAPlayer

@objc public protocol MarsSvgaPlayPresentable: AnyObject {
    var svgaPlayer: SVGAPlayer? { get set }
}

public class MarsSvgaPlayManager: NSObject, MarsSvgaPlayPresentable {
    
    @objc public static let shared = MarsSvgaPlayManager()
    
    @objc public private(set) var svgaParser: SVGAParser!
    
    @objc public weak var svgaPlayer: SVGAPlayer? {
        didSet {
            svgaPlayer?.delegate = self
        }
    }
    
    private override init() {
        svgaParser = SVGAParser()
    }
    
    @objc public var onSvgaAnimatedToPercentageHandler: ((_ percentage: CGFloat) -> Void)?
    
    /// The operations currently in the queue.
    @objc public var operations: [MarsSvgaPlayOperation] = []
    
    private var currOp: MarsSvgaPlayOperation?
    /// The count of retries is 3.
    private var retryCount: Int8 = 3
    private var animFinished: Bool = false
    private let sema = DispatchSemaphore(value: 1)
    
    /// queue.operations: expression of type '[Operation]' is unused.
    private lazy var queue: OperationQueue = {
        let queue = OperationQueue.init()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    @objc public func setSVGAPlayer(_ player: SVGAPlayer?) {
        self.svgaPlayer = player
    }
    
    @objc public func play(url: String?, loops: Int = 1, clearsAfterStop: Bool = true) {
        configSVGAPlayer(loops, clearsAfterStop)
        let operation = MarsSvgaPlayOperation.create(withUrl: url) { [unowned self] op in
            self.play(with: op)
        }
        // Add operation to the array(`operations`).
        operations.append(operation)
        queue.addOperation(operation)
    }
    
    @objc public func play(named: String?, inBundle bundle: Bundle? = nil, loops: Int = 1, clearsAfterStop: Bool = true) {
        configSVGAPlayer(loops, clearsAfterStop)
        let operation = MarsSvgaPlayOperation.create(withName: named, inBundle: bundle) { [unowned self] op in
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
    
    private func play(with op: MarsSvgaPlayOperation) {
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
    
    private func retryToPlay(with op: MarsSvgaPlayOperation) {
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

extension MarsSvgaPlayManager: SVGAPlayerDelegate {
    
    public func svgaPlayerDidFinishedAnimation(_ player: SVGAPlayer!) {
        animFinished = true
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

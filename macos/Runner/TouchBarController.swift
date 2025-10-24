import Cocoa
import FlutterMacOS

@available(macOS 10.12.2, *)
class TouchBarController: NSObject {
    private var channel: FlutterMethodChannel?
    private var customTouchBar: NSTouchBar?
    
    // TouchBar item identifiers
    private let iconIdentifier = NSTouchBarItem.Identifier("Icon")
    private let elapsedTimeIdentifier = NSTouchBarItem.Identifier("ElapsedTime")
    private let playPauseIdentifier = NSTouchBarItem.Identifier("PlayPause")
    private let progressIdentifier = NSTouchBarItem.Identifier("Progress")
    private let totalTimeIdentifier = NSTouchBarItem.Identifier("TotalTime")
    
    // Current state
    private var isPlaying = false
    private var currentPosition: Double = 0.0
    private var totalDuration: Double = 0.0
    private var currentTitle = ""
    private var hasQueue = false
    private var showRemainingTime = false
    private var logoUrl: String = ""
    
    // UI Elements
    private var playPauseButton: NSButton?
    private var progressSlider: NSSlider?
    private var elapsedTimeLabel: NSTextField?
    private var totalTimeButton: NSButton?
    private var iconView: NSImageView?
    private var isScrubbing = false
    private var scrubPreviewTime: Double = 0.0
    
    init(channel: FlutterMethodChannel) {
        super.init()
        self.channel = channel
        setupTouchBar()
    }
    
    private func setupTouchBar() {
        customTouchBar = NSTouchBar()
        customTouchBar?.delegate = self
        updateTouchBarLayout()
        
        // Set TouchBar on main window
        DispatchQueue.main.async {
            if let window = NSApplication.shared.mainWindow {
                window.touchBar = self.customTouchBar
            }
        }
    }
    
    private func updateTouchBarLayout() {
        customTouchBar?.defaultItemIdentifiers = [
            iconIdentifier,
            playPauseIdentifier,
            elapsedTimeIdentifier,
            progressIdentifier,
            totalTimeIdentifier
        ]
    }
    
    func updatePlaybackState(isPlaying: Bool, position: Double, duration: Double, title: String, hasQueue: Bool, logoUrl: String) {
        self.isPlaying = isPlaying
        self.currentPosition = position
        self.totalDuration = duration
        self.currentTitle = title
        self.hasQueue = hasQueue
        self.logoUrl = logoUrl
        
        DispatchQueue.main.async {
            self.updateUIElements()
            self.updateIconFromURL()
        }
    }
    
    func updateProgress(position: Double, duration: Double) {
        self.currentPosition = position
        self.totalDuration = duration
        
        DispatchQueue.main.async {
            if !self.isScrubbing {
                let progress = duration > 0 ? position / duration : 0.0
                self.progressSlider?.doubleValue = progress
            }
            self.elapsedTimeLabel?.stringValue = self.formatTime(position)
            self.updateTotalTimeLabel()
        }
    }
    
    private func formatTime(_ seconds: Double) -> String {
        let totalSeconds = Int(seconds)
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let secs = totalSeconds % 60
        
        if hours > 0 {
            return String(format: "%d:%02d:%02d", hours, minutes, secs)
        } else {
            return String(format: "%d:%02d", minutes, secs)
        }
    }
    
    private func updateTotalTimeLabel() {
        let timeText: String
        
        if showRemainingTime {
            let remainingTime: Double
            if isScrubbing {
                // During scrubbing, show remaining time from scrub position
                remainingTime = max(0, totalDuration - scrubPreviewTime)
            } else {
                // Normal remaining time from current position
                remainingTime = max(0, totalDuration - currentPosition)
            }
            timeText = "-" + formatTime(remainingTime)
        } else {
            timeText = formatTime(totalDuration)
        }
        
        // Update the clickable time button with white text color
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: NSColor.white,
            .font: NSFont.monospacedDigitSystemFont(ofSize: 16, weight: .regular)
        ]
        totalTimeButton?.attributedTitle = NSAttributedString(string: timeText, attributes: attributes)
    }
    
    private func updateIconFromURL() {
        guard let iconView = iconView, !logoUrl.isEmpty else { return }
        
        // Load image from URL asynchronously
        if let url = URL(string: logoUrl) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, 
                      let image = NSImage(data: data) else {
                    return
                }
                
                DispatchQueue.main.async {
                    // Calculate TouchBar height and resize image to fit with aspect fill
                    let touchBarHeight: CGFloat = 30 // Standard TouchBar height
                    let aspectRatio = image.size.width / image.size.height
                    let targetSize = NSSize(width: touchBarHeight * aspectRatio, height: touchBarHeight)
                    
                    let resizedImage = NSImage(size: targetSize)
                    resizedImage.lockFocus()
                    image.draw(in: NSRect(origin: .zero, size: targetSize))
                    resizedImage.unlockFocus()
                    
                    iconView.image = resizedImage
                }
            }.resume()
        }
    }
    
    private func updateUIElements() {
        // Update play/pause button with consistent styling
        let imageName = isPlaying ? "pause.fill" : "play.fill"
        if #available(macOS 11.0, *) {
            let config = NSImage.SymbolConfiguration(pointSize: 16, weight: .medium)
            let image = NSImage(systemSymbolName: imageName, accessibilityDescription: nil)?.withSymbolConfiguration(config)
            image?.isTemplate = true
            playPauseButton?.image = image
        } else {
            // Fallback for older macOS versions
            let image = isPlaying ? NSImage(named: "NSStopProgressTemplate") : NSImage(named: "NSRightFacingTriangleTemplate")
            image?.isTemplate = true
            playPauseButton?.image = image
        }
        
        // Update progress slider
        if !isScrubbing {
            let progress = totalDuration > 0 ? currentPosition / totalDuration : 0.0
            progressSlider?.doubleValue = progress
        }
        
        // Update time labels
        elapsedTimeLabel?.stringValue = formatTime(currentPosition)
        updateTotalTimeLabel()
        
        // Update TouchBar layout
        updateTouchBarLayout()
    }
    
    func setVisible(_ visible: Bool) {
        DispatchQueue.main.async {
            if let window = NSApplication.shared.mainWindow {
                window.touchBar = visible ? self.customTouchBar : nil
            }
        }
    }
    
    func clear() {
        isPlaying = false
        currentPosition = 0.0
        totalDuration = 0.0
        currentTitle = ""
        hasQueue = false
        showRemainingTime = false
        
        DispatchQueue.main.async {
            self.updateUIElements()
        }
    }
    
    // TouchBar actions
    @objc private func playPauseAction(_ sender: Any) {
        channel?.invokeMethod("onPlayPause", arguments: nil)
    }
    
    @objc private func toggleTimeDisplay(_ sender: Any) {
        showRemainingTime.toggle()
        updateTotalTimeLabel()
    }
    
    @objc private func progressSliderChanged(_ sender: NSSlider) {
        let progress = sender.doubleValue
        let seekPosition = totalDuration * progress
        
        // Start scrubbing if not already scrubbing
        if !isScrubbing {
            isScrubbing = true
            updateTouchBarLayout()
        }
        
        // Update preview time during scrubbing
        scrubPreviewTime = seekPosition
        
        // Update elapsed time to show scrub preview
        elapsedTimeLabel?.stringValue = formatTime(seekPosition)
        
        // Update total time (will show updated remaining time if in remaining mode)
        updateTotalTimeLabel()
        
        // Send seek position to Flutter (expecting position in seconds)
        channel?.invokeMethod("onSeek", arguments: seekPosition)
        
        // Cancel any existing timer and set a new one to end scrubbing
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(endScrubbing), object: nil)
        perform(#selector(endScrubbing), with: nil, afterDelay: 0.5)
    }
    
    @objc private func endScrubbing() {
        isScrubbing = false
        updateTotalTimeLabel()
    }

}

@available(macOS 10.12.2, *)
extension TouchBarController: NSTouchBarDelegate {
    
    func touchBar(_ touchBar: NSTouchBar, makeItemForIdentifier identifier: NSTouchBarItem.Identifier) -> NSTouchBarItem? {
        
        switch identifier {
        case iconIdentifier:
            let item = NSCustomTouchBarItem(identifier: identifier)
            let imageView = NSImageView()
            
            // Start with fallback icon
            if #available(macOS 11.0, *) {
                imageView.image = NSImage(systemSymbolName: "tv", accessibilityDescription: "Media")
            } else {
                imageView.image = NSImage(named: "NSMenuOnStateTemplate")
            }
            
            imageView.imageScaling = .scaleProportionallyDown
            imageView.imageAlignment = .alignCenter
            
            item.view = imageView
            iconView = imageView
            return item
            
        case elapsedTimeIdentifier:
            let item = NSCustomTouchBarItem(identifier: identifier)
            let label = NSTextField(labelWithString: formatTime(currentPosition))
            label.textColor = .white
            label.font = NSFont.monospacedDigitSystemFont(ofSize: 16, weight: .regular)
            label.alignment = .right
            
            // Prevent expansion of time labels
            label.setContentHuggingPriority(.required, for: .horizontal)
            label.setContentCompressionResistancePriority(.required, for: .horizontal)
            
            item.view = label
            elapsedTimeLabel = label
            return item
            
        case playPauseIdentifier:
            let imageName = isPlaying ? "pause.fill" : "play.fill"
            let image: NSImage?
            
            if #available(macOS 11.0, *) {
                let config = NSImage.SymbolConfiguration(pointSize: 16, weight: .medium)
                image = NSImage(systemSymbolName: imageName, accessibilityDescription: nil)?.withSymbolConfiguration(config)
            } else {
                image = isPlaying ? NSImage(named: "NSStopProgressTemplate") : NSImage(named: "NSRightFacingTriangleTemplate")
            }
            
            // Use NSCustomTouchBarItem for full control over sizing
            let item = NSCustomTouchBarItem(identifier: identifier)
            
            // Create container view for proper padding
            let containerView = NSView()
            let button = NSButton(image: image ?? NSImage(), target: self, action: #selector(playPauseAction))
            
            // Configure button appearance
            button.image?.isTemplate = true
            button.contentTintColor = .white
            
            // Setup view hierarchy and constraints
            containerView.addSubview(button)
            item.view = containerView
            
            button.translatesAutoresizingMaskIntoConstraints = false
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 32),
                button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                containerView.widthAnchor.constraint(equalToConstant: 32)
            ])
            
            // High priority to resist expansion
            containerView.setContentHuggingPriority(.required, for: .horizontal)
            containerView.setContentCompressionResistancePriority(.required, for: .horizontal)
            
            playPauseButton = button
            return item
            
        case progressIdentifier:
            let item = NSCustomTouchBarItem(identifier: identifier)
            let slider = NSSlider(target: self, action: #selector(progressSliderChanged(_:)))
            slider.minValue = 0.0
            slider.maxValue = 1.0
            slider.doubleValue = totalDuration > 0 ? currentPosition / totalDuration : 0.0
            slider.isContinuous = true
            slider.sliderType = .linear
            
            // TouchBar slider styling
            slider.controlSize = .regular
            slider.trackFillColor = NSColor.controlAccentColor
            
            // Create container for proper expansion control
            let containerView = NSView()
            containerView.addSubview(slider)
            
            // Set constraints to make slider fill container and expand
            slider.translatesAutoresizingMaskIntoConstraints = false
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                slider.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                slider.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                slider.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            ])
            
            // Set very low priorities to maximize expansion
            slider.setContentHuggingPriority(.init(1), for: .horizontal)
            slider.setContentCompressionResistancePriority(.init(1), for: .horizontal)
            containerView.setContentHuggingPriority(.init(1), for: .horizontal)
            containerView.setContentCompressionResistancePriority(.init(1), for: .horizontal)
            
            item.view = containerView
            progressSlider = slider
            return item
            
        case totalTimeIdentifier:
            let item = NSCustomTouchBarItem(identifier: identifier)
            
            // Create a button that looks like a label but is clickable
            let button = NSButton(title: formatTime(totalDuration), target: self, action: #selector(toggleTimeDisplay))
            button.bezelStyle = .inline
            button.isBordered = false
            button.font = NSFont.monospacedDigitSystemFont(ofSize: 16, weight: .regular)
            
            // Set white text color using attributed title
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: NSColor.white,
                .font: NSFont.monospacedDigitSystemFont(ofSize: 16, weight: .regular)
            ]
            button.attributedTitle = NSAttributedString(string: formatTime(totalDuration), attributes: attributes)
            
            // Prevent expansion of time labels
            button.setContentHuggingPriority(.required, for: .horizontal)
            button.setContentCompressionResistancePriority(.required, for: .horizontal)
            
            item.view = button
            totalTimeButton = button
            
            return item
            
        default:
            return nil
        }
    }
}


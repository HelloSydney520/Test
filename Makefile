bootstrap: 
	pod install
	sudo gem install xcpretty

test-all:
	xcodebuild \
	 -workspace Test.xcworkspace \
	 -scheme Test \
	 -derivedDataPath Build/ \
	 -sdk iphonesimulator \
	 -destination 'platform=iOS Simulator,name=iPhone 11' \
	 -enableCodeCoverage YES \
	 test | xcpretty


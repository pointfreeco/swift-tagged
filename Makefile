xcodeproj:
	PF_DEVELOP=1 swift run xcodegen

linux-main:
	swift test --generate-linuxmain

test-linux:
	docker build --tag tagged-testing . \
		&& docker run --rm tagged-testing

test-macos:
	set -o pipefail && \
	xcodebuild test \
		-scheme Tagged_macOS \
		-destination platform="macOS" \
		-derivedDataPath ./.derivedData \
		| xcpretty

test-ios:
	set -o pipefail && \
	xcodebuild test \
		-scheme Tagged_iOS \
		-destination platform="iOS Simulator,name=iPhone 11 Pro Max,OS=13.2.2" \
		| xcpretty

test-swift:
	swift test -v

test-playgrounds: test-macos
	find . \
		-path '*.playground/*' \
		-name '*.swift' \
		-exec swift -F .derivedData/Build/Products/Debug/ -suppress-warnings {} +

test-all: test-linux test-macos test-ios test-playgrounds

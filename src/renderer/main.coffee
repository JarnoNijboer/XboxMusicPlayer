AppWebview = require './appwebview'

class Bootstrap
	constructor: ->
		@webviewId = 'wvAppHost'

		@webview = new AppWebview(@webviewId)

		@webview.on 'did-start-loading', @hideLoader

	hideLoader: ->
		appHost = document.getElementById 'appHost'

		if appHost.classList.contains 'hide'
			appHost.classList.remove 'hide'

		loader = document.getElementById 'loader'

		if not loader.classList.contains 'hide'
			loader.classList.add 'hide'

module.exports = new Bootstrap()

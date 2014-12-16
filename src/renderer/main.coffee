class Bootstrap
	constructor: ->
		@webview = document.getElementById 'wvAppHost'

		@webview.addEventListener 'did-start-loading', @handleOnWebviewLoad()
		@webview.addEventListener 'did-finish-loading', @handleWebviewLoad()

	handleOnWebviewLoad: ->
		@hideLoader()

	handleWebviewLoad: ->
		# setTimeout @webview.openDevTools, 500

	hideLoader: ->
		appHost = document.getElementById 'appHost'

		if appHost.classList.contains 'hide'
			appHost.classList.remove 'hide'

		loader = document.getElementById 'loader'

		if not loader.classList.contains 'hide'
			loader.classList.add 'hide'

module.exports = new Bootstrap()

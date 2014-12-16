class Bootstrap
	constructor: ->
		@self = this
		@webview = document.getElementById 'wvAppHost'

		@webview.addEventListener 'did-start-loading', ->
			@self.handleWebviewLoad()

	handleWebviewLoad: ->
		@hideLoader()
		# @webview.openDevTools()

		# @webview.addEventListener 'did-start-loading', (e) -> @handleWebviewLoad()

	hideLoader: ->
		appHost = document.getElementById 'appHost'

		if appHost.classList.contains 'hide'
			appHost.classList.remove 'hide'

		loader = document.getElementById 'loader'

		if not loader.classList.contains 'hide'
			loader.classList.add 'hide'

module.exports = new Bootstrap()

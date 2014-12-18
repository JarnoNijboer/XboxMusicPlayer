shell = require 'shell'
ipc = require 'ipc'

_ = require 'underscore-plus'
{EventEmitter} = require 'events'

module.exports =
class AppWebview
	_.extend @prototype, EventEmitter.prototype

	constructor: (webviewId) ->
		if not webviewId
			throw new Exception 'webviewId param is not defined'

		@webviewId = webviewId
		@webview = document.getElementById @webviewId

		handleWebviewEvents(@, @webview)
		handleShortcuts(@webview)

	handleWebviewEvents = (appWebview, webview) ->
		webview.addEventListener 'console-message', (e) ->
			console.log 'xbox-music logged a message: ', e.message

		webview.addEventListener 'new-window', (e) ->
			shell.openExternal e.url

		webview.addEventListener 'close', ->
			webview.src = 'about:blank'

		webview.addEventListener 'did-start-loading', (e) ->
			appWebview.emit 'did-start-loading', e

	handleShortcuts = (webview) ->
		ipc.on 'app-shortcut', (keyAction) ->
			webview.send 'web-shortcut', keyAction

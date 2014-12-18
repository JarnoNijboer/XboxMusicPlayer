globalShortcut = require 'global-shortcut'
ipc = require 'ipc'

{EventEmitter} = require 'events'
_ = require 'underscore-plus'

module.exports =
class AppShortcut
	_.extend @prototype, EventEmitter.prototype

	constructor: (window) ->
		if not window
			throw new Exception 'window param is not defined'

		@window = window

		@keys = [
			{
				keyCode: 'MediaNextTrack'
				action: 'music-next-track'
			}, {
				keyCode: 'MediaPreviousTrack'
				action: 'music-previous-track'
			}, {
				keyCode: 'MediaPlayPause'
				action: 'music-play-pause'
			}
		]

	registerAll: ->
		@register key for key in @keys

	unregisterAll: ->
		globalShortcut.unregisterAll()

	register: (key) ->
		globalShortcut.register key.keyCode, ->
			@window.webContents.send 'app-shortcut', key.action

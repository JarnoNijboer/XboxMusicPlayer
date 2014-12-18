Menu = require 'menu'
app = require 'app'
fs = require 'fs'
ipc = require 'ipc'
path = require 'path'
os = require 'os'
net = require 'net'
url = require 'url'

{EventEmitter} = require 'events'
_ = require 'underscore-plus'
{spawn} = require 'child_process'

AppMenu = require './appmenu'
AppWindow = require './appwindow'
AppShortcut = require './appshortcut'

module.exports =
class Application
	_.extend @prototype, EventEmitter.prototype

	constructor: (options) ->
		{@resourcePath, @version, @devMode } = options

		@pkgJson = require '../../package.json'

		@window = new AppWindow(options)
		@menu = new AppMenu(pkg: @pkgJson)
		@shortcut = new AppShortcut(@window)

		@window.on 'closed', (e) ->
			@shortcut.unregisterAll()
			app.quit()

		@window.show()

		@menu.attachToWindow @window
		@handleMenuItems(@menu, @window)

		@shortcut.registerAll()

	handleMenuItems: (menu, thisWindow) ->
		menu.on 'application:quit', -> app.quit()

		menu.on 'window:reload', ->
			thisWindow.reload()

		menu.on 'window:toggle-full-screen', ->
			thisWindow.toggleFullScreen()

		menu.on 'window:toggle-dev-tools', ->
			thisWindow.toggleDevTools()

	reload: -> @window.reload()

	exit: (status) -> app.exit(status)

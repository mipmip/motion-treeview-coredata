class AppDelegate

	include MotionDataWrapper::Delegate

	def applicationDidFinishLaunching(notification)

		p Folder.all
#		groups = Folder.create folderName: 'test'
#		groups.save!

		buildMenu
		buildWindow
	end

	def buildWindow
		@mainWindowController = MainWindow.alloc.initWithWindowNibName('MainWindow')
		@mainWindowController.window.makeKeyAndOrderFront(self)
	end
end

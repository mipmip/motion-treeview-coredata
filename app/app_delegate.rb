class AppDelegate

	include MotionDataWrapper::Delegate
	
	def applicationDidFinishLaunching(notification)

		#Folder.destroy_all
		#p Folder.all
		#groups = Folder.create folderName: 'test'
		#groups = Folder.create folderName: 'test1'
		#groups = Folder.create folderName: 'test2'
		#groups = Folder.create folderName: 'test3'
		#groups = Folder.create folderName: 'test4'
		#groups = Folder.create folderName: 'test5'
#		groups.save!

		buildMenu
		buildWindow
	end

	def buildWindow
		@mainWindowController = MainWindow.alloc.initWithWindowNibName('MainWindow')
		@mainWindowController.window.makeKeyAndOrderFront(self)
	end
end

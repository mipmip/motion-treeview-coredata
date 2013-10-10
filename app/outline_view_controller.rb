class OutlineViewController < NSObject

	#include MotionDataWrapper::Delegate
	extend IB

	outlet :treeController, NSTreeController
	outlet :myOutlineView, NSOutlineView

	def saveTree(sender)
		error = Pointer.new(:object)
		App.delegate.managedObjectContext.save(error)
	end

	def outlineViewSelectionDidChange(notification)
		p "outlineViewSelectionDidChange"
		error = Pointer.new(:object)
		App.delegate.managedObjectContext.save(error)
	end

	def awakeFromNib
		@myOutlineView.setDelegate(self)
		dragType = ['factorialDragType']
		@myOutlineView.registerForDraggedTypes(dragType)
		sortDesc = NSSortDescriptor.alloc.initWithKey("folderName", ascending:true)
		@treeController.setSortDescriptors([sortDesc])
	end

	def outlineView(outlineView, writeItems: items, toPasteboard: pboard)
		p "Def: WriteItems toPasteboard)"

		dragType = ['factorialDragType']
		pboard.declareTypes(dragType, owner:self)
		@draggedNode = items.objectAtIndex(0)
		p @draggedNode
		return true
	end

	def outlineView(outlineView, acceptDrop:info, item:item, childIndex:index)
		p "def: Method acceptDrop"
		if(@draggedNode && item)
			p @draggedNode
			draggedTreeNode = @draggedNode.representedObject
			draggedTreeNode.setValue(item.representedObject, forKey:"parent")
		end

		error = Pointer.new(:object)
		App.delegate.managedObjectContext.save(error)

		return true
	end

	def category(cat, isSubCategoryOf:possibleSub)
		p "def: category"
		# Depends on your interpretation of subCategory ....
		if (cat == possibleSub) 
			return true
		end

		possSubParent = possibleSub.valueForKey("parent")
		if ( possSubParent == nil ) 
			return true
		end

		while ( possSubParent != nil ) 
			if ( possSubParent == cat ) 
				return true
			end

			#move up the tree
			possSubParent = possSubParent.valueForKey("parent")
		end

		return false
	end

	# This method gets called by the framework but
	# the values from bindings are used instead
	def outlineView(outlineView, objectValueForTableColumn:tableColumn, byItem:item)
		  return nil
	end


	def outlineView(outlineView, validateDrop:info, proposedItem:item, proposedChildIndex:index) 
		return true
		p "def: validateDrop"

		# drags to the root are always acceptable
		if ( item.nil? || item.representedObject == nil ) 
			return NSDragOperationGeneric
		end

		# Verify that we are not dragging a parent to one of it's ancestors
		# causes a parent loop where a group of nodes point to each other
		# and disappear from the control
		p "DraggedNode="
		p @draggedNode
		p @tem

		dragged = @draggedNode.representedObject
		newP =  item.representedObject
		if ( self.category(dragged, isSubCategoryOf:newP))
			return false
		end 
		return NSDragOperationGeneric
	end

	# The following are implemented as stubs because they are
	# required when implementing an NSOutlineViewDataSource.
	# Because we use bindings on the table column these methods are never called.
	# The NSLog statements have been included to prove that these methods are not called.
	def outlineView(outlineView, numberOfChildrenOfItem:item) 
		p "numberOfChildrenOfItem"
		return 1
	end

	def outlineView(outlineView, isItemExpandable:item) 
		p "isItemExpandable"
		return true
	end

	def outlineView(outlineView, child:index, ofItem:item)
		p "child of Item"
		return nil
	end
end

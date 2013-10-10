# Motion-Tree-CoreData - RubyMotion NSOutline & CoreData example
A port of the example from [Connecting NSOutlineView to Core Data in 10.6 Part 1: Ordered Trees](http://lifeasclay.wordpress.com/2011/02/13/connecting-nsoutlineview-to-core-data-in-10-6-part-1-ordered-trees/) to rubymotion.

## Features
* Native Xcode Coredata Modelling
* Native Interface Builder
* Drag and drop
* Add/delete items
* TODO: write tutorial
* TODO: save on exit
* FIXME: detect foldername changed, so it can be saved

## Notes
To make this example work I had to rename the entity `group` to folder and the attribute `name` to `folderName`. I earlier encountered problems when I had an attribute called `description`.

## Links

* [Outdated tutorial, first inspiration](http://allusions.sourceforge.net/articles/treeDragPart1.php)
* [New tutorial for OBJ-C (No ARC)](http://lifeasclay.wordpress.com/2011/02/13/connecting-nsoutlineview-to-core-data-in-10-6-part-1-ordered-trees/)

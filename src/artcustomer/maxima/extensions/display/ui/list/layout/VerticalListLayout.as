/*
 * Copyright (c) 2013 David MASSENOT - http://artcustomer.fr/
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package artcustomer.maxima.extensions.display.ui.list.layout {
	import artcustomer.maxima.extensions.display.ui.list.item.AbstractListItem;
	
	
	/**
	 * VerticalListLayout
	 * 
	 * @author David Massenot
	 */
	public class VerticalListLayout extends AbstractListLayout implements IListLayout {
		private var _margin:int;
		
		
		/**
		 * Constructor
		 */
		public function VerticalListLayout() {
			super();
		}
		
		
		/**
		 * Display items in Layout.
		 */
		public function display():void {
			if (!_displayItems) return;
			
			var i:int = 0;
			var length:int = _displayItems.length;
			var item:AbstractListItem;
			var lastItem:AbstractListItem;
			
			for (i ; i < length ; i++) {
				item = _displayItems[i];
				item.x = 0;
				item.y = 0;
				
				if (i != 0) {
					lastItem = _displayItems[i - 1];
					
					item.y = lastItem.y + lastItem.height + _margin;
				}
			}
		}
		
		/**
		 * Destructor.
		 */
		override public function destroy():void {
			_margin = 0;
			
			super.destroy();
		}
		
		
		/**
		 * @private
		 */
		public function set margin(value:int):void {
			_margin = value;
		}
		
		/**
		 * @private
		 */
		public function get margin():int {
			return _margin;
		}
	}
}
/*
 * Copyright (c) 2013 David MASSENOT - http://artcustomer.fr/
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package artcustomer.maxima.extensions.display.ui.list.layout {
	import flash.utils.getQualifiedClassName;
	
	import artcustomer.maxima.base.IDestroyable;
	import artcustomer.maxima.errors.IllegalGameError;
	import artcustomer.maxima.extensions.display.ui.list.item.AbstractListItem;
	
	
	/**
	 * AbstractListLayout
	 * 
	 * @author David Massenot
	 */
	public class AbstractListLayout implements IDestroyable {
		private static const FULL_CLASS_NAME:String = 'artcustomer.maxima.extensions.display.ui.list.item::AbstractListItem';
		
		protected var _displayItems:Vector.<AbstractListItem>;
		
		
		/**
		 * Constructor
		 */
		public function AbstractListLayout() {
			if (getQualifiedClassName(this) == FULL_CLASS_NAME) throw new IllegalGameError(IllegalGameError.E_ABSTRACT_CLASS);
		}
		
		
		/**
		 * Destructor
		 */
		public function destroy():void {
			_displayItems = null;
		}
		
		
		/**
		 * @private
		 */
		public function set displayItems(value:Vector.<AbstractListItem>):void {
			_displayItems = value;
		}
		
		/**
		 * @private
		 */
		public function get displayItems():Vector.<AbstractListItem> {
			return _displayItems;
		}
	}
}
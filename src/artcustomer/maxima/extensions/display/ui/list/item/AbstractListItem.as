/*
 * Copyright (c) 2013 David MASSENOT - http://artcustomer.fr/
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package artcustomer.maxima.extensions.display.ui.list.item {
	import flash.display.Sprite;
	import flash.utils.getQualifiedClassName;
	
	import artcustomer.maxima.base.IDestroyable;
	import artcustomer.maxima.errors.IllegalGameError;
	import artcustomer.maxima.utils.tools.StringTools;
	import artcustomer.maxima.extensions.events.MenuListEvent;
	import artcustomer.maxima.extensions.display.ui.list.data.AbstractListItemValueObject;
	
	
	/**
	 * AbstractListItem
	 * 
	 * @author David Massenot
	 */
	public class AbstractListItem extends Sprite implements IDestroyable {
		private static const FULL_CLASS_NAME:String = 'artcustomer.maxima.extensions.display.ui.list.item::AbstractListItem';
		
		private var _valueObject:AbstractListItemValueObject;
		
		
		/**
		 * Constructor
		 */
		public function AbstractListItem() {
			if (getQualifiedClassName(this) == FULL_CLASS_NAME) throw new IllegalGameError(IllegalGameError.E_ABSTRACT_CLASS);
		}
		
		//---------------------------------------------------------------------
		//  Event Dispatching
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function dispatchMenuListEvent(type:String):void {
			this.dispatchEvent(new MenuListEvent(type, true, false, _valueObject));
		}
		
		
		/**
		 * Entry point. Override it !
		 */
		public function setup():void {
			
		}
		
		/**
		 * Destructor. Override it !
		 */
		public function destroy():void {
			_valueObject = null;
		}
		
		/**
		 * Update. Override it !
		 */
		public function update():void {
			
		}
		
		/**
		 * Select item. Override it !
		 */
		public function select():void {
			dispatchMenuListEvent(MenuListEvent.ON_SELECT_ITEM);
		}
		
		/**
		 * Focus item. Override it !
		 */
		public function focus():void {
			dispatchMenuListEvent(MenuListEvent.ON_FOCUS_ITEM);
		}
		
		/**
		 * Unfocus item. Override it !
		 */
		public function unfocus():void {
			dispatchMenuListEvent(MenuListEvent.ON_UNFOCUS_ITEM);
		}
		
		
		/**
		 * Get String format of object.
		 * 
		 * @return
		 */
		override public function toString():String {
			return StringTools.formatToString(this, 'AbstractListItem', 'valueObject');
		}
		
		
		/**
		 * @private
		 */
		public function get valueObject():AbstractListItemValueObject {
			return _valueObject;
		}
		
		/**
		 * @private
		 */
		public function set valueObject(value:AbstractListItemValueObject):void {
			_valueObject = value;
		}
	}
}
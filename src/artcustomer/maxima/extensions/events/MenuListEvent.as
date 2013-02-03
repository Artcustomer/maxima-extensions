/*
 * Copyright (c) 2013 David MASSENOT - http://artcustomer.fr/
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package artcustomer.maxima.extensions.events {
	import flash.events.Event;
	
	import artcustomer.maxima.extensions.display.ui.list.data.AbstractListItemValueObject;
	
	
	/**
	 * MenuListEvent
	 * 
	 * @author David Massenot
	 */
	public class MenuListEvent extends Event {
		public static const ON_FOCUS_ITEM:String = 'onFocusItem';
		public static const ON_UNFOCUS_ITEM:String = 'onUnfocusItem';
		public static const ON_SELECT_ITEM:String = 'onSelectItem';
		public static const ON_LIST_CHANGE:String = 'onListChange';
		
		private var _valueObject:AbstractListItemValueObject;
		
		
		/**
		 * Constructor
		 * 
		 * @param	type
		 * @param	bubbles
		 * @param	cancelable
		 * @param	valueObject
		 */
		public function MenuListEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false, valueObject:AbstractListItemValueObject = null) {
			_valueObject = valueObject;
			
			super(type, bubbles, cancelable);
		}
		
		/**
		 * Clone MenuListEvent.
		 * 
		 * @return
		 */
		public override function clone():Event {
			return new MenuListEvent(type, bubbles, cancelable, _valueObject);
		}
		
		/**
		 * Get String format of MenuListEvent.
		 * 
		 * @return
		 */
		public override function toString():String {
			return formatToString("MenuListEvent", "type", "bubbles", "cancelable", "eventPhase", "valueObject"); 
		}
		
		
		/**
		 * @private
		 */
		public function get valueObject():AbstractListItemValueObject {
			return _valueObject;
		}
	}
}
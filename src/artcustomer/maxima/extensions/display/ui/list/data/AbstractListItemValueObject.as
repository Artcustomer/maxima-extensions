/*
 * Copyright (c) 2013 David MASSENOT - http://artcustomer.fr/
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package artcustomer.maxima.extensions.display.ui.list.data {
	import flash.utils.getQualifiedClassName;
	
	import artcustomer.maxima.base.IDestroyable;
	import artcustomer.maxima.errors.IllegalGameError;
	import artcustomer.maxima.utils.tools.StringTools;
	
	
	/**
	 * AbstractListItemValueObject
	 * 
	 * @author David Massenot
	 */
	public class AbstractListItemValueObject implements IDestroyable {
		private static const FULL_CLASS_NAME:String = 'artcustomer.maxima.extensions.display.ui.list.data::AbstractListItemValueObject';
		
		private var _index:int;
		
		
		/**
		 * Constructor
		 */
		public function AbstractListItemValueObject() {
			if (getQualifiedClassName(this) == FULL_CLASS_NAME) throw new IllegalGameError(IllegalGameError.E_ABSTRACT_CLASS);
		}
		
		
		/**
		 * Destructor.
		 */
		public function destroy():void {
			_index = 0;
		}
		
		/**
		 * Get String format of object.
		 * 
		 * @return
		 */
		public function toString():String {
			return StringTools.formatToString(this, 'AbstractMenuItem', 'index');
		}
		
		
		/**
		 * @private
		 */
		public function get index():int {
			return _index;
		}
		
		/**
		 * @private
		 */
		public function set index(value:int):void {
			_index = value;
		}
	}
}
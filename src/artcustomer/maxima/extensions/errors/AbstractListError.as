/*
 * Copyright (c) 2013 David MASSENOT - http://artcustomer.fr/
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package artcustomer.maxima.extensions.errors {
	
	
	/**
	 * AbstractListError
	 * 
	 * @author David Massenot
	 */
	public class AbstractListError extends Error {
		public static const ERROR_ID:int = 30000;
		
		public static const E_LIST_ADDITEM_SUPER:String = "Item must extends AbstractListItem !";
		public static const E_LIST_ADDITEM:String = "Item can't be instantiated !";
		
		public static const E_LIST_SETLAYOUT_SUPER:String = "Layout must extends AbstractListItem !";
		public static const E_LIST_SETLAYOUT:String = "Layout can't be null !";
		
		
		/**
		 * Throw a AbstractListError.
		 * 
		 * @param	message
		 * @param	id
		 */
		public function AbstractListError(message:String = "", id:int = 0) {
			super(message, ERROR_ID + id);
		}
	}
}
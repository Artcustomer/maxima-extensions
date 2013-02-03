/*
 * Copyright (c) 2013 David MASSENOT - http://artcustomer.fr/
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package artcustomer.maxima.extensions.display.ui.list {
	import artcustomer.maxima.extensions.display.ui.list.data.AbstractListItemValueObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;
	
	import artcustomer.maxima.base.IDestroyable;
	import artcustomer.maxima.errors.IllegalGameError;
	import artcustomer.maxima.extensions.events.MenuListEvent;
	import artcustomer.maxima.extensions.errors.AbstractListError;
	import artcustomer.maxima.extensions.display.ui.list.layout.*;
	import artcustomer.maxima.extensions.display.ui.list.item.*;
	
	[Event(name = "onSelectItem", type = "artcustomer.maxima.extensions.events.MenuListEvent")]
	[Event(name = "onFocusItem", type = "artcustomer.maxima.extensions.events.MenuListEvent")]
	[Event(name = "onUnfocusItem", type = "artcustomer.maxima.extensions.events.MenuListEvent")]
	[Event(name = "onListChange", type = "artcustomer.maxima.extensions.events.MenuListEvent")]
	
	
	/**
	 * AbstractList
	 * 
	 * @author David Massenot
	 */
	public class AbstractList extends Sprite implements IDestroyable {
		private static const FULL_CLASS_NAME:String = 'artcustomer.maxima.extensions.display.ui.list::AbstractList';
		
		private var _items:Vector.<AbstractListItem>;
		
		private var _layout:IListLayout;
		
		private var _currentItem:AbstractListItem;
		private var _numItems:int;
		
		private var _iteratorIndex:int;
		
		
		/**
		 * Constructor
		 */
		public function AbstractList() {
			if (getQualifiedClassName(this) == FULL_CLASS_NAME) throw new IllegalGameError(IllegalGameError.E_ABSTRACT_CLASS);
			
			init();
			createStack();
		}
		
		//---------------------------------------------------------------------
		//  Initialize
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function init():void {
			_iteratorIndex = 0;
		}
		
		//---------------------------------------------------------------------
		//  Stack
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function createStack():void {
			_items = new Vector.<AbstractListItem>();
		}
		
		/**
		 * @private
		 */
		private function releaseStack():void {
			while (_items.length > 0) {
				_items.shift().destroy();
			}
		}
		
		/**
		 * @private
		 */
		private function destroyStack():void {
			_items = null;
		}
		
		//---------------------------------------------------------------------
		//  Items
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function updateItemIndexes():void {
			var i:int = 0;
			var item:AbstractListItem;
			
			while (i < _items.length) {
				item = _items[i];
				item.valueObject.index = i;
				
				i++;
			}
		}
		
		/**
		 * @private
		 */
		private function removeAllItems():void {
			var i:int = 0;
			var item:AbstractListItem;
			
			while (i < _items.length) {
				item = _items[i];
				
				this.removeChild(item);
				
				i++;
			}
		}
		
		/**
		 * @private
		 */
		private function toggleCurrentItem(item:AbstractListItem):void {
			if (_currentItem) _currentItem.unfocus();
			
			_currentItem = item;
			_currentItem.focus();
		}
		
		//---------------------------------------------------------------------
		//  Layout
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function displayLayout():void {
			if (_layout) _layout.display();
		}
		
		/**
		 * @private
		 */
		private function destroyLayout():void {
			if (_layout) {
				(_layout as AbstractListLayout).destroy();
				_layout = null;
			}
		}
		
		/**
		 * @private
		 */
		private function dispatchMenuListEvent(type:String):void {
			this.dispatchEvent(new MenuListEvent(type, false, false));
		}
		
		
		/**
		 * Destructor.
		 */
		public function destroy():void {
			removeAllItems();
			releaseStack();
			destroyStack();
			
			_currentItem = null;
			_numItems = 0;
			_iteratorIndex = 0;
		}
		
		/**
		 * Add item at index.
		 * 
		 * @param	itemClass
		 * @param	valueObject
		 * @param	index
		 */
		public function addItemAt(itemClass:Class, valueObject:AbstractListItemValueObject, index:int = -1):void {
			if (!itemClass is AbstractListItem) throw new AbstractListError(AbstractListError.E_LIST_ADDITEM_SUPER);
			
			var item:AbstractListItem = new itemClass();
			
			if (item) {
				item.valueObject = valueObject;
				
				if (index > -1) {
					item.valueObject.index = index;
					
					_items.splice(index, 0, item);
					
					updateItemIndexes();
					displayLayout();
				} else {
					item.valueObject.index = _numItems;
					
					_items.push(item);
				}
				
				this.addChild(item);
				
				item.setup();
				
				_numItems++;
				
				dispatchMenuListEvent(MenuListEvent.ON_LIST_CHANGE);
			} else {
				throw new AbstractListError(AbstractListError.E_LIST_ADDITEM);
			}
		}
		
		/**
		 * Remove item at index.
		 * 
		 * @param	index
		 */
		public function removeItemAt(index:int):Boolean {
			var item:AbstractListItem = this.getItemAt(index);
			
			if (item) {
				item = _items.shift();
				item.destroy();
				
				this.removeChild(item);
				
				updateItemIndexes();
				displayLayout();
				
				_numItems--;
				
				dispatchMenuListEvent(MenuListEvent.ON_LIST_CHANGE);
				
				return true;
			}
			
			return false;
		}
		
		/**
		 * Get item at index.
		 * 
		 * @param	index
		 * @return
		 */
		public function getItemAt(index:int):AbstractListItem {
			if (this.hasItemAt(index)) return _items[index];
			return null;
		}
		
		/**
		 * Test item at index.
		 * 
		 * @param	index
		 * @return
		 */
		public function hasItemAt(index:int):Boolean {
			return index >= 0 && index < _numItems;
		}
		
		/**
		 * Select current item.
		 */
		public function select():void {
			if (_currentItem) _currentItem.select();
		}
		
		/**
		 * Focus item at index.
		 * 
		 * @param	index
		 */
		public function focusAt(index:int):void {
			var item:AbstractListItem = this.getItemAt(index);
			
			if (item) {
				toggleCurrentItem(item);
				
				_iteratorIndex = index;
			}
		}
		
		/**
		 * Focus the next item.
		 */
		public function focusNext():void {
			var item:AbstractListItem;
			
			_iteratorIndex++;
			
			if (_iteratorIndex >= _numItems) _iteratorIndex = 0;
			
			item = this.getItemAt(_iteratorIndex);
			
			if (item) toggleCurrentItem(item);
		}
		
		/**
		 * Focus the previous item.
		 */
		public function focusPrevious():void {
			var item:AbstractListItem;
			
			_iteratorIndex--;
			
			if (_iteratorIndex < 0) _iteratorIndex = _numItems - 1;
			
			item = this.getItemAt(_iteratorIndex);
			
			if (item) toggleCurrentItem(item);
		}
		
		/**
		 * set Layout.
		 * 
		 * @param	layout
		 */
		public function setLayout(layout:IListLayout):void {
			if (!layout is AbstractListLayout) throw new AbstractListError(AbstractListError.E_LIST_SETLAYOUT_SUPER);
			
			if (layout) {
				destroyLayout();
				
				_layout = layout;
				(_layout as AbstractListLayout).displayItems = _items;
				
				displayLayout();
			} else {
				throw new AbstractListError(AbstractListError.E_LIST_SETLAYOUT);
			}
		}
		
		
		/**
		 * @private
		 */
		public function get layout():IListLayout {
			return _layout;
		}
		
		/**
		 * @private
		 */
		public function get numItems():int {
			return _numItems;
		}
	}
}
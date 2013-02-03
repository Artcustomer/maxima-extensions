/*
 * Copyright (c) 2013 David MASSENOT - http://artcustomer.fr/
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */

package artcustomer.maxima.extensions.display.ui.preloader {
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	
	import artcustomer.maxima.base.IDestroyable;
	
	
	/**
	 * PreloadBar
	 * 
	 * @author David Massenot
	 */
	public class PreloadBar extends Sprite implements IDestroyable {
		private var _barWidth:int;
		private var _barHeight:int;
		private var _backgroundColor:uint;
		private var _barColor:uint;
		private var _glowColor:uint;
		
		private var _backgroundBar:Shape;
		private var _preloadBar:Shape;
		
		private var _glow:GlowFilter;
		
		
		/**
		 * Constructor
		 */
		public function PreloadBar(barWidth:int = 400, barHeight:int = 2, backgroundColor:uint = 0x585858, barColor:uint = 0xF79972, glowColor:uint = 0xFFFFFF) {
			_barWidth = barWidth;
			_barHeight = barHeight;
			_backgroundColor = backgroundColor;
			_barColor = barColor;
			_glowColor = glowColor;
			
			setupBackground();
			setupBar();
			setupFilters();
			applyFilters();
			draw();
			updateBar(0);
		}
		
		//---------------------------------------------------------------------
		//  Background
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function setupBackground():void {
			_backgroundBar = new Shape();
			
			this.addChild(_backgroundBar);
		}
		
		/**
		 * @private
		 */
		private function destroyBackground():void {
			this.removeChild(_backgroundBar);
			
			_backgroundBar = null;
		}
		
		/**
		 * @private
		 */
		private function drawBackground():void {
			_backgroundBar.graphics.clear();
			_backgroundBar.graphics.beginFill(_backgroundColor, 1);
			_backgroundBar.graphics.drawRect(0, 0, _barWidth, _barHeight);
			_backgroundBar.graphics.endFill();
		}
		
		//---------------------------------------------------------------------
		//  Bar
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function setupBar():void {
			_preloadBar = new Shape();
			
			this.addChild(_preloadBar);
		}
		
		/**
		 * @private
		 */
		private function destroyBar():void {
			this.removeChild(_preloadBar);
			
			_preloadBar.filters = null;
			_preloadBar = null;
		}
		
		/**
		 * @private
		 */
		private function drawBar():void {
			_preloadBar.graphics.clear();
			_preloadBar.graphics.beginFill(_barColor, 1);
			_preloadBar.graphics.drawRect(0, 0, _barWidth, _barHeight);
			_preloadBar.graphics.endFill();
		}
		
		/**
		 * @private
		 */
		private function updateBar(scaleValue:Number):void {
			_preloadBar.scaleX = scaleValue;
		}
		
		//---------------------------------------------------------------------
		//  Filters
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function setupFilters():void {
			_glow = new GlowFilter(_glowColor, 1, 8, 8, 2, 2);
		}
		
		/**
		 * @private
		 */
		private function destroyFilters():void {
			_glow = null;
		}
		
		/**
		 * @private
		 */
		private function applyFilters():void {
			_preloadBar.filters = [_glow];
		}
		
		//---------------------------------------------------------------------
		//  Graphics
		//---------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function draw():void {
			drawBackground();
			drawBar();
		}
		
		
		/**
		 * Destructor
		 */
		public function destroy():void {
			destroyFilters();
			destroyBackground();
			destroyBar();
			
			_barWidth = 0;
			_barHeight = 0;
			_backgroundColor = 0;
			_barColor = 0;
			_glowColor = 0;
		}
		
		/**
		 * Update progress value.
		 * 
		 * @param	progress : 0 < progress < 1
		 */
		public function updateProgress(progress:Number):void {
			progress = Math.min(progress, 1);
			progress = Math.max(0, progress);
			
			updateBar(progress);
		}
		
		/**
		 * Update bar size
		 * 
		 * @param	barWidth
		 * @param	barHeight
		 */
		public function updateSize(barWidth:int, barHeight:int):void {
			_barWidth = barWidth;
			_barHeight = barHeight;
			
			draw();
		}
	}
}
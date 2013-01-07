/*
 *                      _ _ _   
 *  ___ ___ ___ _ _ ___| |_| |_ 
 * |  _| . | . | | | -_| | | . |
 * |_| |___|_  |___|___|_|_|___|
 *         |___|   
 * 
 * roguelib : ActionScript3 Roguelike Library.
 * Licensed under the MIT License.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of
 * this software and associated documentation files (the "Software"), to deal in
 * the Software without restriction, including without limitation the rights to
 * use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 * the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 * FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 * COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 * IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
package com.hexagonstar.roguelib.core
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	/**
	 * RLFont class
	 */
	public class RLFont
	{
		//-----------------------------------------------------------------------------------------
		// Properties
		//-----------------------------------------------------------------------------------------
		
		/** @private */
		private var _bitmap:BitmapData;
		/** @private */
		private var _charWidth:int;
		/** @private */
		private var _charHeight:int;
		/** @private */
		private var _point:Point;
		/** @private */
		private var _mappings:Vector.<BitmapData>;
		
		
		//-----------------------------------------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------------------------------------
		
		/**
		 * Creates a new instance of the class.
		 */
		public function RLFont(bitmap:BitmapData, charWidth:int, charHeight:int)
		{
			_bitmap = bitmap;
			_charWidth = charWidth;
			_charHeight = charHeight;
			
			mapCharacters();
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Public Methods
		//-----------------------------------------------------------------------------------------
		
		/**
		 * Returns a bitmap data object that contains the character which is mapped
		 * by the specified charCode. Valid charCode range is from 0 to 255.
		 * 
		 * @param charCode The charCode for which to obtain a bitmap tile.
		 * @return A BitmapData object of the size charWidth x charHeight that contains
		 *         the character graphic.
		 */
		public function getTile(charCode:int):BitmapData
		{
			return _mappings[charCode];
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Getters & Setters
		//-----------------------------------------------------------------------------------------
		
		public function get bitmap():BitmapData
		{
			return _bitmap;
		}
		
		
		public function get charWidth():int
		{
			return _charWidth;
		}
		
		
		public function get charHeight():int
		{
			return _charHeight;
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Private Methods
		//-----------------------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function mapCharacters():void
		{
			_point = new Point(0, 0);
			_mappings = new Vector.<BitmapData>(256, true);
			
			var x:int = 0;
			var y:int = 0;
			var width:int = _bitmap.width;
			
			for (var i:int = 0; i < 256; i++)
			{
				var r:Rectangle = new Rectangle(x, y, _charWidth, _charHeight);
				var b:BitmapData = new BitmapData(_charWidth, _charHeight, true, 0x00000000);
				b.threshold(_bitmap, r, _point, "<", 0x111111, 0x00000000, 0xFFFFFF, true);
				
				_mappings[i] = b;
				x += _charWidth;
				
				if (x > width - _charWidth)
				{
					x = 0;
					y += _charHeight;
				}
			}
		}
	}
}

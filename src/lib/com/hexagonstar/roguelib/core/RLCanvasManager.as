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
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	
	/**
	 * RLCanvasManager class
	 */
	public class RLCanvasManager
	{
		//-----------------------------------------------------------------------------------------
		// Constants
		//-----------------------------------------------------------------------------------------
		
		public static const BASE_CANVAS_ID:String = "base";
		
		
		//-----------------------------------------------------------------------------------------
		// Properties
		//-----------------------------------------------------------------------------------------
		
		/** @private */
		private static var _instance:RLCanvasManager;
		/** @private */
		private static var _singletonLock:Boolean = false;
		
		/** @private */
		private var _screen:Bitmap;
		/** @private */
		private var _screenRect:Rectangle;
		/** @private */
		private var _tileRect:Rectangle;
		/** @private */
		private var _tilePoint:Point;
		/** @private */
		private var _tileBG:BitmapData;
		/** @private */
		private var _tileCT:ColorTransform;
		/** @private */
		private var _baseCanvas:RLCanvas;
		/** @private */
		private var _canvases:Object;
		
		
		//-----------------------------------------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------------------------------------
		
		/**
		 * Creates a new instance of the class.
		 */
		public function RLCanvasManager()
		{
			if (!_singletonLock)
			{
				throw new Error("Tried to instantiate the singleton " + this + " through it's"
					+ " constructor. Use the 'instance' property to get the instance instead.");
			}
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Public Methods
		//-----------------------------------------------------------------------------------------
		
		/**
		 * Initializes the canvas manager. This removes all canvases if there are any and
		 * creates a base canvas of the specified width, height and font.
		 * 
		 * <p>The font specified here becomes automatically the default font for any other
		 * canvases in case their font parameter is omitted.</p>
		 * 
		 * @param w The horizontal size of the base canvas in cells, must be larger than 0.
		 * @param h The vertical size of the base canvas in cells, must be larger than 0.
		 * @param font The font that contains the characters used for the base canvas.
		 * @param color The default foreground (text) color of the base canvas.
		 * @param bgColor The default background color of the base canvas.
		 * 
		 * @return The bitmap onto which all canvases are rendered.
		 */
		public function init(w:uint, h:uint, font:RLFont, color:uint = 0xFFFFFF,
			bgColor:uint = 0x000000):Bitmap
		{
			if (w < 1 || h < 1) return null;
			var c:RLCanvas;
			for each (c in _canvases)
			{
				c.dispose();
			}
			_canvases = {};
			c = new RLCanvas(BASE_CANVAS_ID, w, h, font, color, bgColor);
			w *= c.cellWidth;
			h *= c.cellHeight;
			_screenRect = new Rectangle(0, 0, w, h);
			_tileRect = new Rectangle(0, 0, c.cellWidth, c.cellHeight);
			_tilePoint = new Point(0, 0);
			_tileBG = new BitmapData(c.cellWidth, c.cellHeight, false);
			_tileCT = new ColorTransform();
			_screen = new Bitmap(new BitmapData(w, h, false, bgColor), PixelSnapping.ALWAYS, false);
			_canvases[c.id] = _baseCanvas = c;
			return _screen;
		}
		
		
		/**
		 * Creates a new canvas and returns it.
		 * 
		 * @param w The horizontal size of the canvas in cells, must be larger than 0.
		 * @param h The vertical size of the canvas in cells, must be larger than 0.
		 * @param font The font that contains the characters used for the canvas. If null
		 *        the canvas will use the same font as the base canvas.
		 * 
		 * @return The canvas or null if the operation was not successful.
		 */
		public function createCanvas(id:String, w:uint, h:uint, font:RLFont = null):RLCanvas
		{
			if (!id || id.length < 1 || w < 1 || h < 1 || _canvases[id]) return null;
			if (!font) font = RLCanvas(_canvases[BASE_CANVAS_ID]).font;
			var c:RLCanvas = new RLCanvas(id, w, h, font);
			_canvases[c.id] = c;
			return c;
		}
		
		
		/**
		 * Use this method to destroy an offscreen canvas and release any resources
		 * allocated. Note that the base canvas cannot be removed.
		 * 
		 * @param id The ID of the canvas that should be removed.
		 */
		public function removeCanvas(id:String):void
		{
			if (id == BASE_CANVAS_ID) return;
			var c:RLCanvas = _canvases[id];
			if (c)
			{
				c.dispose();
				_canvases[id] = null;
				delete _canvases[id];
			}
		}
		
		
		/**
		 * This method allows you to blit a rectangular area of a source canvas to a
		 * specific position on a destination canvas.
		 * 
		 * @param sCanvas The source canvas that should be blitted on another one.
		 * @param dCanvas The destination canvas.
		 * @param sx The x coordinate of the blitted rectangle on the source canvas.
		 * @param sy The y coordinate of the blitted rectangle on the source canvas.
		 * @param sw The with of the blitted rectangle on the source canvas. If this
		 *        value is 0 the whole canvas will be blitted.
		 * @param sh The height of the blitted rectangle on the source canvas. If this
		 *        value is 0 the whole canvas will be blitted.
		 * @param dx The x coordinate of the blitted rectangle on the destination canvas.
		 * @param dy The y coordinate of the blitted rectangle on the destination canvas.
		 */
		public function blitCanvas(sCanvas:RLCanvas, dCanvas:RLCanvas, sx:uint = 0, sy:uint = 0,
			sw:uint = 0, sh:uint = 0, dx:uint = 0, dy:uint = 0):void
		{
			// TODO Implement method!
		}
		
		
		/**
		 * Once the canvas is initialized, you can use one of the printing functions to change
		 * the background colors, the foreground colors or the ASCII characters on the canvas.
		 * Once you've finished rendering the canvas, you have to actually apply the updates to
		 * the screen with this function.
		 */
		public function flush():void
		{
			var cells:Vector.<RLCell> = _baseCanvas.cells;
			var cellCount:uint = _baseCanvas.cellCount;
			var font:RLFont = _baseCanvas.font;
			var sr:uint = _screen.width - _tileRect.width;
			var i:uint = 0;
			var c:uint = 0;
			
			_tilePoint.x = _tilePoint.y = 0;
			//_screen.bitmapData.fillRect(_screenRect, _baseCanvas.backgroundColor);
			
			while (i < cellCount)
			{
				var cell:RLCell = cells[i];
				if (cell.changed)
				{
					var b:BitmapData = font.getTile(cell.charCode);
					_tileCT.color = cell.color;
					_tileBG.fillRect(_tileRect, cell.bgColor);
					_tileBG.draw(b, null, _tileCT);
					_screen.bitmapData.copyPixels(_tileBG, _tileRect, _tilePoint);
					cell.changed = false;
				}
				
				i++;
				c++;
				_tilePoint.x = c * _tileRect.width;
				
				if (_tilePoint.x > sr)
				{
					c = _tilePoint.x = 0;
					_tilePoint.y += _tileRect.height;
				}
			}
		}
		
		
		/**
		 * This method modifies all cells of a canvas. It sets the cell's background color
		 * to the canvas' default background color, the cell's foreground color to the canvas
		 * default foreground color and the cell's ASCII code to 32 (space).
		 * 
		 * @param canvasID The ID of the canvas to clear.
		 *        If the ID is null the base canvas is used.
		 */
		public function clear(canvasID:String = null):void
		{
			getCanvas(canvasID).clear();
		}
		
		
		/**
		 * Sets the background color of the canvas with the specified ID.
		 * 
		 * @param canvasID The ID of the canvas on which to set the bg color.
		 *        If the ID is null the base canvas is used.
		 * @param color The background color to use. You can use color constants.
		 */
		public function setCanvasBackground(canvasID:String, color:uint):void
		{
			getCanvas(canvasID).backgroundColor = color;
		}
		
		
		/**
		 * Gets the background color of the canvas with the specified ID.
		 * 
		 * @param canvasID The ID of the canvas from which to get the bg color.
		 *        If the ID is null the base canvas is used.
		 * @return The canvas background color.
		 */
		public function getCanvasBackground(canvasID:String = null):uint
		{
			return getCanvas(canvasID).backgroundColor;
		}
		
		
		/**
		 * Sets the default foreground (text) color of the canvas with the specified ID.
		 * 
		 * @param canvasID The ID of the canvas on which to set the foreground color.
		 *        If the ID is null the base canvas is used.
		 * @param color The foreground color to use. You can use color constants.
		 */
		public function setCanvasColor(canvasID:String, color:uint):void
		{
			getCanvas(canvasID).color = color;
		}
		
		
		/**
		 * Gets the foreground (text) color of the canvas with the specified ID.
		 * 
		 * @param canvasID The ID of the canvas from which to get the foreground color.
		 *        If the ID is null the base canvas is used.
		 * @return The canvas foreground color.
		 */
		public function getCanvasColor(canvasID:String = null):uint
		{
			return getCanvas(canvasID).color;
		}
		
		
		/**
		 * This method modifies every property of a cell. It updates the cell's background
		 * color according to the console default background color, sets the cell's
		 * foreground color to the console default foreground color and sets the cell's
		 * ASCII code to 'charCode'.
		 * 
		 * @param canvasID The ID of the canvas on which to put a character.
		 *        If the ID is null the base canvas is used.
		 * @param x X coordinate of the cell in the canvas.
		 * @param y Y coordinate of the cell in the canvas.
		 * @param charCode The new ASCII code for the cell between 0 and 255. You can use
		 *        ASCII constants.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 */
		public function putCellChar(canvasID:String, x:uint, y:uint, charCode:int,
			bgMode:int = 0):void
		{
			getCanvas(canvasID).putCellChar(x, y, charCode, bgMode);
		}
		
		
		/**
		 * Allows to set a cell's character as well as it's background and foreground color
		 * in one call.
		 * 
		 * @param canvasID The ID of the canvas on which to set the cell properties.
		 *        If the ID is null the base canvas is used.
		 * @param x X coordinate of the cell in the canvas.
		 * @param y Y coordinate of the cell in the canvas.
		 * @param charCode The new ASCII code for the cell between 0 and 255. You can use
		 *        ASCII constants.
		 * @param color The cell's new foreground color. You can use color constants.
		 * @param bgColor The background color to use. You can use color constants.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 */
		public function setCellProperties(canvasID:String, x:uint, y:uint, charCode:int,
			color:uint = NaN, bgColor:uint = NaN, bgMode:String = null):void
		{
			getCanvas(canvasID).setCellProperties(x, y, charCode, color, bgColor);
		}
		
		
		/**
		 * This method modifies the background color of a cell, leaving other properties
		 * (foreground color and ASCII code) unchanged.
		 * 
		 * @param canvasID The ID of the canvas on which to set the cell bg color.
		 *        If the ID is null the base canvas is used.
		 * @param x X coordinate of the cell in the canvas.
		 * @param y Y coordinate of the cell in the canvas.
		 * @param color The background color to use. You can use color constants.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 */
		public function setCellBackground(canvasID:String, x:uint, y:uint, color:uint,
			bgMode:int = 0):void
		{
			getCanvas(canvasID).setCellBackground(x, y, color, bgMode);
		}
		
		
		/**
		 * This function modifies the foreground color of a cell, leaving other properties
		 * (background color and ASCII code) unchanged.
		 * 
		 * @param canvasID The ID of the canvas on which to set the cell color.
		 *        If the ID is null the base canvas is used.
		 * @param x X coordinate of the cell in the canvas.
		 * @param y Y coordinate of the cell in the canvas.
		 * @param color The cell's new foreground color. You can use color constants.
		 */
		public function setCellColor(canvasID:String, x:uint, y:uint, color:uint):void
		{
			getCanvas(canvasID).setCellColor(x, y, color);
		}
		
		
		/**
		 * This method modifies the ASCII code of a cell, leaving other properties (background
		 * and foreground colors) unchanged. Note that since a clear canvas has both
		 * background and foreground colors set to black for every cell, using setCellChar will
		 * produce black characters on black background. Use putChar instead.
		 * 
		 * @param canvasID The ID of the canvas on which to draw to.
		 *        If the ID is null the base canvas is used.
		 * @param x X coordinate of the cell in the canvas.
		 * @param y Y coordinate of the cell in the canvas.
		 * @param charCode The new ASCII code for the cell between 0 and 255. You can use
		 *        ASCII constants.
		 */
		public function setCellChar(canvasID:String, x:uint, y:uint, charCode:int):void
		{
			getCanvas(canvasID).setCellChar(x, y, charCode);
		}
		
		
		/**
		 * This method returns the current ASCII code of a cell.
		 * 
		 * @param canvasID The ID of the canvas from which to get the cell character.
		 *        If the ID is null the base canvas is used.
		 * @param x X coordinate of the cell on the canvas.
		 * @param y Y coordinate of the cell on the canvas.
		 * 
		 * @return the current ASCII code of the cell at the specified coordinate or
		 *         -1 if no cell at the xy coord exists.
		 */
		public function getCellChar(canvasID:String, x:uint, y:uint):int
		{
			return getCanvas(canvasID).getCellChar(x, y);
		}
		
		
		/**
		 * Gets the cell count of the specified canvas.
		 * 
		 * @param canvasID The ID of the canvas from which to get the cell count.
		 *        If the ID is null the base canvas is used.
		 * @return The amount of cells on the canvas.
		 */
		public function getCellCount(canvasID:String = null):uint
		{
			return getCanvas(canvasID).cellCount;
		}
		
		
		/**
		 * This method draws a left aligned string on the canvas, using default foreground
		 * and background colors. If the string reaches the right border of the canvas, it
		 * is truncated.
		 * 
		 * @param canvasID The ID of the canvas.
		 *        If the ID is null the base canvas is used.
		 * @param x X coordinate of the string's first character on the canvas.
		 * @param y Y coordinate of the string's first character on the canvas.
		 * @param s printf-like format string. You can use control codes to change the
		 *        colors inside the string.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 */
		public function printLeft(canvasID:String, x:uint, y:uint, s:String, bgMode:int = 0):void
		{
			getCanvas(canvasID).printLeft(x, y, s, bgMode);
		}
		
		
		/**
		 * This method draws a right aligned string on the canvas, using default foreground
		 * and background colors. If the string reaches the left border of the canvas, it
		 * is truncated.
		 * 
		 * @param canvasID The ID of the canvas.
		 *        If the ID is null the base canvas is used.
		 * @param x X coordinate of the string's last character on the canvas.
		 * @param y Y coordinate of the string's last character on the canvas.
		 * @param s printf-like format string. You can use control codes to change the
		 *        colors inside the string.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 */
		public function printRight(canvasID:String, x:uint, y:uint, s:String, bgMode:int = 0):void
		{
			getCanvas(canvasID).printRight(x, y, s, bgMode);
		}
		
		
		/**
		 * This method draws a centered string on the canvas, using default foreground and
		 * background colors. If the string reaches borders of the canvas, it is truncated.
		 * 
		 * @param canvasID The ID of the canvas.
		 *        If the ID is null the base canvas is used.
		 * @param x X coordinate of the string's middle character on the canvas.
		 * @param y Y coordinate of the string's middle character on the canvas.
		 * @param s printf-like format string. You can use control codes to change the
		 *        colors inside the string.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 */
		public function printCenter(canvasID:String, x:uint, y:uint, s:String, bgMode:int = 0):void
		{
			getCanvas(canvasID).printCenter(x, y, s, bgMode);
		}
		
		
		/**
		 * Draws a horizontal line on the canvas, using ASCII code CHAR_HLINE (196), and
		 * the canvas' default background/foreground colors.
		 * 
		 * @param canvasID The ID of the canvas.
		 *        If the ID is null the base canvas is used.
		 * @param x X coordinate of the line's left end on the canvas.
		 * @param y Y coordinate of the line's left end on the canvas.
		 * @param length The length of the line in cells.
		 * @param bgMode This flag defines how the line's background color is modified.
		 */
		public function hline(canvasID:String, x:uint, y:uint, length:uint, bgMode:int = 0):void
		{
			getCanvas(canvasID).hline(x, y, length, bgMode);
		}
		
		
		/**
		 * Draws an vertical line in the canvas, using ASCII code CHAR_VLINE (179), and
		 * the canvas' default background/foreground colors.
		 * 
		 * @param canvasID The ID of the canvas.
		 *        If the ID is null the base canvas is used.
		 * @param x X coordinate of the line's upper end on the canvas.
		 * @param y Y coordinate of the line's upper end on the canvas.
		 * @param length The length of the line in cells.
		 * @param bgMode This flag defines how the line's background color is modified.
		 */
		public function vline(canvasID:String, x:uint, y:uint, length:uint, bgMode:int = 0):void
		{
			getCanvas(canvasID).vline(x, y, length, bgMode);
		}
		
		
		/**
		 * Returns a string dump of all currently used canvases.
		 */
		public function dump():String
		{
			var s:String = toString();
			for each (var c:RLCanvas in _canvases)
			{
				s += "\n" + c.toString();
			}
			return s;
		}
		
		
		/**
		 * Returns a String Representation of the class.
		 * 
		 * @return A String Representation of the class.
		 */
		public function toString():String
		{
			return "[RLCanvasManager]";
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Getters & Setters
		//-----------------------------------------------------------------------------------------
		
		/**
		 * Returns the singleton instance of the class.
		 */
		public static function get instance():RLCanvasManager
		{
			if (_instance == null)
			{
				_singletonLock = true;
				_instance = new RLCanvasManager();
				_singletonLock = false;
			}
			return _instance;
		}
		
		
		/**
		 * The bitmap onto which all canvases are rendered. It's size depends on the
		 * size of the base canvas.
		 */
		public function get screen():Bitmap
		{
			return _screen;
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Callback Handlers
		//-----------------------------------------------------------------------------------------
		
		
		//-----------------------------------------------------------------------------------------
		// Private Methods
		//-----------------------------------------------------------------------------------------
		
		/**
		 * Returns the canvas of the specified ID. If ID is null, the base canvas is returned.
		 * @private
		 */
		private function getCanvas(id:String):RLCanvas
		{
			if (!id) return _canvases[BASE_CANVAS_ID];
			return _canvases[id];
		}
	}
}

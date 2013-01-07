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
	/**
	 * RLCanvas class
	 */
	public class RLCanvas
	{
		//-----------------------------------------------------------------------------------------
		// Constants
		//-----------------------------------------------------------------------------------------
		
		/* This flag is used by most functions that modify a cell background color.
		 * It defines how the console's current background color is used to modify
		 * the cell's existing background color. */
		public static const BG_NONE:int			= 0;
		public static const BG_SET:int			= 1;
		public static const BG_MULTIPLY:int		= 2;
		public static const BG_LIGHTEN:int		= 3;
		public static const BG_DARKEN:int		= 4;
		public static const BG_SCREEN:int		= 5;
		public static const BG_COLOR_DODGE:int	= 6;
		public static const BG_COLOR_BURN:int	= 7;
		public static const BG_ADD:int			= 8;
		public static const BG_ADDALPHA:int		= 9;
		public static const BG_ALPHA:int		= 10;
		public static const BG_BURN:int			= 11;
		public static const BG_OVERLAY:int		= 12;
		public static const BG_DEFAULT:int		= 13;
		
		/* single walls */
		public static const CHAR_HLINE:int = 196;
		public static const CHAR_VLINE:int = 179;
		public static const CHAR_NE:int = 191;
		public static const CHAR_NW:int = 218;
		public static const CHAR_SE:int = 217;
		public static const CHAR_SW:int = 192;
		public static const CHAR_TEEW:int = 180;
		public static const CHAR_TEEE:int = 195;
		public static const CHAR_TEEN:int = 193;
		public static const CHAR_TEES:int = 194;
		public static const CHAR_CROSS:int = 197;
		
		/* double walls */
		public static const CHAR_DHLINE:int = 205;
		public static const CHAR_DVLINE:int = 186;
		public static const CHAR_DNE:int = 187;
		public static const CHAR_DNW:int = 201;
		public static const CHAR_DSE:int = 188;
		public static const CHAR_DSW:int = 200;
		public static const CHAR_DTEEW:int = 185;
		public static const CHAR_DTEEE:int = 204;
		public static const CHAR_DTEEN:int = 202;
		public static const CHAR_DTEES:int = 203;
		public static const CHAR_DCROSS:int = 206;
		
		/* blocks */
		public static const CHAR_BLOCK1:int = 176;
		public static const CHAR_BLOCK2:int = 177;
		public static const CHAR_BLOCK3:int = 178;
		
		/* arrows */
		public static const CHAR_ARROW_N:int = 24;
		public static const CHAR_ARROW_S:int = 25;
		public static const CHAR_ARROW_E:int = 26;
		public static const CHAR_ARROW_W:int = 27;
		
		/* arrows without tail */
		public static const CHAR_ARROW2_N:int = 30;
		public static const CHAR_ARROW2_S:int = 31;
		public static const CHAR_ARROW2_E:int = 16;
		public static const CHAR_ARROW2_W:int = 17;
		
		/* double arrows */
		public static const CHAR_DARROW_H:int = 29;
		public static const CHAR_DARROW_V:int = 18;
		
		/* GUI stuff */
		public static const CHAR_CHECKBOX_UNSET:int = 224;
		public static const CHAR_CHECKBOX_SET:int = 225;
		public static const CHAR_RADIO_UNSET:int = 9;
		public static const CHAR_RADIO_SET:int = 10;
		
		/* sub-pixel resolution kit */
		public static const CHAR_SUBP_NW:int = 226;
		public static const CHAR_SUBP_NE:int = 227;
		public static const CHAR_SUBP_N:int = 228;
		public static const CHAR_SUBP_SE:int = 229;
		public static const CHAR_SUBP_DIAG:int = 230;
		public static const CHAR_SUBP_E:int = 231;
		public static const CHAR_SUBP_SW:int = 232;
		
		/* miscellaneous */
		public static const CHAR_SMILIE:int = 1;
		public static const CHAR_SMILIE_INV:int = 2;
		public static const CHAR_HEART:int = 3;
		public static const CHAR_DIAMOND:int = 4;
		public static const CHAR_CLUB:int = 5;
		public static const CHAR_SPADE:int = 6;
		public static const CHAR_BULLET:int = 7;
		public static const CHAR_BULLET_INV:int = 8;
		public static const CHAR_MALE:int = 11;
		public static const CHAR_FEMALE:int = 12;
		public static const CHAR_NOTE:int = 13;
		public static const CHAR_NOTE_DOUBLE:int = 14;
		public static const CHAR_LIGHT:int = 15;
		public static const CHAR_EXCLAM_DOUBLE:int = 19;
		public static const CHAR_PILCROW:int = 20;
		public static const CHAR_SECTION:int = 21;
		public static const CHAR_POUND:int = 156;
		public static const CHAR_MULTIPLICATION:int = 158;
		public static const CHAR_FUNCTION:int = 159;
		public static const CHAR_RESERVED:int = 169;
		public static const CHAR_HALF:int = 171;
		public static const CHAR_ONE_QUARTER:int = 172;
		public static const CHAR_COPYRIGHT:int = 184;
		public static const CHAR_CENT:int = 189;
		public static const CHAR_YEN:int = 190;
		public static const CHAR_CURRENCY:int = 207;
		public static const CHAR_THREE_QUARTERS:int = 243;
		public static const CHAR_DIVISION:int = 246;
		public static const CHAR_GRADE:int = 248;
		public static const CHAR_UMLAUT:int = 249;
		public static const CHAR_POW1:int = 251;
		public static const CHAR_POW3:int = 252;
		public static const CHAR_POW2:int = 253;
		public static const CHAR_BULLET_SQUARE:int = 254;
		
		
		//-----------------------------------------------------------------------------------------
		// Properties
		//-----------------------------------------------------------------------------------------
		
		/** @private */
		private var _id:String;
		/** @private */
		private var _width:uint;
		/** @private */
		private var _height:uint;
		/** @private */
		private var _color:uint;
		/** @private */
		private var _backgroundColor:uint;
		/** @private */
		private var _font:RLFont;
		/** @private */
		private var _cellWidth:int;
		/** @private */
		private var _cellHeight:int;
		
		/** @private */
		internal var cells:Vector.<RLCell>;
		/** @private */
		internal var cellCount:uint;
		
		
		//-----------------------------------------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------------------------------------
		
		/**
		 * Creates a new instance of the class.
		 * 
		 * @param id The unique ID of the canvas. "base" is reserved for the base canvas.
		 * @param width Width of the canvas in, cells.
		 * @param height Height of the canvas in, cells.
		 * @param font The font with characters used for the canvas.
		 * @param color The default foreground (text) color of the canvas.
		 * @param bgColor The default background color of the canvas.
		 */
		public function RLCanvas(id:String, width:uint, height:uint, font:RLFont,
			color:uint = 0xFFFFFF, bgColor:uint = 0x000000)
		{
			_id = id;
			_width = width;
			_height = height;
			cellCount = _width * _height;
			_font = font;
			_cellWidth = _font.charWidth;
			_cellHeight = _font.charHeight;
			_color = color;
			_backgroundColor = bgColor;
			
			init();
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Public Methods
		//-----------------------------------------------------------------------------------------
		
		/**
		 * This method modifies all cells of a canvas. It sets the cell's background color
		 * to the canvas' default background color, the cell's foreground color to the canvas
		 * default foreground color and the cell's ASCII code to 32 (space).
		 */
		public function clear():void
		{
			for (var i:uint = 0; i < cellCount; i++)
			{
				var c:RLCell = cells[i];
				c.bgColor = _backgroundColor;
				c.color = _backgroundColor;
				c.charCode = 32;
				c.changed = true;
			}
		}
		
		
		/**
		 * This method modifies every property of a cell. It updates the cell's background
		 * color according to the console default background color, sets the cell's
		 * foreground color to the console default foreground color and sets the cell's
		 * ASCII code to 'charCode'.
		 * 
		 * @param x X coordinate of the cell in the canvas.
		 * @param y Y coordinate of the cell in the canvas.
		 * @param charCode The new ASCII code for the cell between 0 and 255. You can use
		 *        ASCII constants.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 */
		public function putCellChar(x:uint, y:uint, charCode:int, bgMode:int = 0):void
		{
			var c:RLCell = getCellAt(x, y);
			if (!c) return;
			c.bgColor = _backgroundColor;
			c.color = _color;
			c.charCode = charCode;
			c.changed = true;
		}
		
		
		/**
		 * Allows to set a cell's character as well as it's background and foreground color
		 * in one call.
		 * 
		 * @param x X coordinate of the cell in the canvas.
		 * @param y Y coordinate of the cell in the canvas.
		 * @param charCode The new ASCII code for the cell between 0 and 255. You can use
		 *        ASCII constants.
		 * @param color The cell's new foreground color. You can use color constants.
		 * @param bgColor The background color to use. You can use color constants.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 */
		public function setCellProperties(x:uint, y:uint, charCode:int, color:uint, bgColor:uint,
			bgMode:int = 0):void
		{
			var c:RLCell = getCellAt(x, y);
			if (!c) return;
			c.charCode = charCode;
			if (!isNaN(color)) c.color = color;
			if (!isNaN(bgColor)) c.bgColor = bgColor;
			c.changed = true;
		}
		
		
		/**
		 * This method modifies the background color of a cell, leaving other properties
		 * (foreground color and ASCII code) unchanged.
		 * 
		 * @param x X coordinate of the cell in the canvas.
		 * @param y Y coordinate of the cell in the canvas.
		 * @param color The background color to use. You can use color constants.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 */
		public function setCellBackground(x:uint, y:uint, color:uint, bgMode:int = 0):void
		{
			var c:RLCell = getCellAt(x, y);
			if (!c) return;
			c.bgColor = color;
			c.changed = true;
		}
		
		
		/**
		 * This method returns the current background color of a cell.
		 * 
		 * @param x X coordinate of the cell on the canvas.
		 * @param y Y coordinate of the cell on the canvas.
		 * 
		 * @return the current background color of the cell at the specified coordinate
		 *         or 0 if the cell does not exist.
		 */
		public function getCellBackgroundColor(x:uint, y:uint):uint
		{
			var c:RLCell = getCellAt(x, y);
			if (!c) return 0;
			return c.bgColor;
		}
		
		
		/**
		 * This function modifies the foreground color of a cell, leaving other properties
		 * (background color and ASCII code) unchanged.
		 * 
		 * @param x X coordinate of the cell in the canvas.
		 * @param y Y coordinate of the cell in the canvas.
		 * @param color The cell's new foreground color. You can use color constants.
		 */
		public function setCellColor(x:uint, y:uint, color:uint):void
		{
			var c:RLCell = getCellAt(x, y);
			if (!c) return;
			c.color = color;
			c.changed = true;
		}
		
		
		/**
		 * This method returns the current foreground (text) color of a cell.
		 * 
		 * @param x X coordinate of the cell on the canvas.
		 * @param y Y coordinate of the cell on the canvas.
		 * 
		 * @return the current foreground color of the cell at the specified coordinate
		 *         or 0 if the cell does not exist.
		 */
		public function getCellColor(x:uint, y:uint):uint
		{
			var c:RLCell = getCellAt(x, y);
			if (!c) return 0;
			return c.color;
		}
		
		
		/**
		 * This method modifies the ASCII code of a cell, leaving other properties (background
		 * and foreground colors) unchanged. Note that since a clear console has both
		 * background and foreground colors set to black for every cell, using setCellChar will
		 * produce black characters on black background. Use putChar instead.
		 * 
		 * @param x X coordinate of the cell in the canvas.
		 * @param y Y coordinate of the cell in the canvas.
		 * @param charCode The new ASCII code for the cell between 0 and 255. You can use
		 *        ASCII constants.
		 */
		public function setCellChar(x:uint, y:uint, charCode:int):void
		{
			var c:RLCell = getCellAt(x, y);
			if (!c) return;
			c.charCode = charCode;
			c.changed = true;
		}
		
		
		/**
		 * This method returns the current ASCII code of a cell.
		 * 
		 * @param x X coordinate of the cell on the canvas.
		 * @param y Y coordinate of the cell on the canvas.
		 * 
		 * @return the current ASCII code of the cell at the specified coordinate
		 *         or -1 if the cell does not exist.
		 */
		public function getCellChar(x:uint, y:uint):int
		{
			var c:RLCell = getCellAt(x, y);
			if (!c) return -1;
			return c.charCode;
		}
		
		
		/**
		 * This method draws a left aligned string on the canvas, using default foreground
		 * and background colors. If the string reaches the right border of the canvas, it
		 * is truncated.
		 * 
		 * @param x X coordinate of the string's first character on the canvas.
		 * @param y Y coordinate of the string's first character on the canvas.
		 * @param s printf-like format string. You can use control codes to change the
		 *        colors inside the string.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 */
		public function printLeft(x:uint, y:uint, s:String, bgMode:int = 0):void
		{
			var c:RLCell = getCellAt(x, y);
			if (!c) return;
			
			var maxLen:int = _width - x;
			var len:int = s.length > maxLen ? maxLen : s.length;
			
			for (var i:int = 0; i < len; i++)
			{
				c = cells[int(y * _width + (x + i))];
				c.bgColor = _backgroundColor;
				c.color = _color;
				c.charCode = s.charCodeAt(i);
				c.changed = true;
			}
		}
		
		
		/**
		 * This method draws a right aligned string on the canvas, using default foreground
		 * and background colors. If the string reaches the left border of the canvas, it
		 * is truncated.
		 * 
		 * @param x X coordinate of the string's last character on the canvas.
		 * @param y Y coordinate of the string's last character on the canvas.
		 * @param s printf-like format string. You can use control codes to change the
		 *        colors inside the string.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 */
		public function printRight(x:uint, y:uint, s:String, bgMode:int = 0):void
		{
			var c:RLCell = getCellAt(x, y);
			if (!c) return;
			
			var len:int = s.length;
			var sx:int = x - len + 1;
			var ov:int = sx < 0 ? -(sx) : 0;
			
			for (var i:int = ov; i < len; i++)
			{
				c = cells[int(y * _width + (sx + i))];
				c.bgColor = _backgroundColor;
				c.color = _color;
				c.charCode = s.charCodeAt(i);
				c.changed = true;
			}
		}
		
		
		/**
		 * This method draws a centered string on the canvas, using default foreground and
		 * background colors. If the string reaches borders of the canvas, it is truncated.
		 * 
		 * @param x X coordinate of the string's middle character on the canvas.
		 * @param y Y coordinate of the string's middle character on the canvas.
		 * @param s printf-like format string. You can use control codes to change the
		 *        colors inside the string.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 */
		public function printCenter(x:uint, y:uint, s:String, bgMode:int = 0):void
		{
			var c:RLCell = getCellAt(x, y);
			if (!c) return;
			
			/* The middle of the string should be at the given x coord. */
			var len:int = s.length;
			var odd:int = len % 2 ? 1 : 0;
			var mid:int = len * 0.5;
			var sx:int = x - mid;
			var os:int = sx < 0 ? -(sx) : 0;
			len -= x + mid + odd > _width ? (x + mid + odd) - _width : 0;
			
			for (var i:int = os; i < len; i++)
			{
				c = cells[int(y * _width + (sx + i))];
				c.bgColor = _backgroundColor;
				c.color = _color;
				c.charCode = s.charCodeAt(i);
				c.changed = true;
			}
		}
		
		
		/**
		 * This method draws a left aligned string in a rectangle inside the canvas, using
		 * default foreground and background colors. If the string reaches the right border
		 * of the rectangle, carriage returns are inserted.
		 * 
		 * <p>If h > 0 and the bottom of the rectangle is reached, the string is truncated. If
		 * h = 0, the string is only truncated if it reaches the bottom of the canvas.</p>
		 * 
		 * <p>The method returns the height (number of canvas lines) of the printed string.</p>
		 * 
		 * @param x X coordinate of the rectangle's upper-left corner on the canvas.
		 * @param y Y coordinate of the rectangle's upper-left corner on the canvas.
		 * @param w Horizontal size of the rectangle on the canvas.
		 * @param h Vertical size of the rectangle on the canvas.
		 * @param s printf-like format string. You can use control codes to change the
		 *        colors inside the string.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 * 
		 * @return The height (number of canvas lines) of the printed string.
		 */
		public function printLeftRect(x:uint, y:uint, w:uint, h:uint, s:String,
			bgMode:int = 0):uint
		{
			// TODO Implement method!
			return 0;
		}
		
		
		/**
		 * This method draws a right aligned string in a rectangle inside the canvas, using
		 * default foreground and background colors. If the string reaches the left border
		 * of the rectangle, carriage returns are inserted.
		 * 
		 * <p>If h > 0 and the bottom of the rectangle is reached, the string is truncated. If
		 * h = 0, the string is only truncated if it reaches the bottom of the canvas.</p>
		 * 
		 * <p>The method returns the height (number of canvas lines) of the printed string.</p>
		 * 
		 * @param x X coordinate of the rectangle's upper-right corner on the canvas.
		 * @param y Y coordinate of the rectangle's upper-right corner on the canvas.
		 * @param w Horizontal size of the rectangle on the canvas.
		 * @param h Vertical size of the rectangle on the canvas.
		 * @param s printf-like format string. You can use control codes to change the
		 *        colors inside the string.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 * 
		 * @return The height (number of canvas lines) of the printed string.
		 */
		public function printRightRect(x:uint, y:uint, w:uint, h:uint, s:String,
			bgMode:int = 0):uint
		{
			// TODO Implement method!
			return 0;
		}
		
		
		/**
		 * This method draws a centered string in a rectangle inside the canvas, using
		 * default foreground and background colors. If the string reaches the borders of
		 * the rectangle, carriage returns are inserted.
		 * 
		 * If h > 0 and the bottom of the rectangle is reached, the string is truncated. If
		 * h = 0, the string is only truncated if it reaches the bottom of the canvas.
		 * 
		 * The method returns the height (number of canvas lines) of the printed string.
		 * 
		 * @param x X coordinate of the rectangle's top-middle position on the canvas.
		 * @param y Y coordinate of the rectangle's top-middle position on the canvas.
		 * @param w Horizontal size of the rectangle on the canvas.
		 * @param h Vertical size of the rectangle on the canvas.
		 * @param s printf-like format string. You can use control codes to change the
		 *        colors inside the string.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 * 
		 * @return The height (number of canvas lines) of the printed string.
		 */
		public function printCenterRect(x:uint, y:uint, w:uint, h:uint, s:String,
			bgMode:int = 0):uint
		{
			// TODO Implement method!
			return 0;
		}
		
		
		/**
		 * Fills a rectangle inside the canvas. For each cell in the rectangle it sets the
		 * cell's background color to the canvas default background color and if clear is
		 * true, sets the cell's ASCII code to 32 (space).
		 * 
		 * @param x X coordinate of the rectangle's upper-left corner on the canvas.
		 * @param y Y coordinate of the rectangle's upper-left corner on the canvas.
		 * @param w Horizontal size of the rectangle on the canvas.
		 * @param h Vertical size of the rectangle on the canvas.
		 * @param clear if true, all characters inside the rectangle are set to ASCII code
		 *        32 (space). If false, only the background color is modified.
		 * @param bgMode This flag defines how the cell's background color is modified.
		 */
		public function fillRect(x:uint, y:uint, w:uint, h:uint, clear:Boolean = false,
			bgMode:int = 0):void
		{
			// TODO Implement method!
		}
		
		
		/**
		 * Draws a horizontal line on the canvas, using ASCII code CHAR_HLINE (196), and
		 * the canvas' default background/foreground colors.
		 * 
		 * @param x X coordinate of the line's left end on the canvas.
		 * @param y Y coordinate of the line's left end on the canvas.
		 * @param length The length of the line in cells.
		 * @param bgMode This flag defines how the line's background color is modified.
		 */
		public function hline(x:uint, y:uint, length:uint, bgMode:int = 0):void
		{
			var c:RLCell = getCellAt(x, y);
			if (!c) return;
			
			var maxLen:int = _width - x;
			var len:int = length > maxLen ? maxLen : length;
			
			for (var i:int = 0; i < len; i++)
			{
				c = cells[int(y * _width + (x + i))];
				c.bgColor = _backgroundColor;
				c.color = _color;
				c.charCode = CHAR_HLINE;
				c.changed = true;
			}
		}
		
		
		/**
		 * Draws an vertical line in the canvas, using ASCII code CHAR_VLINE (179), and
		 * the canvas' default background/foreground colors.
		 * 
		 * @param x X coordinate of the line's upper end on the canvas.
		 * @param y Y coordinate of the line's upper end on the canvas.
		 * @param length The length of the line in cells.
		 * @param bgMode This flag defines how the line's background color is modified.
		 */
		public function vline(x:uint, y:uint, length:uint, bgMode:int = 0):void
		{
			var c:RLCell = getCellAt(x, y);
			if (!c) return;
			
			var maxLen:int = _height - y;
			var len:int = length > maxLen ? maxLen : length;
			
			for (var i:int = 0; i < len; i++)
			{
				c = cells[int((y + i) * _width + x)];
				c.bgColor = _backgroundColor;
				c.color = _color;
				c.charCode = CHAR_VLINE;
				c.changed = true;
			}
		}
		
		
		/**
		 * This method calls the fillRect method using the BKGND_SET bgMode, then draws a
		 * rectangle with the canvas' default foreground color. If s is not null, it is
		 * printed on the top of the rectangle, using inverted colors.
		 * 
		 * @param x X coordinate of the rectangle upper-left corner on the canvas.
		 * @param y Y coordinate of the rectangle upper-left corner on the canvas.
		 * @param w Horizontal size of the rectangle on the canvas.
		 * @param h Vertical size of the rectangle on the canvas.
		 * @param s If null, the method only draws a rectangle. Else, printf-like format
		 *        string. You can use control codes to change the colors inside the string.
		 * @param clear If true, all characters inside the rectangle are set to ASCII code
		 *        32 (space). If false, only the background color is modified.
		 * @param bgMode Controls how the frame area is filled with the currently active
		 *        background colour.
		 */
		public function printFrame(x:uint, y:uint, w:uint, h:uint, s:String = null,
			clear:Boolean = false, bgMode:int = 0):void
		{
			// TODO Implement method!
		}
		
		
		/**
		 * This method sets the fading parameters, allowing to easily fade the canvas
		 * to/from a color. Once they are set, the fading parameters are valid forever.
		 * You don't have to call fade for each rendered frame (unless you change the
		 * fading parameters).
		 * 
		 * @param amount The fading amount. 0 => the canvas is filled with the fading
		 *        color. 255 => no fading effect.
		 * @param color The color to use during the canvas flushing operation.
		 */
		public function fade(amount:int, color:uint):void
		{
			// TODO Implement method!
		}
		
		
		/**
		 * Disposes the canvas. The canvas cannot be used anymore after calling this method.
		 */
		public function dispose():void
		{
			cells = null;
			cellCount = 0;
		}
		
		
		/**
		 * Returns a String Representation of the class.
		 * 
		 * @return A String Representation of the class.
		 */
		public function toString():String
		{
			return "[RLCanvas, id=" + _id + ", width=" + _width +", height=" + _height + "]";
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Getters & Setters
		//-----------------------------------------------------------------------------------------
		
		/**
		 * The unique ID of the canvas.
		 */
		public function get id():String
		{
			return _id;
		}
		
		
		/**
		 * The width of the canvas, measured in cells.
		 */
		public function get width():uint
		{
			return _width;
		}
		
		
		/**
		 * The height of the canvas, measured in cells.
		 */
		public function get height():uint
		{
			return _height;
		}
		
		
		/**
		 * The default foreground color (text color) of the canvas. The default value
		 * is 0xFFFFFF.
		 */
		public function get color():uint
		{
			return _color;
		}
		public function set color(v:uint):void
		{
			if (v == _color) return;
			_color = v;
		}
		
		
		/**
		 * The default background color of the canvas. The default value is 0x000000.
		 */
		public function get backgroundColor():uint
		{
			return _backgroundColor;
		}
		public function set backgroundColor(v:uint):void
		{
			if (v == _backgroundColor) return;
			_backgroundColor = v;
		}
		
		
		/**
		 * The font that is used by the canvas.
		 */
		public function get font():RLFont
		{
			return _font;
		}
		
		
		/**
		 * The width of a single cell on the canvas.
		 */
		public function get cellWidth():int
		{
			return _cellWidth;
		}
		
		
		/**
		 * The height of a single cell on the canvas.
		 */
		public function get cellHeight():int
		{
			return _cellHeight;
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Callback Handlers
		//-----------------------------------------------------------------------------------------
		
		
		//-----------------------------------------------------------------------------------------
		// Private Methods
		//-----------------------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function init():void
		{
			cells = new Vector.<RLCell>(cellCount, true);
			for (var i:uint = 0; i < cellCount; i++)
			{
				cells[i] = new RLCell(32, _backgroundColor, _backgroundColor, 0);
				cells[i].changed = true;
			}
		}
		
		
		/**
		 * Returns the cell at coordinate x, y or null if no cell exists at that coord.
		 * @private
		 */
		private function getCellAt(x:uint, y:uint):RLCell
		{
			if (x >= _width || y >= _height) return null;
			return cells[int(y * _width + x)];
		}
	}
}

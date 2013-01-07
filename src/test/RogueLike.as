package 
{
	import com.hexagonstar.roguelib.core.RLCanvasManager;
	import com.hexagonstar.roguelib.core.RLFont;
	import com.hexagonstar.util.debug.Debug;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	
	[SWF(width="1024", height="640", backgroundColor="#222222", frameRate="60")]
	
	
	public class RogueLike extends Sprite
	{
		//-----------------------------------------------------------------------------------------
		// Properties
		//-----------------------------------------------------------------------------------------
		
		private var _canvasManager:RLCanvasManager;
		private var _timer:Timer;
		private var _frameRate:int = 30;
		
		
		//-----------------------------------------------------------------------------------------
		// Constructor
		//-----------------------------------------------------------------------------------------
		
		/**
		 * Creates a new instance of the class.
		 */
		public function RogueLike()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			Debug.monitor(stage);
			
			setup();
			start();
			
			//test();
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Public Methods
		//-----------------------------------------------------------------------------------------
		
		public function test():void
		{
//			var bmd1:BitmapData = new BitmapData(200, 200, true, 0xFFCCCCCC);
//			var seed:int = int(Math.random() * int.MAX_VALUE);
//			var channels:uint = BitmapDataChannel.RED | BitmapDataChannel.BLUE;
//			bmd1.perlinNoise(100, 80, 12, seed, false, true, channels, true, null);
			
			var bmd1:FontTerminal10x16 = new FontTerminal10x16();
			
			var bitmap1:Bitmap = new Bitmap(bmd1);
			addChild(bitmap1);
			
			var bmd2:BitmapData = new BitmapData(200, 256, true, 0xFFFF00FF);
			var pt:Point = new Point(0, 0);
			var rect:Rectangle = new Rectangle(0, 0, 200, 256);
			bmd2.threshold(bmd1, rect, pt, "<=", 0x555555, 0x00000000, 0xFFFF00, true);
			var bitmap2:Bitmap = new Bitmap(bmd2);
			bitmap2.x = bitmap1.x + bitmap1.width + 10;
			addChild(bitmap2);			
		}
		
		
		public function start():void
		{
			var delay:Number = 1000 / _frameRate;
			if (delay < 16.6) delay = 16.6;
			_timer.delay = delay;
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			//_timer.start();
			//return;
			
			Debug.trace(_canvasManager.dump());
			
			_canvasManager.hline(null, 1, 1, 78);
			_canvasManager.vline(null, 1, 1, 28);
			
			var c:int = 0;
			var i:int;
//			for (i = 0; i < 30; i++)
//			{
//				_canvasManager.printLeft(RLCanvasManager.BASE_CANVAS_ID, 0 + c, i, "The quick brown fox jumps over the lazy dog and starts to chew on his bone while the cat lurks in.");
//				c += 2;
//			}
//			
//			c = 0;
//			for (i = 0; i < 30; i++)
//			{
//				_canvasManager.printRight(RLCanvasManager.BASE_CANVAS_ID, 79 - c, i, "The quick brown fox jumps over the lazy dog and starts to chew on his bone while the cat lurks in.");
//				c += 2;
//			}
			
//			c = 0;
//			for (i = 0; i < 30; i++)
//			{
//				_canvasManager.printCenter(null, 40, i, generateString());
//				c += 2;
//			}
//			
//			c = 0;
//			var len:uint = _canvasManager.getCellCount();
//			for (i = 0; i < 80; i++)
//			{
//				_canvasManager.setCellColor(null, i, 0, generatorColor());
//			}
			
			for (var y:int = 0; y < 30; y++)
			{
				for (var x:int = 0; x < 80; x++)
				{
					_canvasManager.setCellProperties(null, x, y, generateCharCode(), generatorColor(), generatorColor());
				}
			}
			
//			_canvasManager.printCenter(RLCanvasManager.BASE_CANVAS_ID, 0, 0, "The quick brown fox jumps over the lazy dog.");
//			_canvasManager.printCenter(RLCanvasManager.BASE_CANVAS_ID, 40, 10, "The quick brown fox jumps over the lazy dog.");
//			_canvasManager.printCenter(RLCanvasManager.BASE_CANVAS_ID, 79, 15, "The quick brown fox jumps over the lazy dog.");
//			_canvasManager.printCenter(RLCanvasManager.BASE_CANVAS_ID, 40, 25, "The quick brown fox jumps over the lazy dog and starts to chew on his bone while the cat lurks in.");
//			_canvasManager.printCenter(RLCanvasManager.BASE_CANVAS_ID, 40, 29, "The quick brown fox jumps over the lazy dog and starts to chew on his bone while the cat lurks in");
			
			_canvasManager.flush();
		}
		
		
		/**
		 * @private
		 */
		public function generateCharCode():int
		{
			return Math.random() * 255;
		}
		
		
		/**
		 * @private
		 */
		public function generateString():String
		{
			var s:String = "";
			var c:int = (Math.random() * 90) + 10;
			while (c-- > 0)
			{
				s += String.fromCharCode(int(Math.random() * 255));
			}
			return s;
		}
		
		
		/**
		 * @private
		 */
		public function generatorColor():uint
		{
			return Math.random() * 0xFFFFFF;
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Getters & Setters
		//-----------------------------------------------------------------------------------------
		
		
		//-----------------------------------------------------------------------------------------
		// Callback Handlers
		//-----------------------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function onTimer(e:TimerEvent):void
		{
			//_canvasManager.clear();
			
			var x:int = Math.random() * 80;
			var y:int = Math.random() * 30;
			var c:int = Math.random() * 256;
			var cc:int = _canvasManager.getCellChar(RLCanvasManager.BASE_CANVAS_ID, x, y);
			if (cc == 32)
			{
				_canvasManager.setCellProperties(null, x, y, c, generatorColor(), generatorColor());
				_canvasManager.flush();
			}
			e.updateAfterEvent();
		}
		
		
		//-----------------------------------------------------------------------------------------
		// Private Methods
		//-----------------------------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private function setup():void
		{
			_canvasManager = RLCanvasManager.instance;
			
			var font:RLFont = new RLFont(new FontTerminal10x16(), 10, 16);
			var screen:Bitmap = _canvasManager.init(80, 30, font, 0xFFFFFF, 0x000000);
			screen.x = (stage.stageWidth * 0.5) - (screen.width * 0.5);
			screen.y = (stage.stageHeight * 0.5) - (screen.height * 0.5);
			addChild(screen);
			
			_timer = new Timer(1000);
		}
	}
}

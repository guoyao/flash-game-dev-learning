package me.guoyao.fps
{
	import flash.utils.getTimer;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.Color;

	public class FPS extends Sprite
	{
		private var bmpFontTF:TextField;
		
		private static var last:uint = getTimer();
		
		private static var ticks:uint = 0;
		
		private static var text:String = "--.- FPS";

		public function FPS()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}

		private function onAdded(e:Event):void
		{
			bmpFontTF = new TextField(70, 70, "... FPS");
			bmpFontTF.border = true;
			bmpFontTF.color = Color.WHITE;
			addChild(bmpFontTF);
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
		}

		public function onFrame(e:Event):void
		{
			ticks++;
			var now:uint = getTimer();
			var delta:uint = now - last;
			if (delta >= 1000)
			{
				var fps:Number = ticks / delta * 1000;
				text = fps.toFixed(1) + " FPS";
				ticks = 0;
				last = now;
			}
			bmpFontTF.text = text;
		}
	}
}

package me.guoyao
{
	import flash.geom.Rectangle;
	
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;

	public class Game1 extends Sprite
	{
		private var q:Quad;
		
		private var rect:Rectangle = new Rectangle(0, 0, 0, 0);

		public function Game1()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}

		private function onAdded(e:Event):void
		{
			// listen to the event 
			stage.addEventListener(ResizeEvent.RESIZE, onResize); 
			q = new Quad(200, 200);
			q.color = 0xff3330;
			q.x = stage.stageWidth - q.width >> 1;
			q.y = stage.stageHeight - q.height >> 1;
			addChild(q);
		}

		private function onResize(event:ResizeEvent):void
		{
			// set rect dimmensions
			rect.width = event.width, rect.height = event.height; 
			// resize the viewport
			Starling.current.viewPort = rect;
			// assign the new stage width and height 
			stage.stageWidth = event.width;
			stage.stageHeight = event.height;
			// repositions our quad
			q.x = stage.stageWidth - q.width >> 1;
			q.y = stage.stageHeight - q.height >> 1;
		}
	}
}

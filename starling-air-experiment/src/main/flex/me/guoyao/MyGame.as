package me.guoyao
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class MyGame extends Sprite
	{
		public function MyGame()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
		}
		
		private function addToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStageHandler);
			var shape:Shape = new Shape();
			var color:Number;
			var radius:int;
			var bitmapData:BitmapData;
			var texture:Texture;
			var image:Image;
			for (var i:int = 0; i < 200; i++)
			{
				shape.graphics.clear();
				radius = 10 + Math.random() * 10;
				color = Math.random() * 0xffffff;
				shape.graphics.beginFill(color);
				shape.graphics.drawCircle(radius, radius, radius);
				shape.graphics.endFill();
				bitmapData = new BitmapData(radius * 2, radius * 2, true, color);
				bitmapData.draw(shape);
				texture = Texture.fromBitmapData(bitmapData);
				image = new Image(texture);
				addChild(image);
//				image.x = stage.stageWidth - image.width >> 1;
//				image.y = stage.stageHeight - image.height >> 1;
				image.x = Math.random() * stage.stageWidth;
				image.y = Math.random() * stage.stageHeight;
			}
		}
	}
}
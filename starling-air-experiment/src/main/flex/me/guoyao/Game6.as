package me.guoyao
{
	import flash.display.Bitmap;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.deg2rad;

	public class Game6 extends Sprite
	{
		private var container:Sprite;
		
		private static const NUM_PIGS:uint = 400;
		
		[Embed(source = "/../resources/assets/table-tennis.png")]
		private static const TableTennis:Class;

		public function Game6()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}

		private function onAdded(e:Event):void
		{
			container = new Sprite();
			// change the registration point
			container.pivotX = stage.stageWidth >> 1;
			container.pivotY = stage.stageHeight >> 1;
			container.x = stage.stageWidth >> 1;
			container.y = stage.stageHeight >> 1;
			var bitmap:Bitmap = new TableTennis();
			var texture:Texture = Texture.fromBitmap(bitmap);
			for (var i:uint = 0; i < NUM_PIGS; i++)
			{
				var pig:Image = new Image(texture);
				pig.x = Math.random() * stage.stageWidth;
				pig.y = Math.random() * stage.stageHeight;
				pig.rotation = deg2rad(Math.random() * 360);
				container.addChild(pig);
			}
			container.pivotX = stage.stageWidth >> 1;
			container.pivotY = stage.stageHeight >> 1;
			container.flatten();
			addChild(container);
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
		}

		private function onFrame(e:Event):void
		{
			container.rotation += .1;
		}
	}
}

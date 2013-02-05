package me.guoyao
{
	import flash.display.Bitmap;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.deg2rad;

	public class Game2 extends Sprite
	{
		private var sausagesVector:Vector.<CustomImage> = new Vector.<CustomImage>(NUM_SAUSAGES, true);

		private const NUM_SAUSAGES:uint = 400;

		[Embed(source = "/../resources/assets/1.png")]
		private static const Sausage:Class;

		public function Game2()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}

		private function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);

			// create a Bitmap object out of the embedded image
			var sausageBitmap:Bitmap = new Sausage();

			// create a Texture object to feed the Image object
			var texture:Texture = Texture.fromBitmap(sausageBitmap, false);

			for (var i:int = 0; i < NUM_SAUSAGES; i++)
			{
				// create a Image object with our one texture 
				var image:CustomImage = new CustomImage(texture);
				// set a random alpha, position, rotation 
				image.alpha = Math.random();
				image.destX = Math.random() * stage.stageWidth;
				image.destY = Math.random() * stage.stageWidth;
				// define a random initial position
				image.x = Math.random() * stage.stageWidth;
				image.y = Math.random() * stage.stageHeight;
				image.rotation = deg2rad(Math.random() * 360); // show it
				addChild(image);
				// store references for later
				sausagesVector[i] = image;
			}

			stage.addEventListener(Event.ENTER_FRAME, onFrame);
		}

		private function onFrame(e:Event):void
		{
			var lng:uint = sausagesVector.length;
			for (var i:int = 0; i < lng; i++)
			{
				// move the sausages around
				var sausage:CustomImage = sausagesVector[i];
				sausage.x -= (sausage.x - sausage.destX) * .1;
				sausage.y -= (sausage.y - sausage.destY) * .1;
				// when reached destination
				if (Math.abs(sausage.x - sausage.destX) < 1 && Math.abs(sausage.y - sausage.destY) < 1)
				{
					sausage.destX = Math.random() * stage.stageWidth;
					sausage.destY = Math.random() * stage.stageWidth;
					sausage.rotation = deg2rad(Math.random() * 360);
				}
			}
		}
	}
}

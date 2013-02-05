package me.guoyao
{
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	import me.guoyao.utils.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.RenderTexture;
	import starling.textures.Texture;

	public class Game10 extends Sprite
	{
		private var mRenderTexture:RenderTexture;
		private var mBrush:Image;
		
		public function Game10()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}

		private function onAdded(e:Event):void
		{
			// create a Texture object to feed the Image object 
			var texture:Texture = Assets.getTexture(Assets.TABLE_TENNIS);
			// create the texture to draw into the texture 
			mBrush = new Image(texture);
			// set the registration point
			mBrush.pivotX = mBrush.width >> 1;
			mBrush.pivotY = mBrush.height >> 1;
			// scale it
			mBrush.scaleX = mBrush.scaleY = 0.5;
			// creates the canvas to draw into
			mRenderTexture = new RenderTexture(stage.stageWidth, stage.stageHeight); // we encapsulate it into an Image object
			var canvas:Image = new Image(mRenderTexture);
			// show it
			addChild(canvas);
			// listen to mouse interactions on the stage 
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
		}

		private function onTouch(event:TouchEvent):void
		{
			// retrieves the entire set of touch points (in case of multiple fingers on a touch screen) 
			var touches:Vector.<Touch> = event.getTouches(this);
			for each (var touch:Touch in touches)
			{
				// if only hovering or click states, let's skip
				if (touch.phase == TouchPhase.HOVER || touch.phase == TouchPhase.ENDED)
					continue;
				// grab the location of the mouse or each finger 
				var location:Point = touch.getLocation(this);
				// positions the brush to draw
				mBrush.x = location.x;
				mBrush.y = location.y;
					// draw into the canvas 
				mRenderTexture.draw(mBrush);
			}
		}
	}
}

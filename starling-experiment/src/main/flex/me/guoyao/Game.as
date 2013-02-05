package me.guoyao
{
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class Game extends Sprite
	{
		private var customSprite:CustomSprite;

		private var mouseX:Number = 0;

		private var mouseY:Number = 0;

		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}

		private function onAdded(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);

			// create the custom sprite
			customSprite = new CustomSprite(200, 200);

			// positions it by default in the center of the stage
			// we add half width because of the registration point of the custom sprite (middle)
			customSprite.x = (stage.stageWidth - customSprite.width >> 1) + (customSprite.width >> 1);
			customSprite.y = (stage.stageHeight - customSprite.height >> 1) + (customSprite.height >> 1);
			mouseX = customSprite.x;
			mouseY = customSprite.y;

			// show it
			addChild(customSprite);

			// we listen to the mouse movement on the stage
			stage.addEventListener(TouchEvent.TOUCH, onTouch);

			// need to comment this one ? ;)
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
			
			customSprite.addEventListener(TouchEvent.TOUCH, onTouchedSprite);
		}

		private function onFrame(e:Event):void
		{
			// easing on the custom sprite position
			customSprite.x -= (customSprite.x - mouseX) * .1;
			customSprite.y -= (customSprite.y - mouseY) * .1;

			// we update our custom sprite
			customSprite.update();
		}
		
		private function onTouch (e:TouchEvent):void
		{
			// get the mouse location related to the stage
			var touch:Touch = e.getTouch(stage);
			if(touch)
			{
				var pos:Point = touch.getLocation(stage);
				// store the mouse coordinates
				mouseX = pos.x;
				mouseY = pos.y;
			}
		}

		private function onTouchedSprite(e:TouchEvent):void
		{
			// retrieves the touch points
			var touches:Vector.<Touch> = e.touches;
			// if two fingers
			if (touches.length == 2)
			{
				var finger1:Touch = touches[0];
				var finger2:Touch = touches[1];
				var distance:int;
				var dx:int;
				var dy:int;
				// if both fingers moving (dragging)
				if (finger1.phase == TouchPhase.MOVED && finger2.phase == TouchPhase.MOVED)
				{
					// calculate the distance between each axes
					dx = Math.abs(finger1.globalX - finger2.globalX);
					dy = Math.abs(finger1.globalY - finger2.globalY);
					// calculate the distance
					distance = Math.sqrt(dx * dx + dy * dy);
					trace(distance);
				}
			}
		}
	}
}

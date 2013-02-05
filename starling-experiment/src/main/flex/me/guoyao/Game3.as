package me.guoyao
{
	import flash.ui.Keyboard;
	
	import me.guoyao.utils.Assets;
	
	import starling.animation.Juggler;
	import starling.display.Button;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Game3 extends Sprite
	{
		private var mMovie:MovieClip;
		
		private var juggler:Juggler;
		
		private var button:Button;
		
		public function Game3()
		{
			juggler = new Juggler();
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		override public function dispose():void
		{
			juggler.purge();
			super.dispose();
		}

		private function onAdded(e:Event):void
		{
			// creates the XML file detailing the frames in the spritesheet 
			// creates a texture atlas (binds the spritesheet and XML description) 
			var sTextureAtlas:TextureAtlas = Assets.getTextureAtlas(Assets.SPRITE_SHEET, Assets.SPRITE_SHEET_XML);
			// retrieve the frames the running boy frames
			var frames:Vector.<Texture> = sTextureAtlas.getTextures("sprite-atlas"); // creates a MovieClip playing at 40fps
			mMovie = new MovieClip(frames, 40);
			mMovie.setFrameDuration(0, 1);
			mMovie.setFrameDuration(1, 1);
			mMovie.setFrameDuration(2, 1);
			mMovie.setFrameDuration(3, 1);
			// centers the MovieClip
			mMovie.x = stage.stageWidth - mMovie.width >> 1;
			mMovie.y = stage.stageHeight - mMovie.height >> 1; // show it
			addChild(mMovie);
			juggler.add(mMovie);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
			var buttonTexture:Texture = Assets.getTexture(Assets.BUTTON_SKIN, true, false, 1);
			button = new Button(buttonTexture, "Pause");
			button.x = stage.stageWidth - button.width - 10;
			button.y = 10;
			button.addEventListener(Event.TRIGGERED, buttonClickHandler);
			addChild(button);
		}
		
		private var step:int = 10;
		
		private var paused:Boolean;
		
		private function keyDownHandler(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.RIGHT)
				mMovie.x += step;
			else if(event.keyCode == Keyboard.LEFT)
				mMovie.x -= step;
			else if(event.keyCode == Keyboard.UP)
				mMovie.y -= step;
			else if(event.keyCode == Keyboard.DOWN)
				mMovie.y += step;
			
			if(mMovie.x <= 0 || mMovie.x >= stage.stageWidth)
				mMovie.x = 0;
			else if(mMovie.y <= 0 || mMovie.y >= stage.stageHeight)
				mMovie.y = 0;
		}
		
		private function buttonClickHandler(event:Event):void
		{
			paused = !paused;
			button.text = button.text == "Play" ? "Pause" : "Play";
		}
		
		private function enterFrameHandler(event:EnterFrameEvent):void
		{
			if(!paused)
				juggler.advanceTime(event.passedTime);
		}
	}
}

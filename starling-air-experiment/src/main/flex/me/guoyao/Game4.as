package me.guoyao
{
	import me.guoyao.utils.Assets;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class Game4 extends Sprite
	{
		private var backgroundContainer:Sprite;

		private var background1:Image;

		private var background2:Image;

		// sections
		private var sections:Vector.<String> = Vector.<String>(["Play", "Options", "Rules", "Sign in"]);

		public function Game4()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}

		private function onAdded(e:Event):void
		{
			var texture:Texture = Assets.getTexture(Assets.BUTTON_SKIN);
			var textureBackground:Texture = Assets.getTexture(Assets.BACKGROUND_SKIN);
			backgroundContainer = new Sprite();
			background1 = new Image(textureBackground);
			background2 = new Image(textureBackground);
			background2.x = background1.width;
			backgroundContainer.addChild(background1);
			backgroundContainer.addChild(background2);
			addChild(backgroundContainer);
			var menuContainer:Sprite = new Sprite();
			var numSections:uint = sections.length
			for (var i:uint = 0; i < 4; i++)
			{
				var myButton:Button = new Button(texture, sections[i]);
				myButton.fontBold = true;
				myButton.y = myButton.height * i;
				menuContainer.addChild(myButton);
			}
			menuContainer.addEventListener(Event.TRIGGERED, onTriggered);
			stage.addEventListener(Event.ENTER_FRAME, onFrame);
			menuContainer.x = stage.stageWidth - menuContainer.width >> 1;
			menuContainer.y = stage.stageHeight - menuContainer.height >> 1;
			addChild(menuContainer);
		}

		private function onTriggered(e:Event):void
		{
			// outputs : [object Sprite] [object Button] 
			trace(e.currentTarget, e.target);
			// outputs : triggered!
			trace("triggered!");
		}

		private function onFrame(e:Event):void
		{
			// scroll it
			backgroundContainer.x -= 6;
			// reset
			if (backgroundContainer.x <= -background1.width)
				backgroundContainer.x = 0;
		}
	}
}

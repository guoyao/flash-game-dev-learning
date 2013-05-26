package me.guoyao.starWars.screens
{
	import me.guoyao.starWars.characters.Hero;
	import me.guoyao.starWars.utils.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class WelCome extends Sprite
	{
		private var backgroundImage:Image;
		
		private var hero:Hero;
		
		public function WelCome()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			drawScreen();
		}
		
		private function drawScreen():void
		{
			backgroundImage = new Image(Assets.getTexture(Assets.WELCOME_BACKGROUND));
			backgroundImage.width = stage.stageWidth;
			backgroundImage.height = stage.stageHeight;
			addChild(backgroundImage);
			hero = new Hero();
			addChild(hero);
			hero.x = stage.stageWidth >> 1;
			hero.y = stage.stageHeight - hero.height / 2;
		}
	}
}
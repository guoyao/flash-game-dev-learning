package me.guoyao.starWars.screens
{
	import me.guoyao.starWars.utils.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class WelCome extends Sprite
	{
		private var backgroundImage:Image;
		
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
		}
	}
}
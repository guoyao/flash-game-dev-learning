package me.guoyao.starWars.characters
{
	import me.guoyao.starWars.utils.Assets;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	public class Hero extends Sprite
	{
		private var heroArt:Image;

		public function Hero()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}

		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			createHeroArt();
		}

		private function createHeroArt():void
		{
			heroArt = new Image(Assets.getTexture(Assets.HERO));
			heroArt.x = Math.ceil(-heroArt.width / 2);
			heroArt.y = Math.ceil(-heroArt.height / 2);
			addChild(heroArt);
		}
	}
}

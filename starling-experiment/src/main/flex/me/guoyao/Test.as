package me.guoyao
{
	import me.guoyao.utils.Assets;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Test extends Sprite
	{
		public function Test()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			var image:Image = new Image(Assets.getTextureAtlas(Assets.SPRITE_SHEET, Assets.SPRITE_SHEET_XML).getTexture("sprite-atlas0001"));
			image.pivotX = image.width >> 1;
			image.pivotY = image.height >> 1;
			image.x = stage.stageWidth >> 1;
			image.y = stage.stageHeight >> 1;
			image.scaleX = -1;
			addChild(image);
		}
	}
}
package me.guoyao
{
	import Box2D.Common.Math.b2Vec2;
	
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	import me.guoyao.core.StarlingCitrusEngine;
	import me.guoyao.core.StarlingState;
	import me.guoyao.utils.Assets;
	
	import starling.display.Image;
	
	public class GameState extends me.guoyao.core.StarlingState
	{
		private static const FLOOR_HEIGHT:int = 20;
		
		public function GameState(engine:StarlingCitrusEngine = null)
		{
			super(engine);
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			var physics:Box2D = new Box2D("box2d", {gravity:new b2Vec2(0, 9.81)});
//			physics.visible = true;
			add(physics);
			
			var floor:Platform = new Platform("floor", {x:stage.stageWidth / 2, y:stage.stageHeight - 10, width:stage.stageWidth, height:FLOOR_HEIGHT});
			floor.view = new Image(Assets.textureFromDraw(stage.stageWidth, 20, 0x999999));
			add(floor);
			
//			var hills:Hills = new Hills("hills");
//			hills.view = new Image(Assets.textureFromDraw(stage.stageWidth, 20, 0x999999));
//			add(hills);
			
			var image:Image = Assets.imageFromSpriteSheet("hero-mary-small");
			var hero:Hero = new Hero("hero", {x:image.width / 2, y:stage.stageHeight - FLOOR_HEIGHT - image.height / 2, width:image.width, height:image.height});
			hero.view = image;
			add(hero);
			
			image = Assets.imageFromSpriteSheet("enemy-mushroom-small");
			var enemy:Enemy = new Enemy("mushroom", {x:stage.stageWidth - image.width, y:stage.stageHeight - FLOOR_HEIGHT - image.height, width:image.width, height:image.height, leftBound:image.width / 2, rightBound:stage.stageWidth - image.width / 2});
			enemy.view = image;
			add(enemy);
		}
	}
}
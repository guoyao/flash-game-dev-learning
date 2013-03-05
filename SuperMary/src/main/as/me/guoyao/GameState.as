package me.guoyao
{
	import Box2D.Common.Math.b2Vec2;
	
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	import me.guoyao.core.StarlingCitrusEngine;
	import me.guoyao.core.StarlingState;
	import me.guoyao.utils.Assets;
	
	import starling.display.Image;
	
	public class GameState extends me.guoyao.core.StarlingState
	{
		public function GameState(engine:StarlingCitrusEngine = null)
		{
			super(engine);
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			var physics:Box2D = new Box2D("box2d", {gravity:new b2Vec2(0, 9.81)});
			physics.visible = true;
			add(physics);
			
			var floor:Platform = new Platform("floor", {x:stage.stageWidth / 2, y:stage.stageHeight - 10, width:stage.stageWidth, height:20});
			add(floor);
			
			var hero:Hero = new Hero("hero", {x:32, width:64, height:64});
			hero.view = new Image(Assets.getTextureAtlas(Assets.HERO, Assets.HERO_XML).getTexture("hero-big"));
			add(hero);
		}
	}
}
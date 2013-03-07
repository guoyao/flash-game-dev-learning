package me.guoyao
{
	import flash.geom.Rectangle;
	
	import Box2D.Common.Math.b2Vec2;
	
	import citrus.math.MathVector;
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	import me.guoyao.core.StarlingState;
	import me.guoyao.support.GameConstants;
	import me.guoyao.utils.Assets;
	import me.guoyao.utils.ObjectUtil;
	
	import starling.display.Image;
	
	public class GameState extends me.guoyao.core.StarlingState
	{
		private static const FLOOR_HEIGHT:int = 50;
		
		public function GameState()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			var physics:Box2D = new Box2D("box2d", {gravity:new b2Vec2(0, 9.81)});
//			physics.visible = true;
			add(physics);
			
			add(new CitrusSprite("background", ObjectUtil.extend(Assets.imageFromTexture(Assets.BACKGROUND))));
			
			add(new Platform("leftBound", {x:-1, y:stage.stageHeight / 2, width:2, height:stage.stageHeight}));
			add(new Platform("rightBound", {x:GameConstants.VIEW_PORT.x + 1, y:stage.stageHeight / 2, width:2, height:stage.stageHeight}));
			add(new Platform("topBound", {x:GameConstants.VIEW_PORT.x / 2, y:-1, width:GameConstants.VIEW_PORT.x, height:2}));
			
			add(new Platform("floor-0", {x:504, y:stage.stageHeight - FLOOR_HEIGHT / 2, width:1008, height:FLOOR_HEIGHT}));
			
			add(new Platform("floor-1", {x:1253, y:stage.stageHeight - 90, width:586, height:10}));
			add(new Platform("floor-2", {x:1108, y:stage.stageHeight - 190, width:176, height:10}));
			
			var image:Image = Assets.imageFromTextureAtlas("hero-mary-small");
			var hero:Hero = new Hero("hero", ObjectUtil.extend(image, {x:image.width / 2, y:stage.stageHeight - FLOOR_HEIGHT - image.height / 2}));
			hero.acceleration = 0.1;
			hero.maxVelocity = 4;
			hero.jumpAcceleration = 0.1;
			add(hero);
			
			image = Assets.imageFromTextureAtlas("enemy-mushroom-small");
			var enemy:Enemy = new Enemy("mushroom", ObjectUtil.extend(image, {x:stage.stageWidth - image.width, y:stage.stageHeight - FLOOR_HEIGHT - image.height, leftBound:image.width / 2, rightBound:1000}));
			add(enemy);
			
//			add(new PhysicsEditorObjects("hamburger", ObjectUtil.extend(Assets.imageFromTextureAtlas("hamburger"), {x:300})));
			
//			add(new PhysicsEditorObjects("icecream", ObjectUtil.extend(Assets.imageFromTextureAtlas("icecream"), {x:300})));
			
			view.camera.setUp(hero, new MathVector(320, 240), new Rectangle(0, 0, GameConstants.VIEW_PORT.x, GameConstants.VIEW_PORT.y), new MathVector(.25, .05));
		}
	}
}
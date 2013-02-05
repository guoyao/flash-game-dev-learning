package starling.box2d
{
	import Box2D.Dynamics.Contacts.b2Contact;
	
	import citrus.core.starling.StarlingState;
	import citrus.objects.platformer.box2d.Coin;
	import citrus.objects.platformer.box2d.Enemy;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.MovingPlatform;
	import citrus.objects.platformer.box2d.Platform;
	import citrus.physics.box2d.Box2D;
	
	public class GameStage extends StarlingState
	{
		[Embed(source="/../resources/images/giants.png")]
		private var giants:Class; 
		
		[Embed(source="/../resources/images/tigers.png")]
		private var tigers:Class; 
		
		[Embed(source="/../resources/images/ring.png")]
		private var ring:Class; 
		
		public function GameStage()
		{
			super();
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			var physics:Box2D = new Box2D("box2d");
			physics.visible = true;
			add(physics);
			
			var floor:Platform = new Platform("floor", {x:512, y:748, width:1024, height:40});
			add(floor);
			
			var p1:Platform = new Platform("p1", {x:874, y:151, width:300, height:40});
			add(p1);
			
			var mp:MovingPlatform = new MovingPlatform("moving", {x:220, y:700, width:200, height:40, startX:220, startY:700, endX:500, endY:151});
			add(mp);
			
			var hero:Hero = new Hero("hero", {x:50, y:50, width:70, height:70});
			hero.view = new giants();
			add(hero);
			
			var enemy:Enemy = new Enemy("enemy", {x:900, y:700, width:70, height:70, leftBound:10, rightBound:1000});
			enemy.view = new tigers();
			add(enemy);
			
			var goal:Coin = new Coin("ring", {x:967, y:90, width:79, height:79});
			goal.view = new ring();
			goal.onBeginContact.add(function (c:b2Contact):void {
				trace("Giants win!");
			});
			add(goal);
		}
	}
}
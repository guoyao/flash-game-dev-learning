package me.guoyao
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	
	import me.guoyao.support.CustomContact;
	import me.guoyao.support.GameConstants;
	import me.guoyao.support.UserData;
	import me.guoyao.utils.GameUtil;
	import me.guoyao.utils.UnitUtil;
	
	public class Ball extends Sprite
	{
		private var world:b2World;
		
		public function Ball()
		{
			world = new b2World(new b2Vec2(0, 9.81), true);
			world.SetContactListener(new CustomContact());
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(UnitUtil.pixelsToMeters(320), UnitUtil.pixelsToMeters(30));
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData = new UserData(false, "ball");
			var circleShape:b2CircleShape = new b2CircleShape(UnitUtil.pixelsToMeters(25));
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = circleShape;
			fixtureDef.density = 1;
			fixtureDef.restitution = 0.6;
			fixtureDef.friction = 0.1;
			var theBall:b2Body = world.CreateBody(bodyDef);
			theBall.CreateFixture(fixtureDef);
			
			GameUtil.ground(world);
			GameUtil.debugDraw(this, world);
			
			addEventListener(Event.ENTER_FRAME, updateWorld);
		}
		
		private function updateWorld(e:Event):void
		{
			world.Step(GameConstants.TIME_STEP, GameConstants.VELOCITY_ITERATIONS, GameConstants.POSITION_ITERATIONS);
			world.ClearForces();
			world.DrawDebugData();
		}
	}
}
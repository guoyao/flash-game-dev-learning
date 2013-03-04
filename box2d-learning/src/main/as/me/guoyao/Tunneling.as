package me.guoyao
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Contacts.b2Contact;
	import Box2D.Dynamics.Contacts.b2ContactEdge;
	
	import me.guoyao.support.GameConstants;
	import me.guoyao.support.UserData;
	import me.guoyao.utils.GameUtil;
	import me.guoyao.utils.UnitUtil;

	public class Tunneling extends Sprite
	{
		private var world:b2World;

		public function Tunneling()
		{
			world = new b2World(new b2Vec2(0, 5), true);
			GameUtil.debugDraw(this, world);
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(UnitUtil.pixelsToMeters(320), UnitUtil.pixelsToMeters(470));
			bodyDef.userData = new UserData(false, "floor");
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(UnitUtil.pixelsToMeters(320), UnitUtil.pixelsToMeters(10));
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = 1;
			fixtureDef.restitution = 0.5;
			fixtureDef.friction = 0.5;
			fixtureDef.isSensor = true;
			var body:b2Body = world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			bodyDef.position.Set(UnitUtil.pixelsToMeters(600), UnitUtil.pixelsToMeters(240));
			bodyDef.userData = new UserData(false, "barrier");
//			bodyDef.type = b2Body.b2_dynamicBody;
			polygonShape.SetAsBox(UnitUtil.pixelsToMeters(10), UnitUtil.pixelsToMeters(220));
			var body2:b2Body = world.CreateBody(bodyDef);
			body2.CreateFixture(fixtureDef);
			bodyDef.position.Set(UnitUtil.pixelsToMeters(320), UnitUtil.pixelsToMeters(455));
			bodyDef.bullet = true;
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData = new UserData(false, "bullet");
			polygonShape.SetAsBox(UnitUtil.pixelsToMeters(5), UnitUtil.pixelsToMeters(5));
			fixtureDef.isSensor = false;
			var body3:b2Body = world.CreateBody(bodyDef);
			body3.CreateFixture(fixtureDef);
			body3.SetLinearVelocity(new b2Vec2(100, -10));
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			stage.addEventListener(MouseEvent.CLICK, updateWorld);
		}
		
		private function updateWorld(e:Event):void
		{
			world.Step(GameConstants.TIME_STEP, GameConstants.VELOCITY_ITERATIONS, GameConstants.POSITION_ITERATIONS);
			world.ClearForces();
			for (var b:b2Body = world.GetBodyList(); b; b = b.GetNext())
			{
				for (var c:b2ContactEdge = b.GetContactList(); c; c = c.next)
				{
					var contact:b2Contact = c.contact;
					var fixtureA:b2Fixture = contact.GetFixtureA();
					var fixtureB:b2Fixture = contact.GetFixtureB();
					var bodyA:b2Body = fixtureA.GetBody();
					var bodyB:b2Body = fixtureB.GetBody();
					var userDataA:UserData = bodyA.GetUserData();
					var userDataB:UserData = bodyB.GetUserData();
					if (userDataA.name == "barrier" || userDataB.name == "barrier")
					{
						trace(userDataA + "->" + userDataB);
					}
				}
			}
			world.DrawDebugData();
		}
	}
}

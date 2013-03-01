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
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2MouseJoint;
	import Box2D.Dynamics.Joints.b2MouseJointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	import me.guoyao.support.GameConstants;
	import me.guoyao.utils.GameUtil;
	import me.guoyao.utils.UnitUtil;

	public class JointAndMotor extends Sprite
	{
		private var world:b2World;
		
		private var mouseJoint:b2MouseJoint;

		public function JointAndMotor()
		{
			world = new b2World(new b2Vec2(0, 9.81), true);
			GameUtil.debugDraw(this, world);
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(UnitUtil.pixelsToMeters(320), UnitUtil.pixelsToMeters(470));
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(UnitUtil.pixelsToMeters(320), UnitUtil.pixelsToMeters(10));
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			var groundBody:b2Body = world.CreateBody(bodyDef);
			groundBody.CreateFixture(fixtureDef);
			bodyDef.position.Set(UnitUtil.pixelsToMeters(320), UnitUtil.pixelsToMeters(430));
			bodyDef.type = b2Body.b2_dynamicBody;
			polygonShape.SetAsBox(UnitUtil.pixelsToMeters(30), UnitUtil.pixelsToMeters(30));
			fixtureDef.density = 1;
			fixtureDef.friction = 0.5;
			fixtureDef.restitution = 0.2;
			var box2:b2Body = world.CreateBody(bodyDef);
			box2.CreateFixture(fixtureDef);
			bodyDef.position.Set(UnitUtil.pixelsToMeters(420), UnitUtil.pixelsToMeters(430));
			var box3:b2Body = world.CreateBody(bodyDef);
			box3.CreateFixture(fixtureDef);
			var dJoint:b2DistanceJointDef = new b2DistanceJointDef();
			dJoint.bodyA = box2;
			dJoint.bodyB = box3;
			dJoint.localAnchorA = new b2Vec2(0, 0);
			dJoint.localAnchorB = new b2Vec2(0, 0);
			dJoint.length = UnitUtil.pixelsToMeters(100);
			var distanceJoint:b2DistanceJoint = world.CreateJoint(dJoint) as b2DistanceJoint;
			bodyDef.position.Set(UnitUtil.pixelsToMeters(320), UnitUtil.pixelsToMeters(240));
			var box4:b2Body = world.CreateBody(bodyDef);
			box4.CreateFixture(fixtureDef);
			var rJoint:b2RevoluteJointDef = new b2RevoluteJointDef();
			rJoint.bodyA = box4;
			rJoint.bodyB = world.GetGroundBody();
			rJoint.localAnchorA = new b2Vec2(0, 0);
			rJoint.localAnchorB = box4.GetWorldCenter();
			var revoluteJoint:b2RevoluteJoint = world.CreateJoint(rJoint) as b2RevoluteJoint;
			addEventListener(Event.ENTER_FRAME, updateWorld);
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, createJoint);
		}
		
		private function createJoint(e:MouseEvent):void 
		{
			world.QueryPoint(queryCallback, GameUtil.mouseToWorld(mouseX, mouseY));
		}
		
		private function queryCallback(fixture:b2Fixture):Boolean
		{
			var touchedBody:b2Body = fixture.GetBody();
			if (touchedBody.GetType() == b2Body.b2_dynamicBody)
			{
				var jointDef:b2MouseJointDef = new b2MouseJointDef();
				jointDef.bodyA = world.GetGroundBody();
				jointDef.bodyB = touchedBody;
				jointDef.target = GameUtil.mouseToWorld(mouseX, mouseY);
				jointDef.maxForce = 1000 * touchedBody.GetMass();
				mouseJoint = world.CreateJoint(jointDef) as b2MouseJoint;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, moveJoint);
				stage.addEventListener(MouseEvent.MOUSE_UP, killJoint);
			}
			return false;
		}
		
		private function moveJoint(e:MouseEvent):void 
		{
			mouseJoint.SetTarget(GameUtil.mouseToWorld(mouseX, mouseY));
		}

		private function killJoint(e:MouseEvent):void
		{
			world.DestroyJoint(mouseJoint);
			mouseJoint = null;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveJoint);
			stage.removeEventListener(MouseEvent.MOUSE_UP, killJoint);
		}

		private function updateWorld(e:Event):void
		{
			world.Step(GameConstants.TIME_STEP, GameConstants.VELOCITY_ITERATIONS, GameConstants.POSITION_ITERATIONS);
			world.ClearForces();
			world.DrawDebugData();
		}
	}
}

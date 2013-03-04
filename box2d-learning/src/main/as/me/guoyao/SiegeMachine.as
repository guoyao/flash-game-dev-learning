package me.guoyao
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import Box2D.Dynamics.Joints.b2DistanceJoint;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;
	
	import me.guoyao.support.AngryBirdContact;
	import me.guoyao.support.GameConstants;
	import me.guoyao.support.UserData;
	import me.guoyao.utils.GameUtil;
	import me.guoyao.utils.UnitUtil;

	public class SiegeMachine extends Sprite
	{
		private var world:b2World;

		private var left:Boolean = false;

		private var right:Boolean = false;

		private var frj:b2RevoluteJoint;

		private var rrj:b2RevoluteJoint;

		private var motorSpeed:Number = 0;

		private var sling:b2DistanceJoint;

		public function SiegeMachine()
		{
			world = new b2World(new b2Vec2(0, 5), true);
			world.SetContactListener(new AngryBirdContact());
			GameUtil.debugDraw(this, world);
			GameUtil.ground(world, 320, 465, 320, 10);
			GameUtil.brick(world, 402, 431, 140, 36);
			GameUtil.brick(world, 544, 431, 140, 36);
			GameUtil.brick(world, 342, 396, 16, 32);
			GameUtil.brick(world, 604, 396, 16, 32);
			GameUtil.brick(world, 416, 347, 16, 130);
			GameUtil.brick(world, 532, 347, 16, 130);
			GameUtil.brick(world, 474, 273, 132, 16);
			GameUtil.brick(world, 474, 257, 32, 16);
			GameUtil.brick(world, 445, 199, 16, 130);
			GameUtil.brick(world, 503, 199, 16, 130);
			GameUtil.brick(world, 474, 125, 58, 16);
			GameUtil.brick(world, 474, 100, 32, 32);
			GameUtil.brick(world, 474, 67, 16, 32);
			GameUtil.brick(world, 474, 404, 64, 16);
			GameUtil.brick(world, 450, 363, 16, 64);
			GameUtil.brick(world, 498, 363, 16, 64);
			GameUtil.brick(world, 474, 322, 64, 16);
			pig(474, 232, 16);
			var frontCart:b2Body = addCart(200, 430, true);
			var rearCart:b2Body = addCart(100, 430, false);
			var dJoint:b2DistanceJointDef = new b2DistanceJointDef();
			dJoint.bodyA = frontCart;
			dJoint.bodyB = rearCart;
			dJoint.localAnchorA = new b2Vec2(0, 0);
			dJoint.localAnchorB = new b2Vec2(0, 0);
			dJoint.length = UnitUtil.pixelsToMeters(100);
			var distanceJoint:b2DistanceJoint = world.CreateJoint(dJoint) as b2DistanceJoint;
			addEventListener(Event.ENTER_FRAME, updateWorld);
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}

		private function onAddToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
		}

		private function addCart(pX:Number, pY:Number, motor:Boolean):b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(UnitUtil.pixelsToMeters(pX), UnitUtil.pixelsToMeters(pY));
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData = new UserData(false, "cart");
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(UnitUtil.pixelsToMeters(40), UnitUtil.pixelsToMeters(20));
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = 10;
			fixtureDef.restitution = 0.5;
			fixtureDef.friction = 0.5;
			var body:b2Body = world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			if (!motor)
			{
				var armOrigin:b2Vec2 = new b2Vec2(0, UnitUtil.pixelsToMeters(-60));
				var armW:Number = UnitUtil.pixelsToMeters(5);
				var armH:Number = UnitUtil.pixelsToMeters(60);
				polygonShape.SetAsOrientedBox(armW, armH, armOrigin);
				body.CreateFixture(fixtureDef);
				bodyDef.position.Set(UnitUtil.pixelsToMeters(pX), UnitUtil.pixelsToMeters(pY - 115));
				polygonShape.SetAsBox(UnitUtil.pixelsToMeters(40), UnitUtil.pixelsToMeters(5));
				fixtureDef.shape = polygonShape;
				fixtureDef.filter.categoryBits = 0x0002;
				fixtureDef.filter.maskBits = 0x0002;
				var arm:b2Body = world.CreateBody(bodyDef);
				arm.CreateFixture(fixtureDef);
				var armJoint:b2RevoluteJointDef;
				armJoint = new b2RevoluteJointDef();
				armJoint.bodyA = body;
				armJoint.bodyB = arm;
				armJoint.localAnchorA.Set(0, UnitUtil.pixelsToMeters(-115));
				armJoint.localAnchorB.Set(0, 0);
				armJoint.enableMotor = true;
				armJoint.maxMotorTorque = 1000;
				armJoint.motorSpeed = 6;
				var siege:b2RevoluteJoint = world.CreateJoint(armJoint) as b2RevoluteJoint;
				bodyDef.position.Set(UnitUtil.pixelsToMeters(pX - 80), UnitUtil.pixelsToMeters(pY - 115));
				bodyDef.bullet = true;
				bodyDef.userData = new UserData(false, "projectile");
				polygonShape.SetAsBox(UnitUtil.pixelsToMeters(5), UnitUtil.pixelsToMeters(5));
				fixtureDef.shape = polygonShape;
				fixtureDef.filter.categoryBits = 0x0004;
				fixtureDef.filter.maskBits = 0x0004;
				var projectile:b2Body = world.CreateBody(bodyDef);
				projectile.CreateFixture(fixtureDef);
				bodyDef.bullet = false;
				var slingJoint:b2DistanceJointDef = new b2DistanceJointDef();
				slingJoint.bodyA = arm;
				slingJoint.bodyB = projectile;
				slingJoint.localAnchorA.Set(UnitUtil.pixelsToMeters(-40), 0);
				slingJoint.localAnchorB.Set(0, 0);
				slingJoint.length = UnitUtil.pixelsToMeters(40);
				sling = world.CreateJoint(slingJoint) as b2DistanceJoint;
			}
			var frontWheel:b2Body = addWheel(pX + 20, pY + 15);
			var rearWheel:b2Body = addWheel(pX - 20, pY + 15);
			var rJoint:b2RevoluteJointDef = new b2RevoluteJointDef();
			rJoint.bodyA = body;
			rJoint.bodyB = frontWheel;
			rJoint.localAnchorA.Set(UnitUtil.pixelsToMeters(20), UnitUtil.pixelsToMeters(15));
			rJoint.localAnchorB.Set(0, 0);
			if (motor)
			{
				rJoint.enableMotor = true;
				rJoint.maxMotorTorque = 1000;
				rJoint.motorSpeed = 0;
				frj = world.CreateJoint(rJoint) as b2RevoluteJoint;
			}
			else
				world.CreateJoint(rJoint) as b2RevoluteJoint;

			rJoint.bodyB = rearWheel;
			rJoint.localAnchorA.Set(UnitUtil.pixelsToMeters(-20), UnitUtil.pixelsToMeters(15));
			if (motor)
				rrj = world.CreateJoint(rJoint) as b2RevoluteJoint;
			else
				world.CreateJoint(rJoint) as b2RevoluteJoint;

			return body;
		}

		private function addWheel(pX:Number, pY:Number):b2Body
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(UnitUtil.pixelsToMeters(pX), UnitUtil.pixelsToMeters(pY));
			bodyDef.type = b2Body.b2_dynamicBody;
			var circleShape:b2CircleShape = new b2CircleShape(0.5);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = circleShape;
			fixtureDef.density = 1;
			fixtureDef.restitution = 0.5;
			fixtureDef.friction = 0.5;
			var body:b2Body = world.CreateBody(bodyDef);
			body.CreateFixture(fixtureDef);
			return body;
		}
		
		private function pig(pX:int, pY:int, r:Number):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(UnitUtil.pixelsToMeters(pX), UnitUtil.pixelsToMeters(pY));
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData = new UserData(false, "pig");
			var pigShape:b2CircleShape = new b2CircleShape(UnitUtil.pixelsToMeters(r));
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = pigShape;
			fixtureDef.density = 1;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			var thePig:b2Body = world.CreateBody(bodyDef);
			thePig.CreateFixture(fixtureDef);
		}

		private function keyPressed(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case 37:
					left = true;
					break;
				case 39:
					right = true;
					break;
				case 38 :
					world.DestroyJoint(sling);
					break;
			}
		}

		private function keyReleased(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case 37:
					left = false;
					break;
				case 39:
					right = false;
					break;
			}
		}

		private function updateWorld(e:Event):void
		{
			if (left)
				motorSpeed -= 0.1;
			if (right)
				motorSpeed += 0.1;

//			motorSpeed *= 0.99;
			if (motorSpeed > 5)
				motorSpeed = 5;
			if (motorSpeed < -5)
				motorSpeed = -5;

			frj.SetMotorSpeed(motorSpeed);
			rrj.SetMotorSpeed(motorSpeed);

			world.Step(GameConstants.TIME_STEP, GameConstants.VELOCITY_ITERATIONS, GameConstants.POSITION_ITERATIONS);
			world.ClearForces();
			
			for (var body:b2Body = world.GetBodyList(); body; body = body.GetNext())
			{
				if (body.GetUserData() is UserData && (body.GetUserData() as UserData).breakable)
				{
					world.DestroyBody(body);
				}
			}
			
			world.DrawDebugData();
		}
	}
}

package me.guoyao
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
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
	
	public class Totem extends Sprite
	{
		private var world:b2World;
		
		private var textMon:TextField;
		
		private var gameOver:Boolean = false;
		
		public function Totem()
		{
			world = new b2World(new b2Vec2(0, 5), true);
			GameUtil.debugDraw(this, world);

			textMon = new TextField();
			textMon.x = 100;
			textMon.textColor = 0xffffff;
			textMon.width = 300;
			textMon.height = 300;
			var textFormat:TextFormat = new TextFormat();
			textFormat.size = 25;
			textMon.defaultTextFormat = textFormat;
			addChild(textMon);
			
			var breakableBrickUserData:UserData = new UserData(true);
			var unbreakableBrickUserData:UserData = new UserData();

			GameUtil.brick(world, 275, 435, 30, 30, breakableBrickUserData);
			GameUtil.brick(world, 365, 435, 30, 30, breakableBrickUserData);
			GameUtil.brick(world, 320, 405, 120, 30, breakableBrickUserData);
			GameUtil.brick(world, 320, 375, 60, 30, unbreakableBrickUserData);
			GameUtil.brick(world, 305, 345, 90, 30, breakableBrickUserData);
			GameUtil.brick(world, 320, 300, 120, 60, unbreakableBrickUserData);
//			GameUtil.brick(world, 320, 255, 240, 30);
//			GameUtil.brick(world, 215, 210, 30, 60);
			
			idol(320, 242);
			GameUtil.ground(world);
			
			addEventListener(Event.ENTER_FRAME, updateWorld);
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		private function onAddToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			stage.addEventListener(MouseEvent.CLICK, destroyBrick);
		}
		
		private function updateWorld(e:Event):void
		{
			world.Step(GameConstants.TIME_STEP, GameConstants.VELOCITY_ITERATIONS, GameConstants.POSITION_ITERATIONS);
			world.ClearForces();
			if (!gameOver) 
			{
				for (var body:b2Body = world.GetBodyList(); body; body = body.GetNext())
				{
					if (body.GetUserData() && (body.GetUserData() as UserData).name == "idol")
					{
						var position:b2Vec2 = body.GetPosition();
						var xPos:Number = Math.round(UnitUtil.metersToPixels(position.x));
						textMon.text = xPos.toString();
						textMon.appendText(",");
						var yPos:Number = Math.round(UnitUtil.metersToPixels(position.y));
						textMon.appendText(yPos.toString());
						textMon.appendText("\nangle: ");
						var angle:Number = Math.round(UnitUtil.radToDeg(body.GetAngle()));
						textMon.appendText(angle.toString());
						textMon.appendText("\nVelocity: ");
						var velocity:b2Vec2 = body.GetLinearVelocity();
						var xVel:Number = Math.round(UnitUtil.metersToPixels(velocity.x));
						textMon.appendText(xVel.toString());
						textMon.appendText(",");
						var yVel:Number = Math.round(UnitUtil.metersToPixels(velocity.y));
						textMon.appendText(yVel.toString());
						for (var c:b2ContactEdge = body.GetContactList(); c; c = c.next)
						{
							var contact:b2Contact = c.contact;
							var fixtureA:b2Fixture = contact.GetFixtureA();
							var fixtureB:b2Fixture = contact.GetFixtureB();
							var bodyA:b2Body = fixtureA.GetBody();
							var bodyB:b2Body = fixtureB.GetBody();
							var userDataA:UserData = bodyA.GetUserData();
							var userDataB:UserData = bodyB.GetUserData();
							if (userDataA.name == GameConstants.GROUND && userDataB.name == "idol")
							{
								levelFailed();
							}
							if (userDataA.name == "idol" && userDataB.name == GameConstants.GROUND)
							{
								levelFailed();
							}
//							if (userDataA.name == GameConstants.GROUND || userDataB.name == GameConstants.GROUND)
//							{
//								levelFailed();
//							}
						}
					}
				}
			}
			
			world.DrawDebugData();
		}

		private function destroyBrick(e:MouseEvent):void
		{
			world.QueryPoint(queryCallback, GameUtil.mouseToWorld(mouseX, mouseY));
		}

		private function queryCallback(fixture:b2Fixture):Boolean
		{
			var touchedBody:b2Body = fixture.GetBody();
			if(touchedBody.GetUserData() is UserData && (touchedBody.GetUserData() as UserData).breakable)
			{
				world.DestroyBody(touchedBody);
			}
			return false;
		}

		private function levelFailed():void
		{
			textMon.text = "Oh no, poor idol!!!";
			stage.removeEventListener(MouseEvent.CLICK, destroyBrick);
			gameOver = true;
		}
		
		private function idol(pX:Number, pY:Number):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(UnitUtil.pixelsToMeters(pX), UnitUtil.pixelsToMeters(pY));
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData = new UserData(false, "idol");
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(UnitUtil.pixelsToMeters(5), UnitUtil.pixelsToMeters(20));
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = 1;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			var theIdol:b2Body = world.CreateBody(bodyDef);
			theIdol.CreateFixture(fixtureDef);
			var bW:Number = UnitUtil.pixelsToMeters(5);
			var bH:Number = UnitUtil.pixelsToMeters(20);
			var boxPos:b2Vec2 = new b2Vec2(0, UnitUtil.pixelsToMeters(10));
			var boxAngle:Number = -Math.PI / 4;
			polygonShape.SetAsOrientedBox(bW, bH, boxPos, boxAngle);
			fixtureDef.shape = polygonShape;
			theIdol.CreateFixture(fixtureDef);
			boxAngle = Math.PI / 4;
			polygonShape.SetAsOrientedBox(bW, bH, boxPos, boxAngle);
			fixtureDef.shape = polygonShape;
			theIdol.CreateFixture(fixtureDef);
			var vertices:Vector.<b2Vec2> = new Vector.<b2Vec2>();
			vertices.push(new b2Vec2(UnitUtil.pixelsToMeters(-15), UnitUtil.pixelsToMeters(-25)));
			vertices.push(new b2Vec2(0, UnitUtil.pixelsToMeters(-40)));
			vertices.push(new b2Vec2(UnitUtil.pixelsToMeters(15), UnitUtil.pixelsToMeters(-25)));
			vertices.push(new b2Vec2(0, UnitUtil.pixelsToMeters(-10)));
			polygonShape.SetAsVector(vertices, vertices.length);
			fixtureDef.shape = polygonShape;
			theIdol.CreateFixture(fixtureDef);
		}
	}
}
package me.guoyao.support
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Contacts.b2Contact;

	public class CustomContact extends b2ContactListener
	{
		public function CustomContact()
		{
			super();
		}

		override public function BeginContact(contact:b2Contact):void
		{
			trace("a collision started");
			var fixtureA:b2Fixture = contact.GetFixtureA();
			var fixtureB:b2Fixture = contact.GetFixtureB();
			var bodyA:b2Body = fixtureA.GetBody();
			var bodyB:b2Body = fixtureB.GetBody();
			trace("first body: " + bodyA.GetUserData());
			trace("second body: " + bodyB.GetUserData());
			trace("---------------------------");
		}

		override public function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void
		{
			if (contact.GetManifold().m_pointCount > 0)
			{
				trace("a collision has been pre solved");
				var fixtureA:b2Fixture = contact.GetFixtureA();
				var fixtureB:b2Fixture = contact.GetFixtureB();
				var bodyA:b2Body = fixtureA.GetBody();
				var bodyB:b2Body = fixtureB.GetBody();
				trace("first body: " + bodyA.GetUserData());
				trace("second body: " + bodyB.GetUserData());
				trace("---------------------------");
			}
		}
		
		override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void
		{
			trace("a collision has been post solved");
			var fixtureA:b2Fixture = contact.GetFixtureA();
			var fixtureB:b2Fixture = contact.GetFixtureB();
			var bodyA:b2Body = fixtureA.GetBody();
			var bodyB:b2Body = fixtureB.GetBody();
			trace("first body: " + bodyA.GetUserData());
			trace("second body: " + bodyB.GetUserData());
			trace("impulse: " + impulse.normalImpulses[0]);
			trace("---------------------------");
		}

		override public function EndContact(contact:b2Contact):void
		{
			trace("a collision ended");
			var fixtureA:b2Fixture = contact.GetFixtureA();
			var fixtureB:b2Fixture = contact.GetFixtureB();
			var bodyA:b2Body = fixtureA.GetBody();
			var bodyB:b2Body = fixtureB.GetBody();
			trace("first body: " + bodyA.GetUserData());
			trace("second body: " + bodyB.GetUserData());
			trace("---------------------------");
		}
	}
}

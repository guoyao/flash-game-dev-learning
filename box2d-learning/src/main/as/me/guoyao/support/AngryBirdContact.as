package me.guoyao.support
{
	import Box2D.Collision.b2Manifold;
	import Box2D.Dynamics.b2ContactImpulse;
	import Box2D.Dynamics.b2ContactListener;
	import Box2D.Dynamics.b2Fixture;
	import Box2D.Dynamics.Contacts.b2Contact;

	public class AngryBirdContact extends b2ContactListener
	{
		public function AngryBirdContact()
		{
			super();
		}

		private const KILLBRICK:Number = 25;
		
		private const KILLPIG:Number = 5;

		override public function PreSolve(contact:b2Contact, oldManifold:b2Manifold):void
		{
			var fixtureA:b2Fixture = contact.GetFixtureA();
			var fixtureB:b2Fixture = contact.GetFixtureB();
			var dataA:UserData = fixtureA.GetBody().GetUserData();
			var dataB:UserData = fixtureB.GetBody().GetUserData();
			if(dataA && dataB)
			{
				if (dataA.name == "cart" && dataB.name == "projectile")
				{
					contact.SetEnabled(false);
				}
				if (dataB.name == "cart" && dataA.name == "projectile")
				{
					contact.SetEnabled(false);
				}
			}
		}

		override public function PostSolve(contact:b2Contact, impulse:b2ContactImpulse):void
		{
			var fixtureA:b2Fixture = contact.GetFixtureA();
			var fixtureB:b2Fixture = contact.GetFixtureB();
			var dataA:UserData = fixtureA.GetBody().GetUserData();
			var dataB:UserData = fixtureB.GetBody().GetUserData();
			var force:Number = impulse.normalImpulses[0];
			if(dataA)
			{
				switch (dataA.name)
				{
					case "pig":
						if (force > KILLPIG)
						{
							dataA.breakable = true;
//							fixtureA.GetBody().SetUserData("remove");
						}
						break;
					case "brick":
						if (force > KILLBRICK)
						{
							dataA.breakable = true;
//							fixtureA.GetBody().SetUserData("remove");
						}
						break;
				}
			}
			if(dataB)
			{
				switch (dataB.name)
				{
					case "pig":
						if (force > KILLPIG)
						{
							dataB.breakable = true;
//							fixtureB.GetBody().SetUserData("remove");
						}
						break;
					case "brick":
						if (force > KILLBRICK)
						{
							dataB.breakable = true;
//							fixtureB.GetBody().SetUserData("remove");
						}
						break;
				}
			}
		}
	}
}

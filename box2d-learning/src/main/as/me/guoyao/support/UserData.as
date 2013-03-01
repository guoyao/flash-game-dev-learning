package me.guoyao.support
{
	public class UserData
	{
		public function UserData(breakable:Boolean = false, name:String = null, type:String = null)
		{
			this.breakable = breakable;
			this.name = name;
			this.type = type;
		}
		
		public var breakable:Boolean;
		
		public var name:String;

		public var type:String;

		public function toString():String
		{
			return type ? "[Name: " + name + ", Type: " + type + "]" : name;
		}
	}
}
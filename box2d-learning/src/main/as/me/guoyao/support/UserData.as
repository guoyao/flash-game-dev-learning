package me.guoyao.support
{
	public class UserData
	{
		public function UserData(breakable:Boolean = true)
		{
			this._breakable = breakable;
		}
		
		private var _breakable:Boolean;
		
		public function get breakable():Boolean
		{
			return _breakable;
		}
	}
}
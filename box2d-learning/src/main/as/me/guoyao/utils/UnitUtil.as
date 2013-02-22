package me.guoyao.utils
{
	import me.guoyao.support.GameConstants;

	public class UnitUtil
	{
		public static function pixelsToMeters(pixels:Number):Number
		{
			return pixels / GameConstants.WORLD_SCALE;
		}
	}
}
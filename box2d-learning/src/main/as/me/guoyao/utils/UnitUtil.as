package me.guoyao.utils
{
	import me.guoyao.support.GameConstants;

	public class UnitUtil
	{
		public static function pixelsToMeters(pixels:Number):Number
		{
			return pixels / GameConstants.WORLD_SCALE;
		}
		
		public static function metersToPixels(meters:Number):Number
		{
			return meters * GameConstants.WORLD_SCALE;
		}
		
		public static function radToDeg(value:Number):Number
		{
			return value * 180 / Math.PI;
		}
		
		public static function degToRad(value:Number):Number
		{
			return value * Math.PI / 180;
		}
	}
}
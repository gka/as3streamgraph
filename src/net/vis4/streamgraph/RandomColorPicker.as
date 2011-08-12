package net.vis4.streamgraph 
{
	import math.Random;
	import net.vis4.color.Color;
	import net.vis4.streamgraph.Layer;

	/**
	 * RandomColorPicker
	 * Chooses random colors within an acceptable HSB color spectrum
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public class RandomColorPicker implements ColorPicker 
	{

		public function RandomColorPicker(seed:int = 2) 
		{
			Random.seed = 2;
		}
		
		public function getName():String 
		{
			return "Random Colors";
		}
		
		public function colorize(layers:Vector.<Layer>):void 
		{
			for (var i:int = 0; i < layers.length; i++) {
				layers[i].rgb = Color.fromHSV(
					Random.float(0.6, 0.65) * 360, 
					Random.float(0.2, 0.25), 
					Random.float(0.4, 0.95)
				);
			}
		}
		
		
	}

}
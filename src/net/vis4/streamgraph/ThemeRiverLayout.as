package net.vis4.streamgraph 
{
	import net.vis4.streamgraph.Layer;
	/**
	 * ThemeRiverLayout
	 * Layout used by the authors of the ThemeRiver paper
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public class ThemeRiverLayout extends LayerLayout 
	{
		
		override public function getName():String 
		{
			return "ThemeRiver";
		}
		
		override public function layout(layers:Vector.<Layer>):void 
		{
			var n:int = layers[0].size.length,
				m:int = layers.length,
				baseline:Vector.<Number> = new Vector.<Number>(n);
				
			// ThemeRiver is perfectly symmetrical
			// the baseline is 1/2 of the total height at any point
			for (var i:int = 0; i < n; i++) {
				baseline[i] = 0;
				for (var j:int = 0; j < m; j++) {
					baseline[i] += layers[j].size[i];
				}
				baseline[i] *= 0.5;
			}
			
			// Put layers on top of the baseline.
			stackOnBaseline(layers, baseline);
		}
		
	}

}
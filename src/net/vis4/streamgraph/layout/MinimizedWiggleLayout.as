package net.vis4.streamgraph.layout 
{
	import net.vis4.streamgraph.Layer;

	/**
	 * MinimizedWiggleLayout
	 * Minimizes the sum of squares of the layer slopes at each value
	 *
	 * We present this as a reasonable alternative to the Stream Graph for
	 * real-time use. While it has some drawbacks compared to StreamLayout, it is
	 * much faster to execute and is reasonable for real-time applications.
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public class MinimizedWiggleLayout extends LayerLayout 
	{
		
		override public function getName():String 
		{
			return "Minimized Wiggle Layout";
		}
		
		override public function layout(layers:Vector.<Layer>):void 
		{
			var n:int = layers[0].size.length,
				m:int = layers.length,
				baseline:Vector.<Number> = new Vector.<Number>(n);
				
			// Set shape of baseline values.
			for (var i:int = 0; i < n; i++) {
				for (var j:int = 0; j < m; j++) {
					baseline[i] += (m - j - 0.5) * layers[j].size[i];
				}
				baseline[i] /= m;
			}
			
			// Put layers on top of the baseline.
			stackOnBaseline(layers, baseline);
		}
		
	}

}
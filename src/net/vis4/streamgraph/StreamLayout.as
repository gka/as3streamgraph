package net.vis4.streamgraph 
{
	import net.vis4.streamgraph.Layer;
	/**
	 * StreamLayout
	 * The layout used in the Streamgraph stacked graph
	 *
	 * Because this layout is using numeric integration, it is likely insufficient
	 * for real-time display, especially for larger data sets.
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public class StreamLayout extends LayerLayout 
	{

		override public function getName():String 
		{
			return "Original Streamgraph Layout";
		}
		
		override public function layout(layers:Vector.<Layer>):void 
		{
			var n:int = layers[0].size.length,
				m:int = layers.length,
				baseline:Vector.<Number> = new Vector.<Number>(n),
				center:Vector.<Number> = new Vector.<Number>(n),
				totalSize:Number,
				moveUp:Number,
				increase:Number,
				belowSize:Number;
				
			// Set shape of baseline values.
			for (var i:int = 0; i < n; i++) {
				// the 'center' is a rolling point. It is initialized as the previous
				// iteration's center value
				center[i] = i == 0 ? 0 : center[i-1];
				
				// find the total size of all layers at this point
				totalSize = 0;
				for (var j:int = 0; j < m; j++) {
					totalSize += layers[j].size[i];
				}
				
				// account for the change of every layer to offset the center point
				for (j = 0; j < m; j++) {
					if (i == 0) {
						increase = layers[j].size[i];
						moveUp = 0.5;
					} else {
						belowSize = 0.5 * layers[j].size[i];
						for (var k:int = j + 1; k < m; k++) {
							belowSize += layers[k].size[i];
						}			
						increase = layers[j].size[i] - layers[j].size[i - 1];
						moveUp = totalSize == 0 ? 0 : (belowSize / totalSize);
					}
					center[i] += (moveUp - 0.5) * increase;
				}

				// set baseline to the bottom edge according to the center line
				baseline[i] = center[i] + 0.5 * totalSize;				
			}
			
			// Put layers on top of the baseline.
			stackOnBaseline(layers, baseline);
		}
		
	}

}
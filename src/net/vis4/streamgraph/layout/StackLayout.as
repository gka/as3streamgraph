package net.vis4.streamgraph.layout 
{
	import net.vis4.streamgraph.Layer;
	
	/**
	 * StackLayout
	 * Standard stacked graph layout, with a straight baseline
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public class StackLayout extends LayerLayout 
	{
		
		override public function getName():String 
		{
			return "Stacked Layout";
		}
		
		override public function layout(layers:Vector.<Layer>):void 
		{
			var n:int = layers[0].size.length;
			
			// lay out layers, top to bottom.
			var baseline:Vector.<Number> = new Vector.<Number>(n);
			
			// Put layers on top of the baseline.
			stackOnBaseline(layers, baseline);
		}
		
	}

}
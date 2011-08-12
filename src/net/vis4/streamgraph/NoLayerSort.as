package net.vis4.streamgraph 
{
	import net.vis4.streamgraph.Layer;
	
	/**
	 * NoLayerSort
	 * Does no sorting. Identity function.
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public class NoLayerSort extends LayerSort
	{
		
		override public function getName():String 
		{
			return "No Sorting";
		}
		
		override public function sort(layers:Vector.<Layer>):Vector.<Layer> 
		{
			return layers;
		}
	}

}
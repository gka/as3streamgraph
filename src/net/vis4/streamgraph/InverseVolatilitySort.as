package net.vis4.streamgraph 
{
	import net.vis4.streamgraph.Layer;

	/**
	 * InverseVolatilitySort
	 * Sorts an array of layers by their volatility, placing the most volatile
	 * layers along the insides of the graph, illustrating how disruptive this
	 * volatility can be to a stacked graph.
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public class InverseVolatilitySort extends VolatilitySort 
	{
		
		override public function getName():String 
		{
			return "Inverse Volatility Sorting, Evenly Weighted";
		}
		
		override protected function volatilityComparator(a:Layer, b:Layer):int 
		{
			return super.volatilityComparator(a, b) * -1;
		}
		
	}

}
package net.vis4.streamgraph 
{
	
	/**
	 * ColorPicker
	 * Interface for new coloring algorithms.
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public interface ColorPicker 
	{
		function colorize(layers:Vector.<Layer>):void;
		
		function getName():String;
	}
	
}
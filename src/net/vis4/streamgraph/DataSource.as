package net.vis4.streamgraph 
{
	/**
	 * DataSource
	 * Interface for creating a data source
	 *
	 * @author Lee Byron
	 * @author Martin Wattenberg
	 */
	public interface DataSource 
	{
		
		function make(numLayers:int, sizeArrayLength:int):Vector.<Layer>;
		
	}

}
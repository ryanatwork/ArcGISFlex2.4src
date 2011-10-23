////////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2011 Esri
//
// All rights reserved under the copyright laws of the United States.
// You may freely redistribute and use this software, with or
// without modification, provided you include the original copyright
// and use restrictions.  See use restrictions in the file:
// <install location>/License.txt
//
////////////////////////////////////////////////////////////////////////////////
package widgets.Geoprocessing.supportClasses
{

import com.esri.ags.Map;

import mx.collections.ArrayCollection;

public class LayerOrderer
{
    private var _map:Map;

    public function get map():Map
    {
        return _map;
    }

    public function set map(value:Map):void
    {
        _map = value;
    }

    private var _layerOrder:Array;

    public function get layerOrder():Array
    {
        return _layerOrder;
    }

    public function set layerOrder(value:Array):void
    {
        _layerOrder = value;
    }

    //NOTE: reorders layers from topmost layer
    public function orderLayers():void
    {
        if (layerOrder && map)
        {
            var totalLayersToOrder:int = layerOrder.length;
            var totalLayersOnMap:int = (map.layers as ArrayCollection).length - 1;
            for (var i:int = 0; i < totalLayersToOrder; i++)
            {
                map.reorderLayer(layerOrder[i], totalLayersOnMap - i);
            }
        }
    }
}

}

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
package widgets.Geoprocessing.parameters
{

import com.esri.ags.SpatialReference;
import com.esri.ags.layers.GraphicsLayer;
import com.esri.ags.renderers.Renderer;
import com.esri.ags.symbols.Symbol;
import com.esri.ags.webmap.supportClasses.PopUpInfo;

import mx.core.ClassFactory;

public interface IGPFeatureParameter extends IGPParameter
{
    function get geometryType():String;
    function get popUpInfo():PopUpInfo;
    function get layer():GraphicsLayer;
    function get renderer():Renderer;
    function get defaultSymbol():Symbol;
    function get layerName():String;
    function get popUpRenderer():ClassFactory;
    function get spatialReference():SpatialReference;

    function set geometryType(value:String):void;
    function set popUpInfo(value:PopUpInfo):void;
    function set renderer(value:Renderer):void;
    function set layerName(value:String):void;
    function set spatialReference(value:SpatialReference):void;
}

}

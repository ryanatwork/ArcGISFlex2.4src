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

import com.esri.ags.FeatureSet;
import com.esri.ags.SpatialReference;
import com.esri.ags.layers.GraphicsLayer;
import com.esri.ags.renderers.ClassBreaksRenderer;
import com.esri.ags.renderers.Renderer;
import com.esri.ags.renderers.SimpleRenderer;
import com.esri.ags.renderers.UniqueValueRenderer;
import com.esri.ags.renderers.supportClasses.ClassBreakInfo;
import com.esri.ags.renderers.supportClasses.UniqueValueInfo;
import com.esri.ags.symbols.SimpleFillSymbol;
import com.esri.ags.symbols.SimpleLineSymbol;
import com.esri.ags.symbols.Symbol;
import com.esri.ags.webmap.PopUpRenderer;
import com.esri.ags.webmap.supportClasses.PopUpFieldInfo;
import com.esri.ags.webmap.supportClasses.PopUpInfo;

import mx.collections.ArrayCollection;
import mx.core.ClassFactory;

public class FeatureLayerParameter extends BaseParameter implements IGPFeatureParameter
{
    //--------------------------------------------------------------------------
    //
    //  Constants
    //
    //--------------------------------------------------------------------------

    public static const POINT:String = "point";
    public static const POLYGON:String = "polygon";
    public static const POLYLINE:String = "polyline";

    public static const SIMPLE_MARKER:String = "simplemarker";
    public static const SIMPLE_FILL:String = "simplefill";
    public static const SIMPLE_LINE:String = "simpleline";
    public static const PICTURE_MARKER:String = "picturemarker";

    public static const SIMPLE_RENDERER:String = "simple";
    public static const CLASS_BREAKS_RENDERER:String = "classbreaks";
    public static const UNIQUE_VALUE_RENDERER:String = "uniquevalue";

    //--------------------------------------------------------------------------
    //
    //  Constructor
    //
    //--------------------------------------------------------------------------

    public function FeatureLayerParameter()
    {
        _layer = new GraphicsLayer();
    }

    //--------------------------------------------------------------------------
    //
    //  Properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  geometryType
    //----------------------------------

    private var _geometryType:String;

    public function get geometryType():String
    {
        return _geometryType;
    }

    public function set geometryType(value:String):void
    {
        _geometryType = value;
    }

    //----------------------------------
    //  popUpInfo
    //----------------------------------

    private var _popUpInfo:PopUpInfo;

    public function get popUpInfo():PopUpInfo
    {
        return _popUpInfo;
    }

    public function set popUpInfo(value:PopUpInfo):void
    {
        _popUpInfo = value;
    }

    //----------------------------------
    //  layer
    //----------------------------------

    private var _layer:GraphicsLayer;

    public function get layer():GraphicsLayer
    {
        return _layer;
    }

    //----------------------------------
    //  renderer
    //----------------------------------

    private var _renderer:Renderer;

    public function get renderer():Renderer
    {
        return _renderer;
    }

    public function set renderer(value:Renderer):void
    {
        _renderer = value;
        _layer.renderer = value;
    }

    //----------------------------------
    //  layerName
    //----------------------------------

    private var _layerName:String;

    public function get layerName():String
    {
        return _layerName;
    }

    public function set layerName(value:String):void
    {
        _layerName = value;
        _layer.name = value;
    }

    //----------------------------------
    //  popUpRenderer
    //----------------------------------

    public function get popUpRenderer():ClassFactory
    {
        var popUpRenderer:ClassFactory;

        if (_popUpInfo)
        {
            popUpRenderer = new ClassFactory(PopUpRenderer);
            var popUpInfo:PopUpInfo = _popUpInfo;
            popUpRenderer.properties = { popUpInfo: popUpInfo };
        }

        return popUpRenderer;
    }

    //----------------------------------
    //  spatialReference
    //----------------------------------

    private var _spatialReference:SpatialReference;

    public function get spatialReference():SpatialReference
    {
        return _spatialReference;
    }

    public function set spatialReference(value:SpatialReference):void
    {
        _spatialReference = value;
    }

    //----------------------------------
    //  defaultSymbol
    //----------------------------------

    public function get defaultSymbol():Symbol
    {
        var symbol:Symbol;

        if (_renderer is SimpleRenderer)
        {
            symbol = (_renderer as SimpleRenderer).symbol;
        }
        else if (_renderer is ClassBreaksRenderer)
        {
            symbol = (_renderer as ClassBreaksRenderer).defaultSymbol;
        }
        else if (_renderer is UniqueValueRenderer)
        {
            symbol = (_renderer as UniqueValueRenderer).defaultSymbol;
        }

        return symbol;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden properties
    //
    //--------------------------------------------------------------------------

    //----------------------------------
    //  type
    //----------------------------------

    override public function get type():String
    {
        return GPParameterTypes.FEATURE_RECORD_SET_LAYER;
    }

    //----------------------------------
    //  name
    //----------------------------------

    override public function set name(value:String):void
    {
        super.name = value;
        _layer.id = value;
    }

    //--------------------------------------------------------------------------
    //
    //  Overridden methods
    //
    //--------------------------------------------------------------------------

    override public function hasValidValue():Boolean
    {
        return (_layer.graphicProvider as ArrayCollection).length > 0;
    }

    public override function getRequestObjectValue():Object
    {
        return new FeatureSet((_layer.graphicProvider as ArrayCollection).source);
    }
}

}

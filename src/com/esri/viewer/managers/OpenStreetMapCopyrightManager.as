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
package com.esri.viewer.managers
{

import com.esri.ags.Map;
import com.esri.ags.events.LayerEvent;
import com.esri.ags.events.MapEvent;
import com.esri.ags.layers.Layer;
import com.esri.ags.layers.OpenStreetMapLayer;

import flash.text.StyleSheet;

import mx.controls.Label;
import mx.events.FlexEvent;

import spark.filters.GlowFilter;

public class OpenStreetMapCopyrightManager
{
    private var map:Map;

    private var _copyright:Label;

    private function get copyright():Label
    {
        if (!_copyright)
        {
            var copyrightText:Label = new Label();
            copyrightText.setStyle("color", "0x000000");
            copyrightText.setStyle("fontFamily", "Verdana");
            copyrightText.setStyle("fontSize", "9");
            copyrightText.setStyle("fontWeight", "bold");
            copyrightText.filters = [ new GlowFilter(0xFFFFFF, 1, 3, 3, 7)]
            copyrightText.horizontalCenter = 0;
            copyrightText.bottom = 3;
            copyrightText.selectable = true; //needed to enable links

            var styleSheet:StyleSheet = new StyleSheet();
            styleSheet.setStyle("a:hover", { color: "#0000FF" });
            copyrightText.styleSheet = styleSheet;

            var copyrightHTMLText:String = '(c) <a href="http://www.openstreetmap.org/" target="_blank">OpenStreetMap</a> contributors, '
                + '<a href="http://creativecommons.org/licenses/by-sa/2.0/" target="_blank">CC-BY-SA</a>';
            copyrightText.htmlText = copyrightHTMLText;

            _copyright = copyrightText;
        }

        return _copyright;
    }

    public function OpenStreetMapCopyrightManager(map:Map)
    {
        this.map = map;

        map.addEventListener(MapEvent.LAYER_ADD, map_layerAddHandler, false, 0, true);
        map.addEventListener(MapEvent.LAYER_REMOVE, map_layerRemoveHandler, false, 0, true);
    }

    private function copyrightRequired():Boolean
    {
        var isCopyrightRequired:Boolean = false;
        var osmLayer:OpenStreetMapLayer;
        for each (var layer:Layer in map.layers)
        {
            osmLayer = layer as OpenStreetMapLayer;
            if (osmLayer)
            {
                if (osmLayer.visible && osmLayer.isInScaleRange)
                {
                    isCopyrightRequired = true;
                    break;
                }
            }
        }

        return isCopyrightRequired;
    }

    private function toggleCopyrightVisibility():void
    {
        if (copyrightRequired())
        {
            addCopyright()
        }
        else
        {
            removeCopyright();
        }
    }

    private function removeCopyright():void
    {
        if (map.staticLayer.contains(copyright))
        {
            map.staticLayer.removeElement(copyright);
        }
    }

    private function addCopyright():void
    {
        if (!map.staticLayer.contains(copyright))
        {
            map.staticLayer.addElement(copyright);
        }
    }

    private function osmLayer_loadHandler(event:LayerEvent):void
    {
        event.layer.removeEventListener(LayerEvent.LOAD, osmLayer_loadHandler);
        toggleCopyrightVisibility();
    }

    private function map_layerAddHandler(event:MapEvent):void
    {
        var osmLayer:OpenStreetMapLayer = event.layer as OpenStreetMapLayer;
        if (osmLayer)
        {
            if (osmLayer.loaded)
            {
                toggleCopyrightVisibility();
            }
            else
            {
                osmLayer.addEventListener(LayerEvent.LOAD, osmLayer_loadHandler, false, 0, true);
            }
            osmLayer.addEventListener(FlexEvent.SHOW, osmLayer_showHandler, false, 0, true);
            osmLayer.addEventListener(FlexEvent.HIDE, osmLayer_hideHandler, false, 0, true);
            osmLayer.addEventListener(LayerEvent.IS_IN_SCALE_RANGE_CHANGE, osmLayer_isInScaleRangeChangeHandler, false, 0, true);
        }
    }

    private function map_layerRemoveHandler(event:MapEvent):void
    {
        var osmLayer:OpenStreetMapLayer = event.layer as OpenStreetMapLayer;
        if (osmLayer)
        {
            osmLayer.removeEventListener(FlexEvent.SHOW, osmLayer_showHandler);
            osmLayer.removeEventListener(FlexEvent.HIDE, osmLayer_hideHandler);
            osmLayer.removeEventListener(LayerEvent.IS_IN_SCALE_RANGE_CHANGE, osmLayer_isInScaleRangeChangeHandler);
            toggleCopyrightVisibility();
        }
    }

    private function osmLayer_showHandler(event:FlexEvent):void
    {
        toggleCopyrightVisibility();
    }

    private function osmLayer_hideHandler(event:FlexEvent):void
    {
        toggleCopyrightVisibility();
    }

    private function osmLayer_isInScaleRangeChangeHandler(event:LayerEvent):void
    {
        toggleCopyrightVisibility();
    }
}

}

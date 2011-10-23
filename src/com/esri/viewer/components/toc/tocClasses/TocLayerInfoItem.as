////////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2010-2011 Esri
//
// All rights reserved under the copyright laws of the United States.
// You may freely redistribute and use this software, with or
// without modification, provided you include the original copyright
// and use restrictions.  See use restrictions in the file:
// <install location>/License.txt
//
////////////////////////////////////////////////////////////////////////////////
package com.esri.viewer.components.toc.tocClasses
{

import com.esri.ags.layers.supportClasses.LayerInfo;

/**
 * A TOC item representing a member layer of an ArcGIS or ArcIMS map service.
 * This includes group layers that contain other member layers.
 */
public class TocLayerInfoItem extends TocItem
{
    public function TocLayerInfoItem(parentItem:TocItem, layerInfo:LayerInfo, isVisible:Boolean)
    {
        super(parentItem);

        _layerInfo = layerInfo;
        label = layerInfo.name;

        setVisible(isVisible, false);
    }

    //--------------------------------------------------------------------------
    //  Property:  layerInfo
    //--------------------------------------------------------------------------

    private var _layerInfo:LayerInfo;

    /**
     * The map layer info that backs this TOC item.
     */
    public function get layerInfo():LayerInfo
    {
        return _layerInfo;
    }

    //--------------------------------------------------------------------------
    //
    //  Methods
    //
    //--------------------------------------------------------------------------

    /**
     * @private
     */
    override internal function setVisible(value:Boolean, layerRefresh:Boolean = true):void
    {
        // Set the visible state of this item, but defer the layer refresh
        super.setVisible(value, false);

        // Allow the layer refresh now that all changes have been made
        if (layerRefresh)
        {
            refreshLayer();
        }
    }
}

}

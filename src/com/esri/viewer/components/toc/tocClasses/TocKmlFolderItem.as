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
package com.esri.viewer.components.toc.tocClasses
{

import com.esri.ags.layers.KMLLayer;
import com.esri.ags.layers.supportClasses.KMLFolder;

/**
 * A TOC item representing folder of a KML Layer.
 */
public class TocKmlFolderItem extends TocItem
{
    public function TocKmlFolderItem(parentItem:TocItem, folder:KMLFolder, layer:KMLLayer)
    {
        super(parentItem);

        _folder = folder;
        _layer = layer;
        label = folder.name;

        setVisible(folder.visible, false);
    }

    //--------------------------------------------------------------------------
    //  Property:  folder
    //--------------------------------------------------------------------------

    private var _folder:KMLFolder;

    /**
     * The KML Folder that represents this TOC item.
     */
    public function get folder():KMLFolder
    {
        return _folder;
    }

    //--------------------------------------------------------------------------
    //  Property:  layer
    //--------------------------------------------------------------------------

    private var _layer:KMLLayer;

    /**
     * The KML layer associated with this TOC item.
     */
    public function get layer():KMLLayer
    {
        return _layer;
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
        // Set the visible state of this item, but defer the folder refresh on the layer
        super.setVisible(value, false);

        if (layerRefresh)
        {
            if (layer.visible)
            {
                layer.setFolderVisibility(folder, value); // refresh the folder in the layer
            }
            else
            {
                layer.setFolderVisibility(folder, false);
            }
        }
    }
}

}

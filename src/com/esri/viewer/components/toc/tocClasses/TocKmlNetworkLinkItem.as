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
import com.esri.ags.layers.supportClasses.KMLFeatureInfo;
import com.esri.ags.layers.supportClasses.KMLFolder;

/**
 * A TOC item representing a NetworkLink within a KML Layer.
 */
public class TocKmlNetworkLinkItem extends TocItem
{
    public function TocKmlNetworkLinkItem(parentItem:TocItem, networkLink:KMLLayer, layer:KMLLayer)
    {
        super(parentItem);

        _networkLink = networkLink;
        _layer = layer;
        label = networkLink.name;

        setVisible(networkLink.visible, false);
    }

    //--------------------------------------------------------------------------
    //  Property:  folder
    //--------------------------------------------------------------------------

    private var _networkLink:KMLLayer;

    /**
     * The KML Folder that represents this TOC item.
     */
    public function get networkLink():KMLLayer
    {
        return _networkLink;
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
            networkLink.visible = value;
            if (value)
            {
                if (parent is TocKmlFolderItem)
                {
                    networkLink.visible = isNetworkLinkVisibileBasedOnParentFolder();
                }
            }
        }
    }

    private function isNetworkLinkVisibileBasedOnParentFolder():Boolean
    {
        var result:Boolean;

        // find the immediate parent folder
        var parentFolder:KMLFolder = TocKmlFolderItem(parent).folder;
        result = parentFolder.visible;
        if (parentFolder.visible)
        {
            var parents:Array = getParentFolders(parentFolder);
            if (parents.length > 0)
            {
                for (var p:int = 0; p < parents.length; )
                {
                    if (!KMLFolder(parents[p]).visible)
                    {
                        result = false;
                        break;
                    }
                    else
                    {
                        p++;
                    }
                }
            }
        }
        return result;
    }

    private function getParentFolders(folder:KMLFolder, arr:Array = null):Array
    {
        if (!arr)
        {
            arr = [];
        }

        // Returns the parent folders ids of the given folder
        var parentId:Number = folder.parentFolderId;

        if (parentId != -1)
        {
            var kmlFeatureInfo:KMLFeatureInfo = new KMLFeatureInfo;
            kmlFeatureInfo.type = KMLFeatureInfo.FOLDER;
            kmlFeatureInfo.id = parentId;

            var parentFolder:KMLFolder = layer.getFeature(kmlFeatureInfo) as KMLFolder;

            arr.push(parentFolder);
            return getParentFolders(parentFolder, arr);
        }
        return arr;
    }
}

}

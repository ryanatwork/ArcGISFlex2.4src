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
package com.esri.viewer.managers
{

import com.esri.viewer.utils.Hashtable;

import flash.events.EventDispatcher;

import mx.collections.ArrayCollection;
import com.esri.viewer.AppEvent;
import com.esri.viewer.ViewerContainer;

/**
 * Data manager will be storing the session data to support data reuse such as
 * widget chain.
 * A data manager UI (a special widget) will be developed to allow user edit the data.
 */
public class DataManager extends EventDispatcher
{
    private var dataTable:Hashtable;

    public function DataManager()
    {
        super();

        dataTable = new Hashtable();
        AppEvent.addListener(AppEvent.CONFIG_LOADED, configLoadedHandler);

        // This is a example to set up the listener to get the type of data the Data
        // Manager is interested in.
        AppEvent.addListener(AppEvent.DATA_FETCH_ALL, fetchAllData);
        AppEvent.addListener(AppEvent.DATA_PUBLISH, addData);
        AppEvent.addListener(AppEvent.DATA_FETCH, fetchData);
    }

    private function configLoadedHandler(event:AppEvent):void
    {
    }

    private function fetchAllData(event:AppEvent):void
    {
        AppEvent.dispatch(AppEvent.DATA_SENT, dataTable);
    }

    private function fetchData(event:AppEvent):void
    {
        var key:String = event.data.key as String;
        var data:Object =
            {
                key: key,
                collection: dataTable.find(key)
            };
        AppEvent.dispatch(AppEvent.DATA_SENT, data);
    }

    private function addData(event:AppEvent):void
    {
        var key:String = event.data.key;
        if (key)
        {
            var dataCollection:Object = event.data.collection;
            if (dataTable.containsKey(key))
            {
                dataTable.remove(key);
            }
            dataTable.add(key, dataCollection);

            var data:Object =
                {
                    key: key,
                    data: dataTable
                };
            AppEvent.dispatch(AppEvent.DATA_NEW_PUBLISHED, data);
        }
    }
}

}

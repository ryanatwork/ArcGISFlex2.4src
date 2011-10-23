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
package com.esri.viewer.utils
{

import com.esri.ags.tasks.BaseTask;

import flash.net.URLVariables;

import mx.rpc.AsyncToken;
import mx.rpc.IResponder;

/**
 * Sends a HTTP request to the url with any additional query parameters specified in the urlVariables.
 * The response is expected to be JSON that is decoded and passed back to the responder's result handler.
 */
public class GenericJSONTask extends BaseTask
{
    public function execute(urlVariables:URLVariables, responder:IResponder):AsyncToken
    {
        return sendURLVariables("", urlVariables, responder, handleDecodedObject);
    }

    private function handleDecodedObject(decodedObject:Object, asyncToken:AsyncToken):void
    {
        for each (var responder:IResponder in asyncToken.responders)
        {
            responder.result(decodedObject);
        }
    }
}

}

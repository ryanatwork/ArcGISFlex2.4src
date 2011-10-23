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

import flash.net.FileReference;
import flash.net.URLRequest;

public class FileDownloader
{
    private static const FILE_NAME_DEFAULT:String = "gpFile";

    private var _url:String;

    public function get url():String
    {
        return _url;
    }

    public function set url(value:String):void
    {
        _url = value;
    }

    private var _fileName:String;

    public function get fileName():String
    {
        return _fileName || FILE_NAME_DEFAULT;
    }

    public function set fileName(value:String):void
    {
        _fileName = value;
    }

    public function downloadFile():void
    {
        if (url)
        {
            var downloadURL:URLRequest = new URLRequest(url);
            var file:FileReference = new FileReference();
            var fileNameWithExtension:String = fileName + getFileExtension(url);
            file.download(downloadURL, fileNameWithExtension);
        }
    }

    private function getFileExtension(url:String):String
    {
        var fileExtension:String = "";
        var fileExtensionIndex:int = url.search(/.[\w]+$/g);
        if (fileExtensionIndex > 0)
        {
            fileExtension += url.substr(fileExtensionIndex, url.length);
        }

        return fileExtension;
    }
}

}

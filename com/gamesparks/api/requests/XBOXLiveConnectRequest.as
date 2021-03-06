﻿package com.gamesparks.api.requests
{
    import com.gamesparks.*;
    import com.gamesparks.api.responses.*;

    public class XBOXLiveConnectRequest extends GSRequest
    {

        public function XBOXLiveConnectRequest(param1:GS)
        {
            super(param1);
            data["@class"] = ".XBOXLiveConnectRequest";
            return;
        }// end function

        public function setTimeoutSeconds(param1:int = 10) : XBOXLiveConnectRequest
        {
            this.timeoutSeconds = param1;
            return this;
        }// end function

        override public function send(param1:Function) : String
        {
            var callback:* = param1;
            return super.send(function (param1:Object) : void
            {
                if (callback != null)
                {
                    callback(new AuthenticationResponse(param1));
                }
                return;
            }// end function
            );
        }// end function

        public function setScriptData(param1:Object) : XBOXLiveConnectRequest
        {
            data["scriptData"] = param1;
            return this;
        }// end function

        public function setDisplayName(param1:String) : XBOXLiveConnectRequest
        {
            this.data["displayName"] = param1;
            return this;
        }// end function

        public function setDoNotLinkToCurrentPlayer(param1:Boolean) : XBOXLiveConnectRequest
        {
            this.data["doNotLinkToCurrentPlayer"] = param1;
            return this;
        }// end function

        public function setErrorOnSwitch(param1:Boolean) : XBOXLiveConnectRequest
        {
            this.data["errorOnSwitch"] = param1;
            return this;
        }// end function

        public function setSegments(param1:Object) : XBOXLiveConnectRequest
        {
            this.data["segments"] = param1;
            return this;
        }// end function

        public function setStsTokenString(param1:String) : XBOXLiveConnectRequest
        {
            this.data["stsTokenString"] = param1;
            return this;
        }// end function

        public function setSwitchIfPossible(param1:Boolean) : XBOXLiveConnectRequest
        {
            this.data["switchIfPossible"] = param1;
            return this;
        }// end function

        public function setSyncDisplayName(param1:Boolean) : XBOXLiveConnectRequest
        {
            this.data["syncDisplayName"] = param1;
            return this;
        }// end function

    }
}

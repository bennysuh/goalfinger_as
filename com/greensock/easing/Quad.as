﻿package com.greensock.easing
{

    public class Quad extends Object
    {
        public static const power:uint = 1;

        public function Quad()
        {
            return;
        }// end function

        public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / param4;
            param1 = param1 / param4;
            return param3 * _loc_5 * param1 + param2;
        }// end function

        public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / param4;
            param1 = param1 / param4;
            return (-param3) * _loc_5 * (param1 - 2) + param2;
        }// end function

        public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            var _loc_5:* = param1 / (param4 * 0.5);
            param1 = param1 / (param4 * 0.5);
            if (_loc_5 < 1)
            {
                return param3 * 0.5 * param1 * param1 + param2;
            }
            param1 = (param1 - 1);
            return (-param3) * 0.5 * (param1 * (param1 - 2) - 1) + param2;
        }// end function

    }
}

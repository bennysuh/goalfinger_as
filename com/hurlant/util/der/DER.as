﻿package com.hurlant.util.der
{
    import flash.utils.*;

    public class DER extends Object
    {
        public static var indent:String = "";

        public function DER()
        {
            return;
        }// end function

        public static function parse(param1:ByteArray, param2 = null) : IAsn1Type
        {
            var _loc_3:* = 0;
            var _loc_5:* = 0;
            var _loc_6:* = null;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            var _loc_9:* = null;
            var _loc_10:* = null;
            var _loc_11:* = null;
            var _loc_12:* = null;
            var _loc_13:* = null;
            var _loc_14:* = null;
            var _loc_15:* = null;
            var _loc_16:* = false;
            var _loc_17:* = false;
            var _loc_18:* = null;
            var _loc_19:* = undefined;
            var _loc_20:* = null;
            var _loc_21:* = 0;
            var _loc_22:* = null;
            _loc_3 = param1.readUnsignedByte();
            var _loc_4:* = (_loc_3 & 32) != 0;
            _loc_3 = _loc_3 & 31;
            _loc_5 = param1.readUnsignedByte();
            if (_loc_5 >= 128)
            {
                _loc_7 = _loc_5 & 127;
                _loc_5 = 0;
                while (_loc_7 > 0)
                {
                    
                    _loc_5 = _loc_5 << 8 | param1.readUnsignedByte();
                    _loc_7 = _loc_7 - 1;
                }
            }
            switch(_loc_3)
            {
                case 0:
                case 16:
                {
                    _loc_8 = param1.position;
                    _loc_9 = new Sequence(_loc_3, _loc_5);
                    _loc_10 = param2 as Array;
                    if (_loc_10 != null)
                    {
                        _loc_10 = _loc_10.concat();
                    }
                    while (param1.position < _loc_8 + _loc_5)
                    {
                        
                        _loc_15 = null;
                        if (_loc_10 != null)
                        {
                            _loc_15 = _loc_10.shift();
                        }
                        if (_loc_15 != null)
                        {
                            while (_loc_15 && _loc_15.optional)
                            {
                                
                                _loc_16 = _loc_15.value is Array;
                                _loc_17 = isConstructedType(param1);
                                if (_loc_16 != _loc_17)
                                {
                                    _loc_9.push(_loc_15.defaultValue);
                                    _loc_9[_loc_15.name] = _loc_15.defaultValue;
                                    _loc_15 = _loc_10.shift();
                                    continue;
                                }
                                break;
                            }
                        }
                        if (_loc_15 != null)
                        {
                            _loc_18 = _loc_15.name;
                            _loc_19 = _loc_15.value;
                            if (_loc_15.extract)
                            {
                                _loc_21 = getLengthOfNextElement(param1);
                                _loc_22 = new ByteArray();
                                _loc_22.writeBytes(param1, param1.position, _loc_21);
                                _loc_9[_loc_18 + "_bin"] = _loc_22;
                            }
                            _loc_20 = DER.parse(param1, _loc_19);
                            _loc_9.push(_loc_20);
                            _loc_9[_loc_18] = _loc_20;
                            continue;
                        }
                        _loc_9.push(DER.parse(param1));
                    }
                    return _loc_9;
                }
                case 17:
                {
                    _loc_8 = param1.position;
                    _loc_11 = new Set(_loc_3, _loc_5);
                    while (param1.position < _loc_8 + _loc_5)
                    {
                        
                        _loc_11.push(DER.parse(param1));
                    }
                    return _loc_11;
                }
                case 2:
                {
                    _loc_6 = new ByteArray();
                    param1.readBytes(_loc_6, 0, _loc_5);
                    _loc_6.position = 0;
                    return new Integer(_loc_3, _loc_5, _loc_6);
                }
                case 6:
                {
                    _loc_6 = new ByteArray();
                    param1.readBytes(_loc_6, 0, _loc_5);
                    _loc_6.position = 0;
                    return new ObjectIdentifier(_loc_3, _loc_5, _loc_6);
                }
                case 12:
                {
                    _loc_13 = new PrintableString(_loc_3, _loc_5);
                    _loc_13.setString(param1.readMultiByte(_loc_5, "utf-8"));
                    return _loc_13;
                }
                case 22:
                {
                    _loc_13 = new PrintableString(_loc_3, _loc_5);
                    _loc_13.setString(param1.readMultiByte(_loc_5, "x-IA5"));
                    return _loc_13;
                }
                case 3:
                default:
                {
                    if (param1[param1.position] == 0)
                    {
                        var _loc_23:* = param1;
                        var _loc_24:* = _loc_23.position + 1;
                        _loc_23.position = _loc_24;
                        _loc_5 = _loc_5 - 1;
                    }
                }
                case 5:
                {
                    _loc_12 = new ByteString(_loc_3, _loc_5);
                    _loc_23.readBytes(_loc_12, 0, _loc_5);
                    return _loc_12;
                }
                case 19:
                {
                    return null;
                }
                case 34:
                {
                    _loc_13 = new PrintableString(_loc_3, _loc_5);
                    _loc_13.setString(_loc_23.readMultiByte(_loc_5, "US-ASCII"));
                    return _loc_13;
                }
                case 20:
                case 23:
                {
                    _loc_13 = new PrintableString(_loc_3, _loc_5);
                    _loc_13.setString(_loc_23.readMultiByte(_loc_5, "latin1"));
                    return _loc_13;
                }
                case :
                {
                    _loc_14 = new UTCTime(_loc_3, _loc_5);
                    _loc_14.setUTCTime(_loc_23.readMultiByte(_loc_5, "US-ASCII"));
                    return _loc_14;
                    break;
                }
            }
        }// end function

        private static function getLengthOfNextElement(param1:ByteArray) : int
        {
            var _loc_4:* = 0;
            var _loc_2:* = param1.position;
            var _loc_5:* = param1;
            var _loc_6:* = _loc_5.position + 1;
            _loc_5.position = _loc_6;
            var _loc_3:* = _loc_5.readUnsignedByte();
            if (_loc_3 >= 128)
            {
                _loc_4 = _loc_3 & 127;
                _loc_3 = 0;
                while (_loc_4 > 0)
                {
                    
                    _loc_3 = _loc_3 << 8 | _loc_5.readUnsignedByte();
                    _loc_4 = _loc_4 - 1;
                }
            }
            _loc_3 = _loc_3 + (_loc_5.position - _loc_2);
            _loc_5.position = _loc_2;
            return _loc_3;
        }// end function

        private static function isConstructedType(param1:ByteArray) : Boolean
        {
            var _loc_2:* = param1[param1.position];
            return (_loc_2 & 32) != 0;
        }// end function

        public static function wrapDER(param1:int, param2:ByteArray) : ByteArray
        {
            var _loc_3:* = new ByteArray();
            _loc_3.writeByte(param1);
            var _loc_4:* = param2.length;
            if (param2.length < 128)
            {
                _loc_3.writeByte(_loc_4);
            }
            else if (_loc_4 < 256)
            {
                _loc_3.writeByte(1 | 128);
                _loc_3.writeByte(_loc_4);
            }
            else if (_loc_4 < 65536)
            {
                _loc_3.writeByte(2 | 128);
                _loc_3.writeByte(_loc_4 >> 8);
                _loc_3.writeByte(_loc_4);
            }
            else if (_loc_4 < 65536 * 256)
            {
                _loc_3.writeByte(3 | 128);
                _loc_3.writeByte(_loc_4 >> 16);
                _loc_3.writeByte(_loc_4 >> 8);
                _loc_3.writeByte(_loc_4);
            }
            else
            {
                _loc_3.writeByte(4 | 128);
                _loc_3.writeByte(_loc_4 >> 24);
                _loc_3.writeByte(_loc_4 >> 16);
                _loc_3.writeByte(_loc_4 >> 8);
                _loc_3.writeByte(_loc_4);
            }
            _loc_3.writeBytes(param2);
            _loc_3.position = 0;
            return _loc_3;
        }// end function

    }
}

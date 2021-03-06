/**
 * Autogenerated by Thrift Compiler (0.9.1)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */
using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using System.IO;
using Thrift;
using Thrift.Collections;
using System.Runtime.Serialization;
using Thrift.Protocol;
using Thrift.Transport;

namespace API
{

  #if !SILVERLIGHT
  [Serializable]
  #endif
  public partial class Bet : TBase
  {
    private long _amount;
    private BetType _type;
    private long _new_pot_size;

    public long Amount
    {
      get
      {
        return _amount;
      }
      set
      {
        __isset.amount = true;
        this._amount = value;
      }
    }

    /// <summary>
    /// 
    /// <seealso cref="BetType"/>
    /// </summary>
    public BetType Type
    {
      get
      {
        return _type;
      }
      set
      {
        __isset.type = true;
        this._type = value;
      }
    }

    public long New_pot_size
    {
      get
      {
        return _new_pot_size;
      }
      set
      {
        __isset.new_pot_size = true;
        this._new_pot_size = value;
      }
    }


    public Isset __isset;
    #if !SILVERLIGHT
    [Serializable]
    #endif
    public struct Isset {
      public bool amount;
      public bool type;
      public bool new_pot_size;
    }

    public Bet() {
    }

    public void Read (TProtocol iprot)
    {
      TField field;
      iprot.ReadStructBegin();
      while (true)
      {
        field = iprot.ReadFieldBegin();
        if (field.Type == TType.Stop) { 
          break;
        }
        switch (field.ID)
        {
          case 1:
            if (field.Type == TType.I64) {
              Amount = iprot.ReadI64();
            } else { 
              TProtocolUtil.Skip(iprot, field.Type);
            }
            break;
          case 2:
            if (field.Type == TType.I32) {
              Type = (BetType)iprot.ReadI32();
            } else { 
              TProtocolUtil.Skip(iprot, field.Type);
            }
            break;
          case 3:
            if (field.Type == TType.I64) {
              New_pot_size = iprot.ReadI64();
            } else { 
              TProtocolUtil.Skip(iprot, field.Type);
            }
            break;
          default: 
            TProtocolUtil.Skip(iprot, field.Type);
            break;
        }
        iprot.ReadFieldEnd();
      }
      iprot.ReadStructEnd();
    }

    public void Write(TProtocol oprot) {
      TStruct struc = new TStruct("Bet");
      oprot.WriteStructBegin(struc);
      TField field = new TField();
      if (__isset.amount) {
        field.Name = "amount";
        field.Type = TType.I64;
        field.ID = 1;
        oprot.WriteFieldBegin(field);
        oprot.WriteI64(Amount);
        oprot.WriteFieldEnd();
      }
      if (__isset.type) {
        field.Name = "type";
        field.Type = TType.I32;
        field.ID = 2;
        oprot.WriteFieldBegin(field);
        oprot.WriteI32((int)Type);
        oprot.WriteFieldEnd();
      }
      if (__isset.new_pot_size) {
        field.Name = "new_pot_size";
        field.Type = TType.I64;
        field.ID = 3;
        oprot.WriteFieldBegin(field);
        oprot.WriteI64(New_pot_size);
        oprot.WriteFieldEnd();
      }
      oprot.WriteFieldStop();
      oprot.WriteStructEnd();
    }

    public override string ToString() {
      StringBuilder sb = new StringBuilder("Bet(");
      sb.Append("Amount: ");
      sb.Append(Amount);
      sb.Append(",Type: ");
      sb.Append(Type);
      sb.Append(",New_pot_size: ");
      sb.Append(New_pot_size);
      sb.Append(")");
      return sb.ToString();
    }

  }

}

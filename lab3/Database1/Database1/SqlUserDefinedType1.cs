using System;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;
using System.IO;


[Serializable]
[Microsoft.SqlServer.Server.SqlUserDefinedType(Format.UserDefined, MaxByteSize = 8000)]
public struct SqlUserDefinedType1 : INullable, IBinarySerialize
{
    String City;
    String Street;
    String House;
    public override string ToString()
    {
        return "Адрес:";
    }
    
    public bool IsNull
    {
        get
        {
            return _null;
        }
    }
    
    public static SqlUserDefinedType1 Null
    {
        get
        {
            SqlUserDefinedType1 h = new SqlUserDefinedType1();
            h._null = true;
            return h;
        }
    }
    
    public static SqlUserDefinedType1 Parse(SqlString s)
    {
        string[] b = s.Value.Split(' ');
        if (s.IsNull)
            return Null;
        SqlUserDefinedType1 u = new SqlUserDefinedType1 { 
            City = b[0],
            Street = b[1],
            House = b[2]
        };
        return u;
    }
    
    public string Method1()
    {
        return string.Empty;
    }
    
    public static SqlString Method2()
    {
        return new SqlString("");
    }

    public void Read(BinaryReader r)
    {
        City = r.ReadString();
    }

    public void Write(BinaryWriter w)
    {
        w.Write($"Город - {City}, Улица - {Street}, Дом - {House}");
    }

    public int _var1;
 
    private bool _null;
}
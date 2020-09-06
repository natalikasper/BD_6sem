using System.Data;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using Microsoft.SqlServer.Server;

public partial class StoredProcedures
{
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static void AllOrders(SqlDateTime datastarta, SqlDateTime dataend)
    {
        SqlCommand command = new SqlCommand();
        command.Connection = new SqlConnection("Context connection = true");
        command.Connection.Open();
        string sql_string = "select * from orders where Date_order_start between @datastarta and @dataend and Date_order_end between @datastarta and @dataend;";
        command.CommandText = sql_string.ToString();
        SqlParameter param = command.Parameters.Add("@datastarta", SqlDbType.DateTime);
        param.Value = datastarta;
        param = command.Parameters.Add("@dataend", SqlDbType.DateTime);
        param.Value = dataend;
        SqlContext.Pipe.ExecuteAndSend(command);
        command.Connection.Close();
    }
}
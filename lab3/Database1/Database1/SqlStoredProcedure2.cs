using System.Data.SqlClient;
using Microsoft.SqlServer.Server;

public partial class StoredProcedures
{
    [Microsoft.SqlServer.Server.SqlProcedure]
    public static void SqlStoredProcedure2 ()
    {
        SqlCommand command = new SqlCommand
        {
            Connection = new SqlConnection("Context connection = true")
        };
        command.Connection.Open();
        string sql_string = $"select [Cost],[1],[2],[3] from (select 'Order cost' as 'Cost',Client,Cost_order from orders) x pivot(sum(Cost_order) for Client in ([1], [2], [3])) as pvt;";
        command.CommandText = sql_string.ToString();
        SqlContext.Pipe.ExecuteAndSend(command);
        command.Connection.Close();
    }
}
